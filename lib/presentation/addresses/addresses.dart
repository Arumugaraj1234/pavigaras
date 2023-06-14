import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pavigaras/app/di.dart';
import 'package:pavigaras/app/functions.dart';
import 'package:pavigaras/presentation/addresses/addresses_viewmodel.dart';
import 'package:pavigaras/presentation/resources/assets_manager.dart';
import 'package:pavigaras/presentation/resources/colors_manager.dart';
import 'package:pavigaras/presentation/resources/font_manager.dart';
import 'package:pavigaras/presentation/resources/strings_manager.dart';
import 'package:pavigaras/presentation/resources/values_manager.dart';

import '../../domain/model/model.dart';
import '../controller/cart_controller.dart';
import '../resources/styles_manager.dart';
import '../state_renderer/state_renderer_implementer.dart';

class AddressesView extends StatefulWidget {
  const AddressesView({Key? key}) : super(key: key);

  @override
  State<AddressesView> createState() => _AddressesViewState();
}

class _AddressesViewState extends State<AddressesView> {
  final _viewModel = instance<AddressesViewModel>();
  var isDialOpen = ValueNotifier<bool>(false);
  DeliveryAddress? selectedAddress;

  _bind() {
    _viewModel.start();
    _viewModel.deleteAddressSuccessStreamController.listen((_) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _viewModel.start();
      });
    });
  }

  _dispose() {
    _viewModel.dispose();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  Future<void> _requestLocationPermission() async {
    bool isLocationServiceEnabled;
    LocationPermission permission;

    isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationServiceEnabled) {
      AppFunctions.displayTopMotionToast(
          color: ColorManager.error,
          message: AppStrings.enableLocationService,
          context: context);
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        AppFunctions.displayTopMotionToast(
            color: ColorManager.error,
            message: AppStrings.locationPermission,
            context: context);
      } else if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        var currentLocation = await Geolocator.getCurrentPosition();

        // Navigator.of(context)
        //     .pushNamed(Routes.searchAddressRoute, arguments: currentLocation)
        //     .then((value) => _viewModel.start());
      }
    } else if (permission == LocationPermission.deniedForever) {
    } else if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      var currentLocation = await Geolocator.getCurrentPosition();
      // Navigator.of(context)
      //     .pushNamed(Routes.searchAddressRoute, arguments: currentLocation)
      //     .then((value) => _viewModel.start());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        }
        return true;
      },
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: ColorManager.white,
            floatingActionButton: SpeedDial(
              icon: Icons.add,
              backgroundColor: ColorManager.darkPrimary,
              overlayColor: ColorManager.black,
              overlayOpacity: 0.4,
              activeIcon: Icons.close,
              openCloseDial: isDialOpen,
              childPadding: const EdgeInsets.all(AppPadding.p5),
              spaceBetweenChildren: 4,
              children: [
                SpeedDialChild(
                    child: Icon(
                      Icons.search_off_outlined,
                      color: ColorManager.darkPrimary,
                    ),
                    backgroundColor: ColorManager.white,
                    labelBackgroundColor: ColorManager.white,
                    labelStyle: getRegularStyle(
                        color: ColorManager.black, fontSize: FontSize.f12),
                    label: AppStrings.searchLocation,
                    onTap: () {
                      _requestLocationPermission();
                    }),
                SpeedDialChild(
                    child: Icon(
                      Icons.list_alt_rounded,
                      color: ColorManager.darkPrimary,
                    ),
                    backgroundColor: ColorManager.white,
                    labelBackgroundColor: ColorManager.white,
                    labelStyle: getRegularStyle(
                        color: ColorManager.black, fontSize: FontSize.f12),
                    label: AppStrings.fillForm,
                    onTap: () {
                      // Navigator.of(context)
                      //     .pushNamed(Routes.manualAddressRoute)
                      //     .then((value) => _viewModel.start());
                    })
              ],
            ),
            body: Stack(
              children: [
                _content(context),
                StreamBuilder<FlowState>(
                    stream: _viewModel.outputFullScreenState,
                    builder: (context, snapshot) {
                      return snapshot.data?.getWidget(context, (action) {
                            _viewModel.start();
                          }) ??
                          const SizedBox();
                    })
              ],
            ),
          ),
          StreamBuilder<FlowState>(
              stream: _viewModel.outputState,
              builder: (context, snapshot) {
                return snapshot.data?.getWidget(context, (action) {}) ??
                    const SizedBox();
              })
        ],
      ),
    );
  }

  _content(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: AppSize.s10,
          ),
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: AppSize.s10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop(selectedAddress);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                    ),
                  ),
                ),
                Text(
                  AppStrings.addresses,
                  style: getSemiBoldStyle(
                      color: ColorManager.black, fontSize: FontSize.f20),
                ),
                const SizedBox(
                  width: AppSize.s5,
                ),
                Expanded(child: Container()),
              ]),
          const SizedBox(
            height: AppSize.s10,
          ),
          Expanded(
            child: StreamBuilder<List<DeliveryAddress>>(
                stream: _viewModel.outputAllDeliveryAddresses,
                builder: (context, snapshot) {
                  return (snapshot.data != null)
                      ? (snapshot.data!.isNotEmpty)
                          ? ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                DeliveryAddress address = snapshot.data![index];
                                return GetX<CartController>(
                                    builder: (getSnapShot) {
                                  // bool isSelected =
                                  //     (getSnapShot.deliveryAddressId ==
                                  //             address.addressId)
                                  //         ? true
                                  //         : false;
                                  bool isSelected = true;
                                  if (isSelected) {
                                    selectedAddress = address;
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      // getSnapShot.setDeliveryAddressId(
                                      //     address.addressId);
                                      // getSnapShot.setDeliveryAddress(address);
                                      // selectedAddress = address;
                                      // Navigator.of(context)
                                      //     .pop(selectedAddress);
                                    },
                                    child: Card(
                                      color: isSelected
                                          ? ColorManager.darkPrimary
                                          : ColorManager.lightGrey,
                                      elevation: AppSize.s10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(AppSize.s10),
                                      ),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: AppPadding.p10,
                                                vertical: AppPadding.p10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  address.fullAddress,
                                                  style: getRegularStyle(
                                                      color: isSelected
                                                          ? ColorManager.white
                                                          : ColorManager.black),
                                                ),
                                                Text(
                                                  address.postalCode,
                                                  style: getRegularStyle(
                                                      color: isSelected
                                                          ? ColorManager.white
                                                          : ColorManager.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                  // _viewModel
                                                  //     .deleteAddress(address);
                                                },
                                                child: Icon(
                                                  Icons.highlight_remove,
                                                  color: isSelected
                                                      ? ColorManager.white
                                                      : ColorManager.white,
                                                  size: AppSize.s25,
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              })
                          : Container(
                              color: ColorManager.white,
                              child: Column(
                                children: [
                                  Container(
                                    child: Lottie.asset(JsonAssets.empty),
                                  ),
                                  Text(
                                    AppStrings.noAddressAvailable,
                                    style:
                                        getBoldStyle(color: ColorManager.error),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: AppSize.s10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppPadding.p10),
                                    child: Text(
                                      AppStrings.noDeliveryAddressMessage,
                                      style: getRegularStyle(
                                          color: ColorManager.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            )
                      : Container();
                }),
          ),
        ],
      ),
    );
  }
}
