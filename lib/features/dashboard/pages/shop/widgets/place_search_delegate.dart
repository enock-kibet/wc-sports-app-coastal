import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:sports_app/common/app_back_button.dart';

class PlaceSearchDelegate extends SearchDelegate<Map<String, dynamic>?> {
  final FlutterGooglePlacesSdk places;

  PlaceSearchDelegate(this.places);

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: AppBackButton(
          size: 40,
          onPressed: () => close(context, null),
        ),
      );

  @override
  Widget buildResults(BuildContext context) => const SizedBox();

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text("Search location"));
    }

    return FutureBuilder(
      future: places.findAutocompletePredictions(query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final predictions = snapshot.data!.predictions;

        return ListView.builder(
          itemCount: predictions.length,
          itemBuilder: (context, index) {
            final p = predictions[index];

            return ListTile(
              title: Text(p.fullText),
              onTap: () async {
                final details = await places.fetchPlace(
                  p.placeId,
                  fields: [
                    PlaceField.Location,
                    PlaceField.Address, // ✅ IMPORTANT
                  ],
                );

                final place = details.place!;
                final loc = place.latLng!;

                close(context, {
                  "address": place.address, // ✅ FIXED HERE
                  "lat": loc.lat,
                  "lng": loc.lng,
                });
              },
            );
          },
        );
      },
    );
  }
}
