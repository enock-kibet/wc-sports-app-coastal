// lib/features/dashboard/pages/shop/widgets/address_form_bottom_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmf;
import 'package:geolocator/geolocator.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sports_app/features/app/blocs/address/address_bloc.dart';
import 'package:sports_app/features/dashboard/pages/shop/widgets/place_search_delegate.dart';
import '../../../../../data/services/service.dart';
import '../../../../../localization/app_prefs_manager.dart';
import '../../../../../theme/app_colors.dart';
import '../shop_page.dart';
import 'cart_location_picker.dart';

class AddressFormBottomSheet extends StatefulWidget {
  final String apiKey;
  final Function(Map<String, dynamic>) onAddressSelected;

  const AddressFormBottomSheet({
    super.key,
    required this.apiKey,
    required this.onAddressSelected,
  });

  @override
  State<AddressFormBottomSheet> createState() => _AddressFormBottomSheetState();
}

class _AddressFormBottomSheetState extends State<AddressFormBottomSheet> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  bool _isSelectingAddress = false;

  int _queryVersion = 0;

  late FlutterGooglePlacesSdk _places;
  List<AutocompletePrediction> _predictions = [];
  final _addressSearchController = TextEditingController();
  Map<String, dynamic>? _locationResult;

  @override
  void initState() {
    super.initState();
    _nameController.text =
        service<AppPreferencesManager>().currentUserValue!.name;

    _places = FlutterGooglePlacesSdk(widget.apiKey);
  }

  Future<gmf.LatLng?> getCurrentLatLng() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    // Check for permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }
    if (permission == LocationPermission.deniedForever) return null;

    // Get current position
    final pos = await Geolocator.getCurrentPosition();
    return gmf.LatLng(pos.latitude, pos.longitude);
  }

  void _pickLocation() async {
    final userLocation = await getCurrentLatLng();

    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (context) => MapLocationPickerBottomSheet(
        apiKey: widget.apiKey,
        initialLocation: userLocation,
      ),
    );
    if (result != null) {
      setState(() {
        _locationResult = result;
      });
    }
  }

  void _pickLocadtion() async {
    final places = FlutterGooglePlacesSdk(widget.apiKey);

    final result = await showSearch(
      context: context,
      delegate: PlaceSearchDelegate(places),
    );

    if (result != null) {
      setState(() {
        _locationResult = {
          "address": result["address"],
          "latLng": gmf.LatLng(result["lat"], result["lng"]),
        };
      });
    }
  }

  // default address checkbox functionality
  bool _isDefaultAddress = true;

  void _submit() {
    if (_locationResult != null &&
        _nameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty) {
      // check if fields are filled
      if (_nameController.text.isEmpty ||
          _phoneController.text.isEmpty ||
          _countryController.text.isEmpty ||
          _cityController.text.isEmpty ||
          _locationResult!["address"].isEmpty) {
        AnimatedOverlaySnackbar.show(context, "Please fill all fields",
            color: AppColors.defaultAppRed);
        return;
      }

      // submit the address details
      context.read<AddressBloc>().add(
            AddressEvent.addAddress(request: {
              "fullName": _nameController.text,
              "line1": _locationResult!["address"],
              "city": _cityController.text,
              "country": _countryController.text,
              "phone": _phoneController.text,
              "latitude": _locationResult!["latLng"].latitude,
              "longitude": _locationResult!["latLng"].longitude,
              "isDefault": _isDefaultAddress,
            }),
          );

      // get address id from the state
      final addressState = context.read<AddressBloc>().state;
      if (addressState.status == AddressStatus.success) {
        // final addressId = addressState.data.last.id; // Assuming the last added address is the one we just added
        final addressId = addressState.addressId;

        print("Address8 States: ${_locationResult!["address"]}");
        widget.onAddressSelected({
          "id": addressId,
          "name": _nameController.text,
          "phone": _phoneController.text,
          "latLng": _locationResult!["latLng"],
          "latitude": _locationResult!["latLng"].latitude,
          "longitude": _locationResult!["latLng"].longitude,
          "address": _locationResult!["address"],
          "default": _isDefaultAddress,
        });

        print("Address8 States: ${_locationResult!["address"]}");
        AnimatedOverlaySnackbar.show(context, "Address added successfully",
            color: AppColors.darkColor);
      } else {
        AnimatedOverlaySnackbar.show(
            context, "Failed to add address: ${addressState.failure?.error}",
            color: AppColors.defaultAppRed);
        return;
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 30,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(height: 18),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: "Phone",
                    border: InputBorder.none, // Remove default border
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(height: 18),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _countryController,
                  decoration: const InputDecoration(
                    labelText: "Country",
                    border: InputBorder.none, // Remove default border
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(height: 18),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: "City",
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(height: 18),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    _predictions.clear();
                  });
                },
                child: SizedBox(
                  height: 150, // enough space for field + dropdown
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // ✅ Address Input (Always on top)
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: TextField(
                          controller: _addressSearchController,
                          decoration: const InputDecoration(
                            labelText: "Delivery Address",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) async {
                            if (_isSelectingAddress) return;
                            if (value.isEmpty) {
                              setState(() => _predictions.clear());
                              return;
                            }

                            final currentVersion = ++_queryVersion;

                            final res = await _places
                                .findAutocompletePredictions(value);

                            if (!_isSelectingAddress &&
                                currentVersion == _queryVersion) {
                              setState(() {
                                _predictions =
                                    List<AutocompletePrediction>.from(
                                        res.predictions);
                              });
                            }
                          },
                        ),
                      ),

                      // ✅ AUTOCOMPLETE DROPDOWN (Z-INDEX ABOVE EVERYTHING)
                      if (_predictions.isNotEmpty)
                        Positioned(
                          top: 55, // directly below the input
                          left: 0,
                          right: 0,
                          child: Material(
                            elevation: 6, // 👈 gives true Z depth
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: _predictions.length,
                                itemBuilder: (context, index) {
                                  final p = _predictions[index];

                                  return ListTile(
                                    title: Text(p.fullText),
                                    onTap: () async {
                                      _isSelectingAddress = true;
                                      final details = await _places.fetchPlace(
                                        p.placeId,
                                        fields: [
                                          PlaceField.Location,
                                          PlaceField.Address,
                                        ],
                                      );

                                      final place = details.place!;
                                      final loc = place.latLng!;

                                      setState(() {
                                        _locationResult = {
                                          "address": place.address,
                                          "latLng":
                                              gmf.LatLng(loc.lat, loc.lng),
                                        };

                                        _addressSearchController.text =
                                            place.address ?? "";

                                        _predictions.clear();
                                      });
                                      FocusScope.of(context).unfocus();

                                      _isSelectingAddress = false;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // set as default address checkbox
              const SizedBox(height: 8),
              Row(
                children: [
                  Checkbox(
                    value:
                        _isDefaultAddress, // Default to true for this example
                    onChanged: (value) {
                      setState(() {
                        _isDefaultAddress = value ?? true;
                      });
                    },
                  ),
                  const Text("Set as default address"),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                child: GradientFilledButton(
                  onPressed: _submit,
                  text: 'Confirm Address',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
