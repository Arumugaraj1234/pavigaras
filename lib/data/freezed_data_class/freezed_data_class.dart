import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pavigaras/domain/model/model.dart';
part 'freezed_data_class.freezed.dart';

@freezed
class RequestOtpObject with _$RequestOtpObject {
  factory RequestOtpObject(String mobileNo) = _RequestOtpObject;
}

@freezed
class VerifyOtpObject with _$VerifyOtpObject {
  factory VerifyOtpObject(RequestOtp? requestOtp, String otp) =
      _VerifyOtpObject;
}
