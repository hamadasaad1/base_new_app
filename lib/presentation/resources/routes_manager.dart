import 'package:attendance/presentation/main/view/main_view.dart';
import 'package:attendance/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';


import '../../app/dit.dart';

import '../splash/splash_view.dart';

class Routes {
  static const String splashRoute = '/';

  static const String mainRoute = '/main';

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());

      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => MainView());


      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
