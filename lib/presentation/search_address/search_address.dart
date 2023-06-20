import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app_settings/app_settings.dart';
import 'package:pavigaras/app/di.dart';
import 'package:pavigaras/app/functions.dart';
import 'package:pavigaras/domain/model/model.dart';
import 'package:pavigaras/presentation/resources/assets_manager.dart';
import 'package:pavigaras/presentation/resources/colors_manager.dart';
import 'package:pavigaras/presentation/resources/font_manager.dart';
import 'package:pavigaras/presentation/resources/strings_manager.dart';
import 'package:pavigaras/presentation/resources/values_manager.dart';
import 'package:pavigaras/presentation/search_address/mapcontroller.dart';
import 'package:pavigaras/presentation/search_address/places_service.dart';
import 'package:pavigaras/presentation/search_address/search_address_viewmodel.dart';
import 'package:pavigaras/presentation/state_renderer/state_renderer_implementer.dart';

import '../resources/styles_manager.dart';

class SearchAddressView extends StatefulWidget {
  final Position currentLocation;
  const SearchAddressView({Key? key, required this.currentLocation})
      : super(key: key);
  @override
  State<SearchAddressView> createState() => _SearchAddressViewState();
}

class _SearchAddressViewState extends State<SearchAddressView> {
  final Completer<GoogleMapController> _controller = Completer();

  final _locationController = TextEditingController();
  final _otherLocationController = TextEditingController();
  final placesService = PlacesService();
  var mapController = MapController();
  var enableDropDown = true;
  final Set<Marker> _markers = HashSet<Marker>();
  List<PlaceSearch>? searchResults;
  BitmapDescriptor? customIcon;
  var placeName = "";
  var enableSaveProceed = false;
  var currentSelectedIndex = 0;
  var _mapStyle = "";
  final double _mapZoom = 14.0;
  final _viewModel = instance<SearchAddressViewModel>();

  _bind() {
    rootBundle.loadString(TextAssetManager.mapStyle).then((string) {
      _mapStyle = string;
    });
    _otherLocationController.addListener(() {
      _viewModel.setHouseNo(_otherLocationController.text);
    });

    mapController.selectedLocation.stream.listen((place) async {
      if (place != null) {
        _locationController.text = place.formattedAddress;
        _goToPlace(place);
      } else {
        _locationController.text = "";
      }
    });

    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(AppSize.s40, AppSize.s40)),
            ImageAssets.googlePinIcon)
        .then((d) {
      customIcon = d;
    });
    _requestLocationPermission();

    _viewModel.updateAddressSuccessStreamController.listen((_) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
    });
  }

  _dispose() {
    _viewModel.dispose();
    _otherLocationController.dispose();
    _locationController.dispose();
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
        _checkGps();
      }
    } else if (permission == LocationPermission.deniedForever) {
      _checkGps();
    } else if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      var currentLocation = await Geolocator.getCurrentPosition();
      _getLocations(currentLocation.latitude, currentLocation.longitude);
    }
  }

  Future<void> _goToPlace(GoogleAddress? place) async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(place?.latitude ?? 0.0, place?.longitude ?? 0.0),
            zoom: _mapZoom),
      ),
    );
    _onAddMarkerButtonPressed(place);
  }

  _onAddMarkerButtonPressed(GoogleAddress? place) async {
    var rng = Random();

    double lat = place?.latitude ?? 0.0;
    double lon = place?.longitude ?? 0.0;
    String fullAddress = place?.formattedAddress ?? "";
    String postalCode = place?.postalCodeLong ?? "";

    setState(() {
      placeName = "$fullAddress - $postalCode";
      _markers.add(Marker(
          markerId: MarkerId("Marker${rng.nextInt(100)}"),
          position: LatLng(lat, lon),
          infoWindow: InfoWindow(
              title: "Order will be delivered here", snippet: "", onTap: () {}),
          onTap: () {},
          icon: customIcon!));
    });
    if (place != null) {
      _viewModel.setAddress(place);
    }
  }

  Future<void> _getLocations(lat, lng) async {
    GoogleMapController controller = await _controller.future;
    GoogleAddress? address = await placesService.getPlaces(lat, lng);

    final fullAddress = address?.formattedAddress ?? "";
    _locationController.text = fullAddress;
    String postalCode = address?.postalCodeLong ?? "";

    setState(() {
      placeName = "$fullAddress - $postalCode";
    });
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 15),
      ),
    );

    // Address address =
    //     await GeoCode().reverseGeocoding(latitude: lat, longitude: lng);
    //
    // int stNo = address.streetNumber ?? 0;
    // String streetNumber = stNo != 0 ? stNo.toString() : "";
    // String streetAddress = address.streetAddress ?? "";
    // String city = address.city ?? "";
    // String region = address.region ?? "";
    // String country = address.countryName ?? "";
    // String postal = address.postal ?? "";
    //
    // String formattedAddress =
    //     "$streetNumber,$streetAddress,$city,$region,$country,$postal";

    _locationController.text = placeName;

    // controller.animateCamera(
    //   CameraUpdate.newCameraPosition(
    //     CameraPosition(target: LatLng(lat, lng), zoom: 15),
    //   ),
    // );

    var rng = Random();

    setState(() {
      //placeName = formattedAddress;

      _markers.add(Marker(
          markerId: MarkerId("Marker${rng.nextInt(100)}"),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
              title: "Order will be delivered here", snippet: "", onTap: () {}),
          onTap: () {},
          icon: customIcon!));
    });

    GoogleAddress googleAddress = address!; //todo: Need to work on null safety
    _viewModel.setAddress(googleAddress);
  }

  Future _checkGps() async {
    if (Theme.of(context).platform == TargetPlatform.android) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(AppStrings.canNotGetAccess),
              content: const Text(AppStrings.enableLocationService),
              actions: <Widget>[
                ElevatedButton(
                    child: const Text(AppStrings.ok),
                    onPressed: () {
                      AppSettings.openLocationSettings();
                      Navigator.of(context, rootNavigator: true).pop();
                    }),
                ElevatedButton(
                    child: const Text(AppStrings.cancel),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    })
              ],
            );
          });
    }
  }

  _searchValue(String value) async {
    var results = await mapController.searchPlaces(value);
    setState(() {
      searchResults = results;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    controller.setMapStyle(_mapStyle);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Scaffold(
            body: SafeArea(
          child: Stack(children: [
            Stack(
              children: [
                Container(
                  width: width,
                  height: height,
                  alignment: Alignment.bottomCenter,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,

                    tiltGesturesEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(widget.currentLocation.latitude,
                          widget.currentLocation.longitude),
                      zoom: _mapZoom,
                    ),
                    // onCameraMove: _onCameraMove,
                    markers: _markers,
                    onMapCreated: _onMapCreated,
                    compassEnabled: false,
                    rotateGesturesEnabled: false,

                    // markers: Set<Marker>.of(applicationBloc.markers),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: width,
                  height: AppSize.s150,
                  child: Card(
                      color: ColorManager.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      elevation: AppSize.s20,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: AppSize.s20,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: AppSize.s20,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(Icons.arrow_back),
                                  )),
                              const SizedBox(
                                width: AppSize.s10,
                              ),
                              Text(AppStrings.setDeliveryLocation,
                                  textAlign: TextAlign.left,
                                  style: getRegularStyle(
                                      color: ColorManager.black)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(AppPadding.p15),
                            child: TextField(
                              controller: _locationController,
                              textCapitalization: TextCapitalization.words,
                              textAlign: TextAlign.left,
                              onChanged: (value) => {
                                _searchValue(value),
                                setState(() {
                                  enableDropDown = true;
                                })
                              },
                              onTap: () => {
                                _locationController.text = "",
                                mapController.clearSelectedLocation(),
                              },
                              style: const TextStyle(
                                  fontSize: FontSize.f16,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                // disabledBorder:
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(width: AppSize.s1),
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(
                                          AppSize.s5, AppSize.s5)),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ColorManager.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorManager.white)),
                                filled: true,
                                fillColor: ColorManager.grey2,
                                hintText: AppStrings.searchLocation,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: ColorManager.darkGrey,
                                ),

                                // prefixIcon:''
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
            if (searchResults != null && enableDropDown)
              Container(
                height: AppSize.s300,
                margin: const EdgeInsets.only(
                    top: AppSize.s100, left: AppSize.s40, right: AppSize.s20),
                color: ColorManager.white,
                child: ListView.builder(
                    itemCount: searchResults!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          searchResults![index].description,
                          style: getLightStyle(color: ColorManager.black),
                        ),
                        onTap: () {
                          _locationController.text =
                              searchResults![index].description;
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            enableDropDown = false;
                          });
                          mapController.setSelectedLocation(
                              searchResults![index].placeId);
                        },
                      );
                    }),
              ),
            if (placeName.isNotEmpty && _locationController.text.length > 10)
              Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: width,
                        padding: const EdgeInsets.only(
                            left: AppPadding.p20, right: AppPadding.p20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: ColorManager.white,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(AppSize.s15),
                                topLeft: Radius.circular(AppSize.s15))),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: AppSize.s15,
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: FontSize.f25,
                                  color: Colors.black,
                                ),
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.add_location_alt,
                                      color: ColorManager.darkPrimary,
                                    ),
                                  ),
                                  TextSpan(
                                      text: "  $placeName ",
                                      style: getBoldStyle(
                                          color: ColorManager.black,
                                          fontSize: FontSize.f16)),
                                ],
                              ),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              height: AppSize.s20,
                            ),
                            _getOtherLocation(),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    //_viewModel.saveAddress();
                                  },
                                  child:
                                      const Text(AppStrings.confirmLocation)),
                            ),
                            const SizedBox(
                              height: AppSize.s20,
                            ),
                          ],
                        ))
                  ])
          ]),
        )),
        StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getWidget(context, (action) {
                  _viewModel.hideState();
                }) ??
                const SizedBox();
          },
        )
      ],
    );
  }

  Widget _getOtherLocation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.houseNo,
          textAlign: TextAlign.left,
          style: getRegularStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.f12),
        ),
        TextField(
          controller: _otherLocationController,
          textCapitalization: TextCapitalization.words,
          textAlign: TextAlign.left,
          style: const TextStyle(
              fontSize: FontSize.f18, fontWeight: FontWeightManager.regular),
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.darkGrey, width: AppSize.s2),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.darkPrimary, width: AppSize.s2),
            ),
          ),
        ),
        const SizedBox(
          height: AppSize.s30,
        ),
      ],
    );
  }
}
