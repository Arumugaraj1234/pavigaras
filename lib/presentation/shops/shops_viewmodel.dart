import 'package:pavigaras/app/app_prefs.dart';
import 'package:pavigaras/app/di.dart';
import 'package:pavigaras/data/request/request.dart';
import 'package:pavigaras/domain/usecase/get_products_usecase.dart';
import 'package:pavigaras/presentation/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/model/model.dart';

class ShopsViewModel extends BaseViewModel
    with ShopsViewModelInputs, ShopsViewModelOutputs {
  final _shopsStreamController = BehaviorSubject<List<Shop>>();
  final isOneShopOnlyStreamController = BehaviorSubject<bool>();

  final GetProductsUseCase _getProductsUseCase;
  final AppPreferences _appPreferences;

  ShopsViewModel(this._getProductsUseCase, this._appPreferences);

  @override
  void start() {
    _getProducts();
  }

  @override
  void dispose() {
    super.dispose();
    _shopsStreamController.close();
    isOneShopOnlyStreamController.close();
  }

  // INPUTS

  @override
  Sink<List<Shop>> get shopsInput => _shopsStreamController.sink;

  // OUTPUTS

  @override
  Stream<List<Shop>> get shopsOutput =>
      _shopsStreamController.stream.map((shops) => shops);

  // FUNCTIONS

  Future<void> _getProducts() async {
    fullScreenLoadingState("Fetching data...");
    int userId = await _appPreferences.userId();

    UserIdRequest request = UserIdRequest(userId);
    (await _getProductsUseCase.execute(request)).fold((failure) {
      fullScreenErrorState(failure.message);
    }, (data) {
      List<Shop> shops = data.shops;
      if (shops.isNotEmpty) {
        if (shops.length == 1) {
          hideFullScreenState();
          isOneShopOnlyStreamController.add(true);
        } else {
          shopsInput.add(shops);
        }
      } else {
        fullScreenEmptyState("No Shops Available");
      }
    });
  }
}

abstract class ShopsViewModelInputs {
  Sink<List<Shop>> get shopsInput;
}

abstract class ShopsViewModelOutputs {
  Stream<List<Shop>> get shopsOutput;
}
