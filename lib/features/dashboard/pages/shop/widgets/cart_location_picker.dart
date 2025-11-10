import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmf;
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class MapLocationPickerBottomSheet extends StatefulWidget {
  final String apiKey;
  final gmf.LatLng? initialLocation;

  const MapLocationPickerBottomSheet({
    super.key,
    required this.apiKey,
    required this.initialLocation,
  });

  @override
  State<MapLocationPickerBottomSheet> createState() => _MapLocationPickerBottomSheetState();
}

class _MapLocationPickerBottomSheetState extends State<MapLocationPickerBottomSheet> {
  late gmf.GoogleMapController _mapController;
  gmf.LatLng? _pickedLocation;
  String? _pickedAddress;
  bool _isSearching = false;
  final _searchController = TextEditingController();
  late FlutterGooglePlacesSdk _places;
  List<AutocompletePrediction> _searchPredictions = [];

  @override
  void initState() {
    super.initState();
    _places = FlutterGooglePlacesSdk(widget.apiKey);
    _pickedLocation = widget.initialLocation ?? const gmf.LatLng(-1.286389, 36.817223);

    // Get address from initial location and set as default in search field
    if (_pickedLocation != null) {
      geocoding.placemarkFromCoordinates(_pickedLocation!.latitude, _pickedLocation!.longitude)
          .then((placemarks) {
        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          final address = [
            place.street,
            place.name,
            place.locality,
            place.administrativeArea,
          ].where((e) => e != null && e.isNotEmpty).join(", ");
          setState(() {
            _pickedAddress = address;
            _searchController.text = address;
          });
        }
      });
    }
  }

  Future<void> _onSearchChanged(String value) async {
    setState(() {
      _isSearching = true;
      _searchPredictions = [];
    });
    if (value.isEmpty) {
      setState(() => _isSearching = false);
      return;
    }
    final predictions = await _places.findAutocompletePredictions(
      value,
      countries: ["ke"],
    );
    setState(() {
      _searchPredictions = predictions.predictions;
      _isSearching = false;
    });
  }

  Future<void> _selectPrediction(AutocompletePrediction prediction) async {
    final details = await _places.fetchPlace(
      prediction.placeId,
      fields: [PlaceField.Location, PlaceField.Address, PlaceField.Name],
    );
    final loc = details.place?.latLng;
    if (loc != null) {
      final latLng = gmf.LatLng(loc.lat, loc.lng);
      setState(() {
        _pickedLocation = latLng;
        _pickedAddress = details.place?.address ?? details.place?.name;
        _searchController.text = _pickedAddress ?? "";
        _searchPredictions = [];
      });
      _mapController.animateCamera(gmf.CameraUpdate.newLatLng(latLng));
    }
  }

  Future<void> _onMapTap(gmf.LatLng latLng) async {
    setState(() => _pickedLocation = latLng);
    try {
      final placemarks = await geocoding.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final address = [
          place.street,
          place.name,
          place.locality,
          place.administrativeArea,
        ].where((e) => e != null && e.isNotEmpty).join(", ");
        setState(() => _pickedAddress = address);
      }
    } catch (_) {
      setState(() => _pickedAddress = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search address",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: false,
                ),
                onChanged: _onSearchChanged,
              ),
            ),
            if (_searchPredictions.isNotEmpty)
              Container(
                constraints: const BoxConstraints(maxHeight: 200),
                child: ListView(
                  shrinkWrap: true,
                  children: _searchPredictions.map((prediction) => ListTile(
                    title: Text(prediction.fullText),
                    onTap: () => _selectPrediction(prediction),
                  )).toList(),
                ),
              ),
            Expanded(
              child: _pickedLocation == null
                  ? const Center(child: CircularProgressIndicator())
                  : gmf.GoogleMap(
                initialCameraPosition: gmf.CameraPosition(
                  target: _pickedLocation!,
                  zoom: 16,
                ),
                markers: _pickedLocation != null
                    ? {
                  gmf.Marker(
                    markerId: gmf.MarkerId("selected"),
                    position: _pickedLocation!,
                  ),
                }
                    : {},
                onMapCreated: (controller) => _mapController = controller,
                onTap: _onMapTap,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: Text(_pickedAddress == null ? "Confirm Location" : "Use: $_pickedAddress"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _pickedLocation == null
                    ? null
                    : () {
                  Navigator.of(context).pop({
                    "latLng": _pickedLocation,
                    "address": _pickedAddress,
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}