import 'package:get/get.dart';
import 'package:pavigaras/domain/model/model.dart';

class CartController extends GetxController {
  final _cartProducts = <Product>[].obs;
  final _uniqueCartProducts = <Product>[].obs;
  final _subTotalPrice = 0.0.obs;
  final _deliveryCharge = 0.0.obs;
  final _grandTotal = 0.0.obs;

  List<Product> get uniqueCartProducts => _uniqueCartProducts;
  List<Product> get cartProducts => _cartProducts;
  double get subTotalPrice => _subTotalPrice.value;
  double get deliveryCharge => _deliveryCharge.value;
  double get grandTotal => _grandTotal.value;

  // Output

  /// Unique products count in cart
  int noOfProductsInCart() {
    final result = _cartProducts.fold(
        <int, int>{},
        (Map<int, int> map, item) =>
            map..update(item.sizeId, (count) => count + 1, ifAbsent: () => 1));

    return result.keys.toList().length;
  }

  /// Count of particular product
  int noOfGivenProductInCart(Product product) =>
      _cartProducts.where((p) => p.sizeId == product.sizeId).length;

  /// Total amount of products in cart
  double totalCartValue() => _cartProducts.fold(0, (p, c) => p + c.sellingRate);

  // Inputs

  void addProductToCart(Product product) {
    _cartProducts.add(product);
    _getCartProducts();
    _calculatePriceSubTotal();
    _calculatePriceGrandTotal();
  }

  void removeProductFromCart(Product product) {
    /// Find the last index of the product in cart
    int lastIndexOfGivenProduct = _cartProducts.lastIndexOf(product);
    _cartProducts.removeAt(lastIndexOfGivenProduct);
    _getCartProducts();
    _calculatePriceSubTotal();
    _calculatePriceGrandTotal();
  }

  void _getCartProducts() {
    List<Product> productInCarts = [];

    for (Product product in _cartProducts) {
      if (productInCarts.isEmpty) {
        productInCarts.add(product);
      } else {
        int index =
            productInCarts.indexWhere((element) => element.id == product.id);
        if (index == -1) {
          productInCarts.add(product);
        }
      }
    }
    _uniqueCartProducts.value = productInCarts;
  }

  void _calculatePriceSubTotal() {
    _subTotalPrice.value = _cartProducts.isNotEmpty
        ? _cartProducts
            .map((element) => element.actualRate)
            .reduce((value, element) => value + element)
        : 0;
  }

  void _calculatePriceGrandTotal() {
    _grandTotal.value = _subTotalPrice.value + _deliveryCharge.value;
  }
}
