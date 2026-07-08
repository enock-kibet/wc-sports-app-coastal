// lib/features/dashboard/pages/shop/widgets/address_form_bottom_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmf;
import 'package:geolocator/geolocator.dart';
import 'package:sports_app/features/app/blocs/address/address_bloc.dart';
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
  final _addressSearchController = TextEditingController();
  Map<String, dynamic>? _locationResult;

  @override
  void initState() {
    super.initState();
    _nameController.text =
        service<AppPreferencesManager>().currentUserValue?.name ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _addressSearchController.dispose();
    super.dispose();
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
        _addressSearchController.text =
            (result["address"] ?? '').toString().trim();
      });
    }
  }

  // default address checkbox functionality
  bool _isDefaultAddress = true;

  Future<void> _submit() async {
    final manualAddress = _addressSearchController.text.trim();
    final latLng = _locationResult?["latLng"] as gmf.LatLng?;

    if (_nameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _countryController.text.isEmpty ||
        _cityController.text.isEmpty ||
        manualAddress.isEmpty) {
      AnimatedOverlaySnackbar.show(context, "Please fill all fields",
          color: AppColors.defaultAppRed);
      return;
    }

    final bloc = context.read<AddressBloc>();
    bloc.add(
      AddressEvent.addAddress(request: {
        "fullName": _nameController.text,
        "line1": manualAddress,
        "city": _cityController.text,
        "country": _countryController.text,
        "phone": _phoneController.text,
        "latitude": latLng?.latitude,
        "longitude": latLng?.longitude,
        "isDefault": _isDefaultAddress,
      }),
    );

    final addressState = await bloc.stream.firstWhere(
      (state) =>
          state.status == AddressStatus.success ||
          state.status == AddressStatus.failure,
    );

    if (!mounted) return;

    if (addressState.status == AddressStatus.success) {
      final addressId = addressState.addressId;

      widget.onAddressSelected({
        "id": addressId,
        "name": _nameController.text,
        "phone": _phoneController.text,
        "latLng": latLng,
        "latitude": latLng?.latitude,
        "longitude": latLng?.longitude,
        "address": manualAddress,
        "city": _cityController.text,
        "country": _countryController.text,
        "default": _isDefaultAddress,
      });

      AnimatedOverlaySnackbar.show(context, "Address added successfully",
          color: AppColors.darkColor);
      Navigator.of(context).pop();
    } else {
      AnimatedOverlaySnackbar.show(
          context, "Failed to add address: ${addressState.failure?.error}",
          color: AppColors.defaultAppRed);
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
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _addressSearchController,
                  decoration: const InputDecoration(
                    labelText: "Delivery Address",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.streetAddress,
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: _pickLocation,
                  icon: const Icon(Icons.map_outlined),
                  label: const Text('Pick on map'),
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
