import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pavigaras/app/constants.dart';
import 'package:pavigaras/app/enumerations.dart';
import 'package:pavigaras/presentation/resources/assets_manager.dart';
import 'package:pavigaras/presentation/resources/colors_manager.dart';
import 'package:pavigaras/presentation/resources/strings_manager.dart';
import 'package:pavigaras/presentation/resources/styles_manager.dart';
import 'package:pavigaras/presentation/resources/values_manager.dart';

// ignore: must_be_immutable
class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function(StateRendererAction action)? buttonFunction;

  StateRenderer(
      {Key? key,
      required this.stateRendererType,
      String? message,
      String? title,
      required this.buttonFunction})
      : message = message ?? AppStrings.loading,
        title = title ?? AppConstants.emptyString,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popUpLoading:
        return _getPopUpDialog(
            _getItemsInColumn([_lottieImage(JsonAssets.loading)]));
      case StateRendererType.popUpError:
        return _getPopUpDialog(_getItemsInColumn([
          _lottieImage(JsonAssets.error),
          _message(message),
          _button(AppStrings.ok, context, StateRendererAction.ok)
        ]));
      case StateRendererType.popUpSuccess:
        return _getPopUpDialog(_getItemsInColumn([
          _lottieImage(JsonAssets.success),
          _title(title),
          _message(message),
          _button(AppStrings.ok, context, StateRendererAction.success)
        ]));
      case StateRendererType.fullScreenLoading:
        return _getFullScreenState(_getItemsInColumn(
            [_lottieImage(JsonAssets.loading), _message(message)]));
      case StateRendererType.fullScreenError:
        return _getFullScreenState(_getItemsInColumn([
          _lottieImage(JsonAssets.error),
          _message(message),
          _button(AppStrings.retry, context, StateRendererAction.retry)
        ]));
      case StateRendererType.emptyScreen:
        return _getEmptyFullScreen(message);
      default:
        return Visibility(visible: false, child: Container());
    }
  }

  _getEmptyFullScreen(String message) {
    return Container(
      color: ColorManager.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: Lottie.asset(JsonAssets.empty)),
          Expanded(
            flex: 1,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
                child: Text(
                  message,
                  style: getRegularStyle(color: ColorManager.black)
                      .copyWith(decoration: TextDecoration.none),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _getFullScreenState(Widget content) {
    return Container(
      color: ColorManager.white,
      child: content,
    );
  }

  _getPopUpDialog(Widget content) {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Wrap(
          children: [
            Container(
              width: AppSize.s300,
              decoration: BoxDecoration(
                  color: ColorManager.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.white30,
                        blurRadius: AppSize.s12,
                        offset: Offset(AppSize.s0, AppSize.s12))
                  ]),
              child: Center(
                child: content,
              ),
            )
          ],
        ),
      ),
    );
  }

  _getItemsInColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: children,
      ),
    );
  }

  _lottieImage(String jsonAssetName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(jsonAssetName),
    );
  }

  _title(String title) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p10),
        child: Text(
          title,
          style: getBoldStyle(color: ColorManager.black)
              .copyWith(decoration: TextDecoration.none),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  _message(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p10),
        child: Text(
          message,
          style: getRegularStyle(color: ColorManager.black)
              .copyWith(decoration: TextDecoration.none),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  _button(
      String buttonTitle, BuildContext context, StateRendererAction action) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p10),
        child: SizedBox(
          width: AppSize.s200,
          child: ElevatedButton(
              onPressed: () {
                buttonFunction?.call(action);
              },
              child: Text(buttonTitle)),
        ),
      ),
    );
  }
}
