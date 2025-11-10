import 'package:flutter/material.dart';
import '../../../../../data/models/media/media.dart';
import 'media_player_widget.dart';

class SeasonHighlightsList extends StatelessWidget {
  final List<SeasonHighlight> seasonHighlights;
  const SeasonHighlightsList({super.key, required this.seasonHighlights});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Season Highlights", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 8),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: seasonHighlights.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = seasonHighlights[index];
            return MediaPlayerWidget(
              image: item.image,
              url: item.url,
              type: item.type,
              title: item.title,
              subtitle: "${item.date} • ${item.time}",
            );
          },
        ),
      ],
    );
  }
}
