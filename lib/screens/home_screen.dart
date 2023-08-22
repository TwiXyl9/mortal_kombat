import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mortal_combat/config/routes_names.dart';
import 'package:mortal_combat/helpers/navigation_helper.dart';
import 'package:mortal_combat/locator.dart';
import 'package:mortal_combat/widgets/components/custom_rounded_button.dart';

import '../models/character/character.dart';
import '../widgets/characters/character_dialog.dart';
import '../widgets/characters/characters_listview.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Mortal Kombat Wiki", style: TextStyle(fontSize: 25),),
            CustomRoundedButton(
                onPressed: () {
                  locator<NavigationHelper>().navigateTo(charactersRoute);
                },
                text: "Characters",
            ),
          ],
        ),
      )

    );
  }
}