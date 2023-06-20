// ignore_for_file: non_constant_identifier_names

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../../domain/model/model.dart';

class PlaceSearch {
  final String description;
  final String placeId;

  PlaceSearch({required this.description, required this.placeId});

  factory PlaceSearch.fromJson(Map<String, dynamic> json) {
    return PlaceSearch(
        description: json['description'] ?? '',
        placeId: json['place_id'] ?? '');
  }
}

class PlacesService {
  final key =
      'AIzaSyDm3HQnjq1gN_5-cXcUgipNWYRiP8hcaCo'; //todo: update the key from server
  List<PlaceSearch>? searchResults;

  final URL_BY_GEOCODE = "https://maps.googleapis.com/maps/api/geocode/json?";
  final URL_BY_PLACEID =
      "https://maps.googleapis.com/maps/api/place/details/json?";

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    //&types=(cities)
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&key=$key&&components=country:in');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'];
    return jsonResults
        .map<PlaceSearch>((place) => PlaceSearch.fromJson(place))
        .toList();
  }

  Future<GoogleAddress?> getPlace(String placeId) async {
    var url = Uri.parse("${URL_BY_PLACEID}placeid=$placeId&key=$key");
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    String status = json["status"] ?? "";
    if (status == "OK") {
      var reqResult = json['result'];
      final geometry = reqResult["geometry"];
      final location = geometry["location"];
      double latitude = location["lat"] ?? 0.0;
      double longitude = location["lng"] ?? 0.0;
      final formatAddress = reqResult["formatted_address"] ?? "";
      var addressComponents = reqResult["address_components"];
      var streetNoLong = "";
      var streetNoShort = "";
      var streetAddLong = "";
      var streetAddShort = "";
      var cityLong = "";
      var cityShort = "";
      var provinceLong = "";
      var provinceShort = "";
      var countryLong = "";
      var countryShort = "";
      var postalLong = "";
      var postalShort = "";

      for (var component in addressComponents) {
        final typeOfComponent = component["types"];
        if (typeOfComponent.contains("street_number")) {
          streetNoLong = component["long_name"];
          streetNoShort = component["short_name"];
        } else if (typeOfComponent.contains("route")) {
          streetAddLong = component["long_name"];
          streetAddShort = component["short_name"];
        } else if (typeOfComponent.contains("locality")) {
          cityLong = component["long_name"];
          cityShort = component["short_name"];
        } else if (typeOfComponent.contains("administrative_area_level_1")) {
          provinceLong = component["long_name"];
          provinceShort = component["short_name"];
        } else if (typeOfComponent.contains("country")) {
          countryLong = component["long_name"];
          countryShort = component["short_name"];
        } else if (typeOfComponent.contains("postal_code")) {
          postalLong = component["long_name"];
          postalShort = component["short_name"];
        }
      }
      return GoogleAddress(
          latitude,
          longitude,
          formatAddress,
          streetNoShort,
          streetNoLong,
          streetAddShort,
          streetAddLong,
          cityShort,
          cityLong,
          provinceShort,
          provinceLong,
          countryShort,
          countryLong,
          postalShort,
          postalLong);
    }
    return null;
  }

  Future<GoogleAddress?> getPlaces(double lat, double lng) async {
    //&type=locality,administrative_area_level_1
    var url = Uri.parse("${URL_BY_GEOCODE}latlng=$lat,$lng&key=$key");
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    String status = json["status"] ?? "";
    if (status == "OK") {
      var reqResultA = json["result"];
      var reqResultB = json['results'][0];
      var reqResult = reqResultA ?? reqResultB;
      final geometry = reqResult["geometry"];
      final location = geometry["location"];
      double latitude = location["lat"] ?? 0.0;
      double longitude = location["lng"] ?? 0.0;
      final formatAddress = reqResult["formatted_address"] ?? "";
      var addressComponents = reqResult["address_components"];
      var streetNoLong = "";
      var streetNoShort = "";
      var streetAddLong = "";
      var streetAddShort = "";
      var cityLong = "";
      var cityShort = "";
      var provinceLong = "";
      var provinceShort = "";
      var countryLong = "";
      var countryShort = "";
      var postalLong = "";
      var postalShort = "";

      for (var component in addressComponents) {
        final typeOfComponent = component["types"];
        if (typeOfComponent.contains("street_number")) {
          streetNoLong = component["long_name"];
          streetNoShort = component["short_name"];
        } else if (typeOfComponent.contains("route")) {
          streetAddLong = component["long_name"];
          streetAddShort = component["short_name"];
        } else if (typeOfComponent.contains("locality")) {
          cityLong = component["long_name"];
          cityShort = component["short_name"];
        } else if (typeOfComponent.contains("administrative_area_level_1")) {
          provinceLong = component["long_name"];
          provinceShort = component["short_name"];
        } else if (typeOfComponent.contains("country")) {
          countryLong = component["long_name"];
          countryShort = component["short_name"];
        } else if (typeOfComponent.contains("postal_code")) {
          postalLong = component["long_name"];
          postalShort = component["short_name"];
        }
      }
      return GoogleAddress(
          latitude,
          longitude,
          formatAddress,
          streetNoShort,
          streetNoLong,
          streetAddShort,
          streetAddLong,
          cityShort,
          cityLong,
          provinceShort,
          provinceLong,
          countryShort,
          countryLong,
          postalShort,
          postalLong);
    }
    return null;
  }
}

/*var reqResult = json['result'];
final geometry = reqResult["geometry"];
final location = geometry["location"];
double latitude = location["lat"] ?? 0.0;
double longitude = location["lng"] ?? 0.0;
final formatAddress = reqResult["formatted_address"] ?? "";
var addressComponents = reqResult["address_components"];
var streetNoLong = "";
var streetNoShort = "";
var streetAddLong = "";
var streetAddShort = "";
var cityLong = "";
var cityShort = "";
var provinceLong = "";
var provinceShort = "";
var countryLong = "";
var countryShort = "";
var postalLong = "";
var postalShort = "";

for (var component in addressComponents) {
final typeOfComponent = component["types"];
if (typeOfComponent.contains("street_number")) {
streetNoLong = component["long_name"];
streetNoShort = component["short_name"];
} else if (typeOfComponent.contains("route")) {
streetAddLong = component["long_name"];
streetAddShort = component["short_name"];
} else if (typeOfComponent.contains("locality")) {
cityLong = component["long_name"];
cityShort = component["short_name"];
} else if (typeOfComponent.contains("administrative_area_level_1")) {
provinceLong = component["long_name"];
provinceShort = component["short_name"];
} else if (typeOfComponent.contains("country")) {
countryLong = component["long_name"];
countryShort = component["short_name"];
} else if (typeOfComponent.contains("postal_code")) {
postalLong = component["long_name"];
postalShort = component["short_name"];
}
}
return GoogleAddress(
    latitude,
    longitude,
    formatAddress,
    streetNoShort,
    streetNoLong,
    streetAddShort,
    streetAddLong,
    cityShort,
    cityLong,
    provinceShort,
    provinceLong,
    countryShort,
    countryLong,
    postalShort,
    postalLong);*/
