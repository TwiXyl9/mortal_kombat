import 'package:get_it/get_it.dart';

import 'helpers/navigation_helper.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => NavigationHelper());
}