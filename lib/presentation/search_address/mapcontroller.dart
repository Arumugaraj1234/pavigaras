import 'dart:async';
import 'package:get/get.dart';
import 'package:pavigaras/presentation/search_address/places_service.dart';
import '../../domain/model/model.dart';

class MapController extends GetxController {
  final placeService = PlacesService();
  List<dynamic>? searchResults;
  final selectedLocation = StreamController<GoogleAddress?>();
  GoogleAddress? selectedLocationStatic;

  searchPlaces(String searchTerm) async {
    searchResults = await placeService.getAutocomplete(searchTerm);
    return searchResults;
  }

  setSelectedLocation(String placeId) async {
    GoogleAddress? sLocation = await placeService.getPlace(placeId);
    selectedLocation.add(sLocation);
    selectedLocationStatic = sLocation;
    searchResults = null;
  }

  clearSelectedLocation() {
    searchResults = null;
    selectedLocationStatic = null;
    searchResults = null;
  }
}
