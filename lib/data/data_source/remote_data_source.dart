import 'package:pavigaras/data/network/app_api.dart';
import 'package:pavigaras/data/request/request.dart';
import 'package:pavigaras/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<InitResponse> init();
  Future<RequestOtpResponse> requestOtp(RequestOtpRequest request);
  Future<GetProductsResponse> getProducts(UserIdRequest request);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<InitResponse> init() {
    return _appServiceClient.init();
  }

  @override
  Future<RequestOtpResponse> requestOtp(RequestOtpRequest request) {
    return _appServiceClient.requestOtp(request.mobileNo);
  }

  @override
  Future<GetProductsResponse> getProducts(UserIdRequest request) {
    return _appServiceClient.getProducts(request.userId);
  }
}
