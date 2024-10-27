import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sports_app/constants/constants.dart';
import 'package:sports_app/data/models/location/directions_details.dart';


import '../services/request_service.dart';

class GeolocationRepository {
  GeolocationRepository();

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.requestPermission();
      // return Future.error("Location service is not enabled");
    }
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error("Location permission denied");
    }
    // if (permission == LocationPermission.deniedForever) {
    //   // return Future.error("Location permission deniedForever");
    //   await Geolocator.openLocationSettings();
    // }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<String> searchAddressForGeographicCoordinates(
      Position position) async {
    String humanReadableAddress = "";
    String apiUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    var requestResponse = await RequestAssistant.receiveRequest(apiUrl);

    if (requestResponse != "Error Occurred, Failed. No Response.") {
      humanReadableAddress = requestResponse["results"][0]["formatted_address"];
    }
    return humanReadableAddress;
  }

  Future<DirectionDetailsInfo?> obtainOriginToDestinationDirectionDetails(
      LatLng origionPosition, LatLng destinationPosition) async {
    String urlOriginToDestinationDirectionDetails =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${origionPosition.latitude},${origionPosition.longitude}&destination=${destinationPosition.latitude},${destinationPosition.longitude}&key=$mapKey";

    var responseDirectionApi = await RequestAssistant.receiveRequest(
        urlOriginToDestinationDirectionDetails);

    if (responseDirectionApi == "Error Occurred, Failed. No Response.") {
      return null;
    }

    DirectionDetailsInfo directionDetailsInfo = DirectionDetailsInfo(
      ePoints: responseDirectionApi["routes"][0]["overview_polyline"]["points"],
      distanceText: responseDirectionApi["routes"][0]["legs"][0]["distance"]
          ["text"],
      distanceValue: responseDirectionApi["routes"][0]["legs"][0]["distance"]
          ["value"],
      durationText: responseDirectionApi["routes"][0]["legs"][0]["duration"]
          ["text"],
      durationValue: responseDirectionApi["routes"][0]["legs"][0]["duration"]
          ["value"],
    );

    return directionDetailsInfo;
  }
}
