import 'package:dartz/dartz.dart';
import 'package:pavigaras/data/network/error_handler.dart';
import 'package:pavigaras/data/request/request.dart';
import 'package:pavigaras/domain/model/model.dart';
import 'package:pavigaras/domain/repository/repository.dart';
import 'package:pavigaras/domain/usecase/base_usecase.dart';

class RequestOtpUseCase extends BaseUseCase<RequestOtpRequest, RequestOtp> {
  final Repository _repository;
  RequestOtpUseCase(this._repository);

  @override
  Future<Either<Failure, RequestOtp>> execute(RequestOtpRequest request) {
    return _repository.requestOtp(request);
  }
}
