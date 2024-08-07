import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String homeRoute = "/home";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
      // return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.homeRoute:
      // return MaterialPageRoute(builder: (_) => HomeView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text(""
              // AppStrings.strNoRouteFound(context),
              ),
        ),
        body: Center(
          child: Text(""
              // AppStrings.strNoRouteFound.tr(context),
              ),
        ),
      ),
    );
  }
}
