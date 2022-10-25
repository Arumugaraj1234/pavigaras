import 'package:flutter/material.dart';
import 'package:pavigaras/app/di.dart';
import 'package:pavigaras/domain/model/model.dart';
import 'package:pavigaras/presentation/main_screen.dart';
import 'package:pavigaras/presentation/product/product.dart';
import 'package:pavigaras/presentation/product_group/product_group.dart';
import 'package:pavigaras/presentation/request_otp/request_otp.dart';
import 'package:pavigaras/presentation/resources/strings_manager.dart';
import 'package:pavigaras/presentation/splash/splash.dart';
import 'package:pavigaras/presentation/verify_otp/verify_otp.dart';

class Routes {
  static const String splashRoute = "/";
  static const String requestOtpRoute = "/requestOtpRoute";
  static const String verifyOtpRoute = "/verifyOtpRoute";
  static const String mainRoute = "/mainRoute";
  static const String homeRoute = "/homeRoute";
  static const String productGroupRoute = "/productGroupRoute";
  static const String productRoute = "/productRoute";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        initModule();
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.requestOtpRoute:
        initRequestOtpModule();
        return MaterialPageRoute(builder: (_) => const RequestOtpView());
      case Routes.verifyOtpRoute:
        initVerifyOtpModule();
        var requestOtp = routeSettings.arguments as RequestOtp;
        return MaterialPageRoute(builder: (_) => VerifyOtpView(requestOtp));
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case Routes.productGroupRoute:
        Category category = routeSettings.arguments as Category;
        return MaterialPageRoute(builder: (_) => ProductGroupView(category));
      case Routes.productRoute:
        ProductGroup productGroup = routeSettings.arguments as ProductGroup;
        return MaterialPageRoute(builder: (_) => ProductView(productGroup));
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    Widget noFoundPage = Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.pageNotFound),
      ),
      body: const Center(
        child: Text(AppStrings.pageNotFound),
      ),
    );

    return MaterialPageRoute(builder: (_) => noFoundPage);
  }
}
