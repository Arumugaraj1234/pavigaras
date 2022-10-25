import 'package:pavigaras/app/constants.dart';
import 'package:pavigaras/app/enumerations.dart';
import 'package:pavigaras/data/freezed_data_class/freezed_data_class.dart';
import 'package:pavigaras/data/request/request.dart';
import 'package:pavigaras/domain/model/model.dart';
import 'package:pavigaras/domain/usecase/request_otp_usecase.dart';
import 'package:pavigaras/presentation/base/base_viewmodel.dart';
import 'package:pavigaras/presentation/resources/strings_manager.dart';
import 'package:pavigaras/presentation/state_renderer/state_renderer_implementer.dart';
import 'package:pavigaras/app/extentions.dart';
import 'package:rxdart/rxdart.dart';

class RequestOtpViewModel extends BaseViewModel with RequestOtpViewModelInputs {
  final toastStreamController = BehaviorSubject<String>();
  final requestOtpSuccessStreamController = BehaviorSubject<RequestOtp>();

  RequestOtpObject _object = RequestOtpObject(AppConstants.emptyString);
  final RequestOtpUseCase _requestOtpUseCase;

  RequestOtpViewModel(this._requestOtpUseCase);

  // FUNCTIONS

  @override
  start() {}

  @override
  dispose() {
    super.dispose();
    toastStreamController.close();
    requestOtpSuccessStreamController.close();
  }

  @override
  setMobileNo(String mobileNo) {
    _object = _object.copyWith(mobileNo: mobileNo);
  }

  @override
  sendOtp() async {
    String mobileNo = _object.mobileNo;
    mobileNo = mobileNo.replaceAll(
        AppConstants.indianMobileCode, AppConstants.emptyString);
    if (mobileNo.isValidMobileNo()) {
      popUpLoadingState();
      RequestOtpRequest request = RequestOtpRequest(int.parse(mobileNo));
      (await _requestOtpUseCase.execute(request)).fold((failure) {
        popUpErrorState(failure.message);
      }, (data) {
        hideState();
        requestOtpSuccessStreamController.add(data);
      });
    } else {
      toastStreamController.add(AppStrings.mobileNoError);
    }
  }
}

abstract class RequestOtpViewModelInputs {
  setMobileNo(String mobileNo);
  sendOtp();
}
