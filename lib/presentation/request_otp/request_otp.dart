import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:pavigaras/app/di.dart';
import 'package:pavigaras/app/enumerations.dart';
import 'package:pavigaras/app/functions.dart';
import 'package:pavigaras/presentation/request_otp/request_otp_viewmodel.dart';
import 'package:pavigaras/presentation/resources/assets_manager.dart';
import 'package:pavigaras/presentation/resources/colors_manager.dart';
import 'package:pavigaras/presentation/resources/routes_manager.dart';
import 'package:pavigaras/presentation/resources/strings_manager.dart';
import 'package:pavigaras/presentation/resources/styles_manager.dart';
import 'package:pavigaras/presentation/resources/values_manager.dart';
import 'package:pavigaras/presentation/state_renderer/state_renderer_implementer.dart';
import 'package:sms_autofill/sms_autofill.dart';

class RequestOtpView extends StatefulWidget {
  const RequestOtpView({Key? key}) : super(key: key);

  @override
  _RequestOtpViewState createState() => _RequestOtpViewState();
}

class _RequestOtpViewState extends State<RequestOtpView> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberTextEditingController = TextEditingController();
  final _opacityPercentage = 0.20;
  final _viewModel = instance<RequestOtpViewModel>();

  _bind() {
    _viewModel.start();
    _phoneNumberTextEditingController.addListener(() {
      _viewModel.setMobileNo(_phoneNumberTextEditingController.text);
    });
    _viewModel.toastStreamController.listen((message) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        AppFunctions.displayWarningMotionToast(
            message: message, context: context);
      });
    });
    _viewModel.requestOtpSuccessStreamController.listen((requestOtp) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        int otp = requestOtp.data?.otpCode ?? 0;
        if (otp != 0) {
          Navigator.of(context)
              .pushNamed(Routes.verifyOtpRoute, arguments: requestOtp);
        }
      });
    });
  }

  _dispose() {
    _phoneNumberTextEditingController.dispose();
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
          body: _content(context),
        ),
        StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data?.getWidget(context, (action) {
                    if (action == StateRendererAction.ok) {
                      _viewModel.hideState();
                    }
                  }) ??
                  Container();
            })
      ],
    );
  }

  _content(BuildContext context) {
    double height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewPadding.top;
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: ColorManager.white,
          height: height,
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                        child: Container(
                      width: double.infinity,
                      color: ColorManager.primary,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: AppPadding.p100, top: AppPadding.p20),
                        child: Image.asset(ImageAssets.sendOtpIll),
                      ),
                    )),
                    Expanded(
                        child: Container(
                      color: Colors.black.withOpacity(_opacityPercentage),
                      child: Column(
                        children: [
                          Expanded(child: Container()),
                          Image.asset(ImageAssets.bottomWave)
                        ],
                      ),
                    )),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: (height * (2 / 5)), child: Container()),
                    SizedBox(
                        height: (height * (2 / 5)),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p20),
                          decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.circular(AppSize.s15),
                              boxShadow: [
                                BoxShadow(
                                    color: ColorManager.lightGrey,
                                    offset: const Offset(0, 0),
                                    spreadRadius: 0,
                                    blurRadius: 3)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: AppPadding.p40,
                                right: AppPadding.p15,
                                left: AppPadding.p15,
                                top: AppPadding.p15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    AppStrings.enterMobileNo,
                                    style: getBoldStyle(),
                                  ),
                                ),
                                const SizedBox(
                                  height: AppSize.s10,
                                ),
                                PhoneFieldHint(
                                  controller: _phoneNumberTextEditingController,
                                  decoration: const InputDecoration(
                                      hintText:
                                          AppStrings.enterMobileNoPlaceHolder),
                                ),
                                const SizedBox(
                                  height: AppSize.s10,
                                ),
                                Text(
                                  AppStrings.otpSmsInst,
                                  style: getRegularStyle(),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )),
                    SizedBox(height: (height * (1 / 5)), child: Container())
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(height: (height * (2 / 5)), child: Container()),
                      SizedBox(
                          height: (height * (2 / 5)) - 50, child: Container()),
                      InkWell(
                        onTap: () {
                          _viewModel.sendOtp();
                        },
                        child: Container(
                          height: AppSize.s80,
                          width: AppSize.s80,
                          decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.circular(AppSize.s40)),
                          child: Container(
                            height: AppSize.s80,
                            width: AppSize.s80,
                            decoration: BoxDecoration(
                                color: Colors.black
                                    .withOpacity(_opacityPercentage),
                                borderRadius:
                                    BorderRadius.circular(AppSize.s40)),
                            child: Center(
                              child: Container(
                                height: AppSize.s60,
                                width: AppSize.s60,
                                decoration: BoxDecoration(
                                    color: ColorManager.primary,
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s30)),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_forward,
                                    size: AppSize.s25,
                                    color: ColorManager.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Center(
                        child: RichText(
                          text: TextSpan(
                            text: AppStrings.acceptTermsInst,
                            style: getRegularStyle(),
                            children: <TextSpan>[
                              TextSpan(
                                  text: AppStrings.termsAndConditions,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      //todo: Redirect user to Terms & Condition
                                    },
                                  style: getSemiBoldStyle(
                                      color: ColorManager.darkPrimary)),
                              TextSpan(
                                  text: AppStrings.and,
                                  style: getRegularStyle()),
                              TextSpan(
                                  text: AppStrings.privacyPolicy,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      //todo: redirect user to privacy policy
                                    },
                                  style: getSemiBoldStyle(
                                      color: ColorManager.darkPrimary)),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
