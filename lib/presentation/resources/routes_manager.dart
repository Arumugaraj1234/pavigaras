import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pavigaras/app/di.dart';
import 'package:pavigaras/domain/model/model.dart';
import 'package:pavigaras/presentation/addresses/addresses.dart';
import 'package:pavigaras/presentation/main_screen.dart';
import 'package:pavigaras/presentation/product/product.dart';
import 'package:pavigaras/presentation/product_group/product_group.dart';
import 'package:pavigaras/presentation/request_otp/request_otp.dart';
import 'package:pavigaras/presentation/resources/strings_manager.dart';
import 'package:pavigaras/presentation/search_address/search_address.dart';
import 'package:pavigaras/presentation/shops/shops.dart';
import 'package:pavigaras/presentation/special_product/special_product.dart';
import 'package:pavigaras/presentation/splash/splash.dart';
import 'package:pavigaras/presentation/verify_otp/verify_otp.dart';

class Routes {
  static const String splashRoute = "/";
  static const String requestOtpRoute = "/requestOtpRoute";
  static const String verifyOtpRoute = "/verifyOtpRoute";
  static const String shopsRoute = "/shopsRoute";
  static const String mainRoute = "/mainRoute";
  static const String homeRoute = "/homeRoute";
  static const String productGroupRoute = "/productGroupRoute";
  static const String productRoute = "/productRoute";
  static const String specialProductRoute = "/specialProductRoute";
  static const String addressesRoute = "/addressesRoute";
  static const String searchAddressRoute = "/searchAddressRoute";
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
      case Routes.shopsRoute:
        initShopsModule();
        return MaterialPageRoute(builder: (_) => const ShopsView());
      case Routes.mainRoute:
        initHomeModule();
        initSearchModule();
        initCartModule();
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case Routes.productGroupRoute:
        Category category = routeSettings.arguments as Category;
        return MaterialPageRoute(builder: (_) => ProductGroupView(category));
      case Routes.productRoute:
        ProductGroup productGroup = routeSettings.arguments as ProductGroup;
        return MaterialPageRoute(builder: (_) => ProductView(productGroup));
      case Routes.specialProductRoute:
        Product product = routeSettings.arguments as Product;
        return MaterialPageRoute(
            builder: (_) => SpecialProductView(product: product));
      case Routes.addressesRoute:
        initAddressesModule();
        return MaterialPageRoute(builder: (_) => const AddressesView());
      case Routes.searchAddressRoute:
        initSearchAddressModule();
        Position currentLocation = routeSettings.arguments as Position;
        return MaterialPageRoute(
            builder: (_) =>
                SearchAddressView(currentLocation: currentLocation));
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
