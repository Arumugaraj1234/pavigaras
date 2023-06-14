import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:pavigaras/app/app_prefs.dart';
import 'package:pavigaras/app/di.dart';
import 'package:pavigaras/app/enumerations.dart';
import 'package:pavigaras/presentation/resources/assets_manager.dart';
import 'package:pavigaras/presentation/resources/colors_manager.dart';
import 'package:pavigaras/presentation/resources/routes_manager.dart';
import 'package:pavigaras/presentation/resources/values_manager.dart';
import 'package:pavigaras/presentation/splash/splash_viewmodel.dart';
import 'package:pavigaras/presentation/state_renderer/state_renderer_implementer.dart';

import '../controller/cart_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _appPreferences = instance<AppPreferences>();
  final _viewModel = instance<SplashViewModel>();

  /// Initializing cart controller
  final CartController _cartController = Get.put(CartController());

  _goNext() async {
    bool isUserLoggedIn = await _appPreferences.isUserLoggedIn();
    if (isUserLoggedIn) {
      Navigator.of(context).pushReplacementNamed(Routes.shopsRoute);
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.requestOtpRoute);
    }
  }

  _bind() {
    _viewModel.start();
    _viewModel.initSuccessStreamController.listen((_) {
      _goNext();
    });
  }

  _dispose() {
    _viewModel.dispose();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: ColorManager.primary,
          body: const Center(
            child: Image(image: AssetImage(ImageAssets.appLogo)),
          ),
        ),
        StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data?.getWidget(context, (action) {
                    if (action == StateRendererType.fullScreenError) {
                      _viewModel.init();
                    }
                  }) ??
                  Container();
            })
      ],
    );
  }
}
