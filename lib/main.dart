import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mortal_combat/config/routes_names.dart';
import 'package:mortal_combat/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'firebase_options.dart';
import 'helpers/navigation_helper.dart';

@pragma("vm:entry-point")
Future<void> backgroundCallback(Uri? uri) async {
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HomeWidget.setAppGroupId("mk_widget");
  HomeWidget.registerBackgroundCallback(backgroundCallback);
  HomeWidget.initiallyLaunchedFromHomeWidget();
  setupLocator();
  runApp(
      const ProviderScope(
          child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Mortal Kombat',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      routerConfig: locator<NavigationHelper>().router,
    );
  }
}