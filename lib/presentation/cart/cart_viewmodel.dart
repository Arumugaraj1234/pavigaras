import 'package:get/get.dart';
import 'package:pavigaras/presentation/base/base_viewmodel.dart';
import 'package:pavigaras/presentation/resources/assets_manager.dart';

import '../../app/app_prefs.dart';
import '../../domain/model/model.dart';
import '../controller/cart_controller.dart';

class CartViewModel extends BaseViewModel with CartViewModelInputs {
  final AppPreferences _appPreferences;
  CartController cartController = Get.find();

  CartViewModel(this._appPreferences);

  //PlaceOrderObject _placeOrderObject = PlaceOrderObject([], null);

  final List<PaymentType> paymentMethods = [
    PaymentType(1, "Cash On Delivery", ImageAssets.payByCashIcon),
    PaymentType(2, "Card/UPI", ImageAssets.payByOnlineIcon)
  ];

  @override
  setPaymentTypeIndex(int index) {
    //_object = _object.copyWith(selectedPaymentTypeIndex: index);
    //inputSelectedPaymentTypeIndex.add(index);
  }

  // @override
  // placeOrder() async {
  //   if (_placeOrderObject.deliveryAddress != null) {
  //     popUpLoadingState();
  //     int customerId = await _appPreferences.customerId();
  //     int hotelId = SelectedRestaurant.restaurant?.hotel?.id ?? 0;
  //
  //     List<SelectedDishForPlaceOrder> selectedDishesForPlaceOrder = [];
  //     List<Dish> selectedDishes = cartController.selectedDishes;
  //
  //     for (var p in selectedDishes) {
  //       int indexAt = selectedDishesForPlaceOrder
  //           .indexWhere((element) => element.dish_id == p.id);
  //       if (indexAt >= 0) {
  //         selectedDishesForPlaceOrder[indexAt].qty++;
  //       } else {
  //         SelectedDishForPlaceOrder sP = SelectedDishForPlaceOrder(p.id, 1);
  //         selectedDishesForPlaceOrder.add(sP);
  //       }
  //     }
  //
  //     DeliveryAddress address = _placeOrderObject.deliveryAddress!;
  //
  //     String bookDate = DateTime.now().getDateAsReqFormat();
  //
  //     PlaceOrderRequest request = PlaceOrderRequest(
  //         hotelId,
  //         customerId,
  //         selectedDishesForPlaceOrder,
  //         1,
  //         address.fullAddress,
  //         address.postalCode,
  //         address.latitude,
  //         address.longitude,
  //         0.0,
  //         1,
  //         "",
  //         "",
  //         bookDate,
  //         1,
  //         0.0,
  //         0.0);
  //
  //     (await _placeOrderUseCase.execute(request)).fold((failure) {
  //       popUpErrorState(failure.message);
  //     }, (data) {
  //       popUpSuccessState("Success", data.message);
  //     });
  //   } else {
  //     popUpErrorState("Please select the delivery address");
  //   }
  // }

  // @override
  // setDeliveryAddress(DeliveryAddress? address) {
  //   _placeOrderObject = _placeOrderObject.copyWith(deliveryAddress: address);
  // }
  //

  // @override
  // setSelectedDishDetails(List<Dish> dishes) {
  //   _placeOrderObject = _placeOrderObject.copyWith(selectedDishes: dishes);
  // }

  @override
  void start() {
    // TODO: implement start
  }
}

abstract class CartViewModelInputs {
  setPaymentTypeIndex(int index);
  // placeOrder();
  // setSelectedDishDetails(List<Dish> dishes);
  // setDeliveryAddress(DeliveryAddress address);
}
