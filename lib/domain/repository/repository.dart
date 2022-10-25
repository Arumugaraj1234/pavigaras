import 'package:dartz/dartz.dart';
import 'package:pavigaras/app/enumerations.dart';
import 'package:pavigaras/data/data_source/local_data_source.dart';
import 'package:pavigaras/data/data_source/remote_data_source.dart';
import 'package:pavigaras/data/mapper/mapper.dart';
import 'package:pavigaras/data/network/error_handler.dart';
import 'package:pavigaras/data/network/network.dart';
import 'package:pavigaras/data/request/request.dart';
import 'package:pavigaras/data/responses/responses.dart';
import 'package:pavigaras/domain/model/model.dart';

abstract class Repository {
  Future<Either<Failure, Init>> init();
  Future<Either<Failure, RequestOtp>> requestOtp(RequestOtpRequest request);
  Future<Either<Failure, GetProducts>> getProducts(UserIdRequest request);
}

class RepositoryImplementer implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImplementer(
      this._remoteDataSource, this._localDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Init>> init() async {
    try {
      InitResponse response = await _localDataSource.init();
      return Right(response.doMap());
    } catch (cacheError) {
      bool isNetworkConnected = await _networkInfo.isConnected;
      if (isNetworkConnected) {
        try {
          InitResponse response = await _remoteDataSource.init();
          if (response.status == AppInternalStatus.success) {
            _localDataSource.saveInitToCache(response);
            return Right(response.doMap());
          }
          return Left(Failure(response.status ?? AppInternalStatus.failed,
              response.message ?? ResponseMessage.defaultStatus));
        } catch (e) {
          return Left(ErrorHandler.handle(e).failure);
        }
      }
      return Left(RemoteDataResponseStatus.noInternetConnection.failure());
    }
  }

  @override
  Future<Either<Failure, RequestOtp>> requestOtp(
      RequestOtpRequest request) async {
    bool isNetworkConnected = await _networkInfo.isConnected;
    if (isNetworkConnected) {
      try {
        RequestOtpResponse response =
            await _remoteDataSource.requestOtp(request);
        if (response.status == AppInternalStatus.success ||
            response.status == 2) {
          return Right(response.doMap());
        }
        return Left(Failure(response.status ?? AppInternalStatus.failed,
            response.message ?? ResponseMessage.defaultStatus));
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    }
    return Left(RemoteDataResponseStatus.noInternetConnection.failure());
  }

  @override
  Future<Either<Failure, GetProducts>> getProducts(
      UserIdRequest request) async {
    bool isNetworkConnected = await _networkInfo.isConnected;
    if (isNetworkConnected) {
      try {
        GetProductsResponse response =
            await _remoteDataSource.getProducts(request);
        if (response.status == AppInternalStatus.success) {
          return Right(response.doMap());
        }
        return Left(Failure(response.status ?? AppInternalStatus.failed,
            response.message ?? ResponseMessage.defaultStatus));
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    }
    return Left(RemoteDataResponseStatus.noInternetConnection.failure());
  }
}
