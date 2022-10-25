import 'package:pavigaras/app/app_prefs.dart';
import 'package:pavigaras/app/constants.dart';
import 'package:pavigaras/app/extentions.dart';
import 'package:pavigaras/data/freezed_data_class/freezed_data_class.dart';
import 'package:pavigaras/data/request/request.dart';
import 'package:pavigaras/domain/model/model.dart';
import 'package:pavigaras/domain/usecase/request_otp_usecase.dart';
import 'package:pavigaras/presentation/base/base_viewmodel.dart';
import 'package:pavigaras/presentation/resources/strings_manager.dart';
import 'package:rxdart/rxdart.dart';

class VerifyOtpViewModel extends BaseViewModel with VerifyOtpViewModelInputs {
  final toastStreamController = BehaviorSubject<String>();
  final verifyOtpSuccessStreamController = BehaviorSubject<void>();
  final requestOtpSuccessStreamController = BehaviorSubject<void>();
  VerifyOtpObject _object = VerifyOtpObject(null, AppConstants.emptyString);

  final AppPreferences _appPreferences;
  final RequestOtpUseCase _requestOtpUseCase;
  VerifyOtpViewModel(this._appPreferences, this._requestOtpUseCase);

  @override
  start() {}

  @override
  void dispose() {
    super.dispose();
    toastStreamController.close();
    verifyOtpSuccessStreamController.close();
    requestOtpSuccessStreamController.close();
  }

  // INPUTS

  @override
  setOtp(String otp) {
    _object = _object.copyWith(otp: otp);
  }

  @override
  setRequestOtpData(RequestOtp requestOtp) {
    _object = _object.copyWith(requestOtp: requestOtp);
  }

  @override
  verifyOtp() {
    String otp = _object.otp;
    String serverOtp = (_object.requestOtp?.data?.otpCode ?? 0).toString();
    if (otp.isValidOtp()) {
      if (otp == serverOtp) {
        _appPreferences.setUserLoggedIn();
        _appPreferences.setUserId(_object.requestOtp?.data?.customerId ?? 0);
        _appPreferences.setUserName(
            _object.requestOtp?.data?.fullName ?? AppConstants.emptyString);
        verifyOtpSuccessStreamController.add(null);
      } else {
        popUpErrorState(AppStrings.otpMismatchError);
      }
    } else {
      toastStreamController.add(AppStrings.otpError);
    }
  }

  @override
  void resendOtp() async {
    popUpLoadingState();
    int mobileNo = _object.requestOtp?.data?.mobileNumber ?? 0;
    RequestOtpRequest request = RequestOtpRequest(mobileNo);
    (await _requestOtpUseCase.execute(request)).fold((failure) {
      popUpErrorState(failure.message);
    }, (data) {
      hideState();
      popUpSuccessState(AppStrings.otpSent, data.message);
      _object = _object.copyWith(requestOtp: data);
      requestOtpSuccessStreamController.add(null);
    });
  }
}

abstract class VerifyOtpViewModelInputs {
  void setRequestOtpData(RequestOtp requestOtp);
  void setOtp(String otp);
  void verifyOtp();
  void resendOtp();
}
