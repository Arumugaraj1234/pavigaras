import 'package:pavigaras/app/app_prefs.dart';
import 'package:pavigaras/app/enumerations.dart';
import 'package:pavigaras/data/request/request.dart';
import 'package:pavigaras/domain/model/model.dart';
import 'package:pavigaras/domain/usecase/get_products_usecase.dart';
import 'package:pavigaras/presentation/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  final _selectedVillageStreamController = BehaviorSubject<Village>();
  final _getProductsStateStreamController = BehaviorSubject<HomeDataState>();
  final _getProductsErrorMessageStreamController = BehaviorSubject<String>();
  final _getProductsStreamController = BehaviorSubject<GetProducts>();

  final AppPreferences _appPreferences;
  final GetProductsUseCase _getProductsUseCase;

  HomeViewModel(this._appPreferences, this._getProductsUseCase);

  @override
  void start() async {
    getProducts();
  }

  @override
  void dispose() {
    _selectedVillageStreamController.close();
    _getProductsStateStreamController.close();
    _getProductsErrorMessageStreamController.close();
    _getProductsStreamController.close();
    super.dispose();
  }

  /// INPUTS

  @override
  void setSelectedVillage(Village village) {
    inputSelectedVillage.add(village);
  }

  @override
  Sink<Village> get inputSelectedVillage =>
      _selectedVillageStreamController.sink;

  @override
  Sink<HomeDataState> get inputHomeState =>
      _getProductsStateStreamController.sink;

  @override
  Sink<String> get inputGetProductsErrorMessage =>
      _getProductsErrorMessageStreamController.sink;

  @override
  Sink<GetProducts> get inputProducts => _getProductsStreamController.sink;

  /// OUTPUTS

  @override
  Stream<Village> get outputSelectedVillage =>
      _selectedVillageStreamController.stream.map((village) => village);

  @override
  Stream<HomeDataState> get outputHomeState =>
      _getProductsStateStreamController.stream.map((homeState) => homeState);

  @override
  Stream<String> get outputGetProductsErrorMessage =>
      _getProductsErrorMessageStreamController.stream.map((error) => error);

  @override
  Stream<GetProducts> get outputProducts =>
      _getProductsStreamController.stream.map((products) => products);

  /// PRIVATE FUNCTIONS

  void getProducts() async {
    inputHomeState.add(HomeDataState.loading);
    int userId = await _appPreferences.userId();
    UserIdRequest request = UserIdRequest(userId);
    (await _getProductsUseCase.execute(request)).fold((failure) {
      inputGetProductsErrorMessage.add(failure.message);
      inputHomeState.add(HomeDataState.error);
    }, (data) {
      inputProducts.add(data);
      inputHomeState.add(HomeDataState.success);
    });
  }
}

abstract class HomeViewModelInputs {
  void setSelectedVillage(Village village);

  Sink<Village> get inputSelectedVillage;
  Sink<HomeDataState> get inputHomeState;
  Sink<String> get inputGetProductsErrorMessage;
  Sink<GetProducts> get inputProducts;
}

abstract class HomeViewModelOutputs {
  Stream<Village> get outputSelectedVillage;
  Stream<HomeDataState> get outputHomeState;
  Stream<String> get outputGetProductsErrorMessage;
  Stream<GetProducts> get outputProducts;
}
