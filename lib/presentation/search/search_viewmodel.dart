import 'package:pavigaras/app/enumerations.dart';
import 'package:pavigaras/domain/model/model.dart';
import 'package:pavigaras/presentation/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

import '../../app/app_prefs.dart';
import '../../data/request/request.dart';
import '../../domain/usecase/get_products_usecase.dart';

class SearchItemViewModel extends BaseViewModel
    with SearchItemViewModelInputs, SearchItemViewModelOutputs {
  final _searchResultsStreamController = BehaviorSubject<List<Product>>();
  List<Product> _allProductList = [];

  final AppPreferences _appPreferences;
  final GetProductsUseCase _getProductsUseCase;

  SearchItemViewModel(this._appPreferences, this._getProductsUseCase);

  @override
  void start() {
    _getProducts();
  }

  @override
  void dispose() {
    super.dispose();
    _searchResultsStreamController.close();
  }

  // Inputs
  @override
  void searchTextChanged(String value) {
    print(value);
    List<Product> searchResults = [];

    if (value.isNotEmpty) {
      searchResults = _allProductList
          .where((element) => element.hintsToSearch.contains(value))
          .toList();
    }

    inputSearchResults.add(searchResults);
  }

  @override
  Sink<List<Product>> get inputSearchResults =>
      _searchResultsStreamController.sink;

  // Outputs

  @override
  Stream<List<Product>> get outputSearchResults =>
      _searchResultsStreamController.stream
          .map((searchResults) => searchResults);

  // MARK:- PRIVATE FUNCTIONS

  void _getProducts() async {
    int userId = await _appPreferences.userId();
    UserIdRequest request = UserIdRequest(userId);
    (await _getProductsUseCase.execute(request)).fold((failure) {
      //todo: Show the error in toast
    }, (data) {
      final Shop sambarShop = data.shops
          .firstWhere((shop) => shop.id == ShopTypes.sambarKadai.id());
      List<Product> products = [];
      for (Category category in sambarShop.categories) {
        for (ProductGroup productGroup in category.productGroups) {
          for (Product product in productGroup.products) {
            products.add(product);
          }
        }
      }
      _allProductList = products;
    });
  }
}

abstract class SearchItemViewModelInputs {
  void start();
  void searchTextChanged(String value);

  Sink<List<Product>> get inputSearchResults;
}

abstract class SearchItemViewModelOutputs {
  Stream<List<Product>> get outputSearchResults;
}
