import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:pavigaras/app/di.dart';
import 'package:pavigaras/app/enumerations.dart';
import 'package:pavigaras/app/functions.dart';
import 'package:pavigaras/domain/model/model.dart';
import 'package:pavigaras/presentation/resources/assets_manager.dart';
import 'package:pavigaras/presentation/resources/colors_manager.dart';
import 'package:pavigaras/presentation/resources/font_manager.dart';
import 'package:pavigaras/presentation/resources/routes_manager.dart';
import 'package:pavigaras/presentation/resources/strings_manager.dart';
import 'package:pavigaras/presentation/resources/styles_manager.dart';
import 'package:pavigaras/presentation/resources/values_manager.dart';
import 'package:pavigaras/presentation/state_renderer/state_renderer_implementer.dart';
import 'package:pavigaras/presentation/verify_otp/verify_otp_viewmodel.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtpView extends StatefulWidget {
  final RequestOtp requestOtp;
  const VerifyOtpView(this.requestOtp, {Key? key}) : super(key: key);

  @override
  _VerifyOtpViewState createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  final _otpTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _comingSms;
  final _viewModel = instance<VerifyOtpViewModel>();

  _bind() {
    _initSmsListener();
    _viewModel.setRequestOtpData(widget.requestOtp);
    _otpTextEditingController.addListener(() {
      _viewModel.setOtp(_otpTextEditingController.text);
    });
    _viewModel.toastStreamController.listen((message) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        AppFunctions.displayWarningMotionToast(
            message: message, context: context);
      });
    });
    _viewModel.verifyOtpSuccessStreamController.listen((_) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.mainRoute, (route) => false);
      });
    });

    _viewModel.requestOtpSuccessStreamController.listen((_) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        _initSmsListener();
      });
    });
  }

  _dispose() {
    AltSmsAutofill().unregisterListener();
  }

  Future<void> _initSmsListener() async {
    String? sms;
    try {
      sms = await AltSmsAutofill().listenForSms;
    } on PlatformException {
      sms = '';
    }
    if (!mounted) return;

    if (sms != null && sms.isNotEmpty) {
      setState(() {
        _comingSms = sms!.replaceAll(RegExp(r'[^0-9]'), '');
        _otpTextEditingController.text = _comingSms!;
      });
    }
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
                    if (action == StateRendererAction.success) {
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
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: SingleChildScrollView(
      child: SizedBox(
        height: height,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ListTile(
                leading: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: ColorManager.white,
                    size: AppSize.s25,
                  ),
                ),
                title: Text(
                  AppStrings.enterVerificationCode,
                  style: getRegularStyle(
                      color: ColorManager.white, fontSize: FontSize.f20),
                ),
              ),
              Expanded(
                  flex: FlexSize.flex2,
                  child: Center(
                    child: Image.asset(ImageAssets.verifyOtpBg),
                  )),
              Expanded(
                  flex: FlexSize.flex3,
                  child: Column(
                    children: [
                      Text(
                        AppStrings.haveSendOtpYourPhoneNumber,
                        style: getRegularStyle(color: ColorManager.white),
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      SizedBox(
                        width: AppSize.s280,
                        child: PinCodeTextField(
                          appContext: context,
                          enableActiveFill: true,
                          enablePinAutofill: true,
                          pastedTextStyle:
                              getRegularStyle(fontSize: FontSize.f22),
                          length: 4,
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          validator: (v) {
                            return null;
                          },
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(AppSize.s10),
                            activeColor: ColorManager.white,
                            disabledColor: ColorManager.primaryOpacity70,
                            errorBorderColor: ColorManager.error,
                            inactiveColor: ColorManager.primaryOpacity70,
                            inactiveFillColor: Colors.white24,
                            //inactiveFillColor: Colors.yellowAccent,
                            fieldHeight: AppSize.s60,
                            fieldWidth: AppSize.s60,
                            activeFillColor: Colors.grey.shade100,
                            selectedColor: ColorManager.darkGrey,
                            selectedFillColor: ColorManager.white,
                          ),
                          cursorColor: ColorManager.primary,
                          animationDuration: DurationManager.milliSeconds300,
                          errorAnimationController: null,
                          controller: _otpTextEditingController,
                          keyboardType: TextInputType.number,
                          onCompleted: (v) {},
                          onChanged: (value) {},
                          beforeTextPaste: (text) {
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                          text: AppStrings.didNotReceiveOtp + "  ",
                          style: getLightStyle(color: ColorManager.white),
                          children: <TextSpan>[
                            TextSpan(
                                text: AppStrings.resendOtp,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    _viewModel.resendOtp();
                                  },
                                style: getBoldStyle(
                                    color: ColorManager.darkPrimary,
                                    fontSize: FontSize.f20)),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: AppSize.s30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p20),
                        child: SizedBox(
                          width: width - AppSize.s40,
                          height: AppSize.s50,
                          child: ElevatedButton(
                              onPressed: () {
                                _viewModel.verifyOtp();
                              },
                              child: const Text(AppStrings.submit)),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
