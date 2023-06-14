import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pavigaras/app/app_prefs.dart';
import 'package:pavigaras/data/data_source/local_data_source.dart';
import 'package:pavigaras/data/data_source/remote_data_source.dart';
import 'package:pavigaras/data/network/app_api.dart';
import 'package:pavigaras/data/network/dio_factory.dart';
import 'package:pavigaras/data/network/network.dart';
import 'package:pavigaras/domain/repository/repository.dart';
import 'package:pavigaras/domain/usecase/get_products_usecase.dart';
import 'package:pavigaras/domain/usecase/init_usecase.dart';
import 'package:pavigaras/domain/usecase/request_otp_usecase.dart';
import 'package:pavigaras/presentation/addresses/addresses_viewmodel.dart';
import 'package:pavigaras/presentation/home/home_viewmodel.dart';
import 'package:pavigaras/presentation/request_otp/request_otp_viewmodel.dart';
import 'package:pavigaras/presentation/search/search_viewmodel.dart';
import 'package:pavigaras/presentation/shops/shops_viewmodel.dart';
import 'package:pavigaras/presentation/splash/splash_viewmodel.dart';
import 'package:pavigaras/presentation/verify_otp/verify_otp_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/cart/cart_viewmodel.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  instance.registerLazySingleton<DioFactory>(() => DioFactory());
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));
  instance.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImplementer());
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImplementer(InternetConnectionChecker()));
  instance.registerLazySingleton<Repository>(
      () => RepositoryImplementer(instance(), instance(), instance()));
}

initModule() {
  bool isInitUseCaseRegistered = GetIt.I.isRegistered<InitUseCase>();
  if (!isInitUseCaseRegistered) {
    instance.registerFactory<InitUseCase>(() => InitUseCase(instance()));
  }

  bool isSplashViewModelRegistered = GetIt.I.isRegistered<SplashViewModel>();
  if (!isSplashViewModelRegistered) {
    instance
        .registerFactory<SplashViewModel>(() => SplashViewModel(instance()));
  }
}

initRequestOtpModule() {
  bool isRequestOtpUseCaseRegistered =
      GetIt.I.isRegistered<RequestOtpUseCase>();
  if (!isRequestOtpUseCaseRegistered) {
    instance.registerFactory<RequestOtpUseCase>(
        () => RequestOtpUseCase(instance()));
  }

  bool isRequestOtpViewModelRegistered =
      GetIt.I.isRegistered<RequestOtpViewModel>();
  if (!isRequestOtpViewModelRegistered) {
    instance.registerFactory<RequestOtpViewModel>(
        () => RequestOtpViewModel(instance()));
  }
}

initVerifyOtpModule() {
  bool isRequestOtpUseCaseRegistered =
      GetIt.I.isRegistered<RequestOtpUseCase>();
  if (!isRequestOtpUseCaseRegistered) {
    instance.registerFactory<RequestOtpUseCase>(
        () => RequestOtpUseCase(instance()));
  }

  bool isVerifyViewModelRegistered = GetIt.I.isRegistered<VerifyOtpViewModel>();
  if (!isVerifyViewModelRegistered) {
    instance.registerFactory<VerifyOtpViewModel>(
        () => VerifyOtpViewModel(instance(), instance()));
  }
}

void initShopsModule() {
  bool isGetProductsUseCaseRegistered =
      GetIt.I.isRegistered<GetProductsUseCase>();

  if (!isGetProductsUseCaseRegistered) {
    instance.registerFactory<GetProductsUseCase>(
        () => GetProductsUseCase(instance()));
  }

  bool isShopsViewModelRegistered = GetIt.I.isRegistered<ShopsViewModel>();
  if (!isShopsViewModelRegistered) {
    instance.registerFactory<ShopsViewModel>(
        () => ShopsViewModel(instance(), instance()));
  }
}

initHomeModule() {
  bool isGetProductsUseCaseRegistered =
      GetIt.I.isRegistered<GetProductsUseCase>();

  if (!isGetProductsUseCaseRegistered) {
    instance.registerFactory<GetProductsUseCase>(
        () => GetProductsUseCase(instance()));
  }

  bool isHomeViewModelRegistered = GetIt.I.isRegistered<HomeViewModel>();
  if (!isHomeViewModelRegistered) {
    instance.registerFactory<HomeViewModel>(
        () => HomeViewModel(instance(), instance()));
  }
}

void initSearchModule() {
  bool isGetProductsUseCaseRegistered =
      GetIt.I.isRegistered<GetProductsUseCase>();

  if (!isGetProductsUseCaseRegistered) {
    instance.registerFactory<GetProductsUseCase>(
        () => GetProductsUseCase(instance()));
  }

  bool isSearchViewModelRegistered =
      GetIt.I.isRegistered<SearchItemViewModel>();

  if (!isSearchViewModelRegistered) {
    instance.registerFactory<SearchItemViewModel>(
        () => SearchItemViewModel(instance(), instance()));
  }
}

void initCartModule() {
  bool isCartViewModelRegistered = GetIt.I.isRegistered<CartViewModel>();
  if (!isCartViewModelRegistered) {
    instance.registerFactory<CartViewModel>(() => CartViewModel(instance()));
  }
}

void initAddressesModule() {
  bool isAddressesViewModelRegistered =
      GetIt.I.isRegistered<AddressesViewModel>();
  if (!isAddressesViewModelRegistered) {
    instance.registerFactory<AddressesViewModel>(
        () => AddressesViewModel(instance()));
  }
}
