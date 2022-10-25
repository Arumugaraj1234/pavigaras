import 'package:dartz/dartz.dart';
import 'package:pavigaras/data/network/error_handler.dart';
import 'package:pavigaras/domain/model/model.dart';
import 'package:pavigaras/domain/repository/repository.dart';
import 'package:pavigaras/domain/usecase/base_usecase.dart';

class InitUseCase extends BaseUseCase<void, Init> {
  final Repository _repository;

  InitUseCase(this._repository);

  @override
  Future<Either<Failure, Init>> execute(void request) async {
    return _repository.init();
  }
}
