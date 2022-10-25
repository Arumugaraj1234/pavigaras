import 'package:dio/dio.dart';
import 'package:pavigaras/app/constants.dart';
import 'package:pavigaras/data/responses/responses.dart';
import 'package:retrofit/http.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio) = _AppServiceClient;

  @POST("Init")
  Future<InitResponse> init();

  @POST("GetLoginOTP")
  Future<RequestOtpResponse> requestOtp(@Field("Phone") int mobileNo);

  @POST("GetProducts")
  Future<GetProductsResponse> getProducts(@Field("CustomerId") int userId);
}
