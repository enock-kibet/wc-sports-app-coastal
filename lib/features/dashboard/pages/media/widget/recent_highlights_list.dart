import 'package:flutter/material.dart';
import '../../../../../data/models/media/media.dart';
import 'media_player_widget.dart';

class RecentHighlightsList extends StatelessWidget {
  final List<Highlight> highlights;
  const RecentHighlightsList({super.key, required this.highlights});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Highlights",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: highlights.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final item = highlights[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Could navigate to full screen player
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MediaPlayerWidget(
                            image: item.image,
                            url: item.url,
                            type: item.type,
                            title: item.title,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.redAccent,
                          width: 2,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(item.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 80,
                    child: Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
