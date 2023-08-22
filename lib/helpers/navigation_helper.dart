import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mortal_combat/screens/characters_screen.dart';
import 'package:mortal_combat/screens/character_choose_screen.dart';

import '../config/routes_names.dart';
import '../screens/character_item_screen.dart';
import '../screens/home_screen.dart';

class NavigationHelper {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: rootRoute, builder: ((context, state) => const HomeScreen())),
      GoRoute(
          path: charactersRoute,
          builder: ((context, state) => const CharactersScreen()),
          routes: [
            GoRoute(
                name:"character",
                path: ":id",
                builder: ((context, state) {
                  final id = state.pathParameters['id'];
                  return CharacterItemScreen(id: id!,);
                })
            ),
          ]
      ),
      GoRoute(
          name: chooseCharacterRoute,
          path: chooseCharacterRoute,
          builder: ((context, state) {
            String widgetId = state.queryParameters['widgetId']!;
            String mode = state.queryParameters['mode']!;
            return CharacterChooseScreen(widgetId: widgetId, mode: mode);
          })
      ),
    ],
  );

  void navigateTo(String routeName, {data = null}){
    router.go(routeName, extra: data);
  }

  void navigateToWithParams(String routeName, Map<String, String> params){
    router.goNamed(routeName, pathParameters: params);
  }

  void goBack(){
    router.pop();
  }
}