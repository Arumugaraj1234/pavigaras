import 'package:pavigaras/app/app_prefs.dart';
import 'package:pavigaras/domain/model/model.dart';
import 'package:pavigaras/presentation/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/freezed_data_class/freezed_data_class.dart';

class SearchAddressViewModel extends BaseViewModel
    with SearchAddressViewModelInputs {
  final updateAddressSuccessStreamController = BehaviorSubject<void>();
  SearchAddressObject _searchAddressObject = SearchAddressObject(null, "");

  final AppPreferences _appPreferences;

  SearchAddressViewModel(this._appPreferences);

  @override
  void dispose() {
    updateAddressSuccessStreamController.close();
    super.dispose();
  }

  // @override
  // saveAddress() async {
  //   if (_searchAddressObject.googleAddress != null) {
  //     popUpLoadingState();
  //     int customerId = await _appPreferences.customerId();
  //     int hotelId = SelectedRestaurant.restaurant?.hotel?.id ?? 0;
  //     GoogleAddress address = _searchAddressObject.googleAddress!;
  //     String houseNo = _searchAddressObject.houseNo.isNotEmpty
  //         ? (_searchAddressObject.houseNo + ",")
  //         : "";
  //     String fullAddress = houseNo + address.formattedAddress;
  //     UpdateAddressRequest request = UpdateAddressRequest(
  //         0,
  //         customerId,
  //         hotelId,
  //         fullAddress,
  //         address.postalCodeLong,
  //         address.latitude,
  //         address.longitude,
  //         AddressUpdateType.ADD);
  //     (await _updateAddressUseCase.execute(request)).fold((failure) {
  //       popUpErrorState(failure.message);
  //     }, (data) {
  //       hideState();
  //       updateAddressSuccessStreamController.add(null);
  //     });
  //   }
  // }

  // INPUTS

  @override
  setAddress(GoogleAddress address) {
    _searchAddressObject =
        _searchAddressObject.copyWith(googleAddress: address);
  }

  @override
  setHouseNo(String houseNo) {
    _searchAddressObject = _searchAddressObject.copyWith(houseNo: houseNo);
  }

  @override
  void start() {
    // TODO: implement start
  }
}

abstract class SearchAddressViewModelInputs {
  setAddress(GoogleAddress address);
  setHouseNo(String houseNo);
  // saveAddress();
}
