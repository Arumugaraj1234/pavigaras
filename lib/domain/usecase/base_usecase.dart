import 'package:dartz/dartz.dart';
import 'package:pavigaras/data/network/error_handler.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In request);
}
