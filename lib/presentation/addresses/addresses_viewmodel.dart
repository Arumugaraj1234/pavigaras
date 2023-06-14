import 'package:get/get.dart';
import 'package:pavigaras/presentation/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

import '../../app/app_prefs.dart';
import '../../domain/model/model.dart';
import '../controller/cart_controller.dart';

class AddressesViewModel extends BaseViewModel
    with AddressesViewModelInputs, AddressesViewModelOutputs {
  final _allDeliveryAddressesStreamController =
      BehaviorSubject<List<DeliveryAddress>>();
  CartController cartController = Get.find();
  final deleteAddressSuccessStreamController = BehaviorSubject<void>();

  final AppPreferences _appPreferences;

  AddressesViewModel(this._appPreferences);

  @override
  void start() {
    // _getAllDeliveryAddresses();
  }

  @override
  void dispose() {
    _allDeliveryAddressesStreamController.close();
    super.dispose();
  }

  // @override
  // deleteAddress(DeliveryAddress address) async {
  //   popUpLoadingState();
  //   int customerId = await _appPreferences.customerId();
  //   int hotelId = SelectedRestaurant.restaurant?.hotel?.id ?? 0;
  //   UpdateAddressRequest request = UpdateAddressRequest(
  //       address.addressId,
  //       customerId,
  //       hotelId,
  //       address.fullAddress,
  //       address.postalCode,
  //       address.latitude,
  //       address.longitude,
  //       AddressUpdateType.DELETE);
  //   (await _updateAddressUseCase.execute(request)).fold((failure) {
  //     popUpErrorState(failure.message);
  //   }, (data) {
  //     hideState();
  //     deleteAddressSuccessStreamController.add(null);
  //   });
  // }

  // INPUTS

  @override
  Sink<List<DeliveryAddress>> get inputAllDeliveryAddresses =>
      _allDeliveryAddressesStreamController.sink;

  // OUTPUTS

  @override
  Stream<List<DeliveryAddress>> get outputAllDeliveryAddresses =>
      _allDeliveryAddressesStreamController.stream
          .map((allDeliveryAddresses) => allDeliveryAddresses);

  // PRIVATE FUNCTIONS

  // _getAllDeliveryAddresses() async {
  //   int customerId = await _appPreferences.customerId();
  //   int hotelId = SelectedRestaurant.restaurant?.hotel?.id ?? 0;
  //   GetAllDeliveryAddressesRequest request =
  //       GetAllDeliveryAddressesRequest(customerId, hotelId);
  //   fullScreenLoadingStateFullScreen("Fetching address..");
  //   (await _addressesUseCase.execute(request)).fold((failure) {
  //     fullScreenErrorStateFullScreen(failure.message);
  //   }, (data) {
  //     hideStateFullScreen();
  //     List<DeliveryAddress> addresses = data.addresses ?? [];
  //     inputAllDeliveryAddresses.add(addresses);
  //     if (addresses.isNotEmpty) {
  //       cartController.setDeliveryAddressId(addresses[0].addressId);
  //       cartController.setDeliveryAddress(addresses[0]);
  //     }
  //   });
  // }
}

abstract class AddressesViewModelInputs {
  Sink<List<DeliveryAddress>> get inputAllDeliveryAddresses;
  // deleteAddress(DeliveryAddress address);
  start();
}

abstract class AddressesViewModelOutputs {
  Stream<List<DeliveryAddress>> get outputAllDeliveryAddresses;
}
