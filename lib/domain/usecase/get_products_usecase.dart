import 'package:dartz/dartz.dart';
import 'package:pavigaras/data/network/error_handler.dart';
import 'package:pavigaras/data/request/request.dart';
import 'package:pavigaras/domain/model/model.dart';
import 'package:pavigaras/domain/repository/repository.dart';
import 'package:pavigaras/domain/usecase/base_usecase.dart';

class GetProductsUseCase extends BaseUseCase<UserIdRequest, GetProducts> {
  final Repository _repository;
  GetProductsUseCase(this._repository);

  @override
  Future<Either<Failure, GetProducts>> execute(UserIdRequest request) {
    return _repository.getProducts(request);
  }
}
