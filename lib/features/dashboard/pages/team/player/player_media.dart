part of 'player.dart';

class PlayerMedia extends StatelessWidget {
  const PlayerMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatBloc, StatState>(
      builder: (context, state) {
        // Loading state
        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error state
        if (state.status.isFailure) {
          return Center(
            child: Text(
              state.failure?.error ?? 'Failed to load media',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        // Success state with media
        final reels = state.playerMedia ?? [];

        if (reels.isEmpty) {
          return const Center(child: Text("No highlight reels available"));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: reels.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final reel = reels[index];

                return GestureDetector(
                  onTap: () async {
                    final url = reel.url;
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url),
                          mode: LaunchMode.externalApplication);
                    }
                  },
                  child: Stack(
                    children: [
                      PlayerImage(
                        image: reel.image,
                        width: 220,
                        height: 140,
                        radius: 10,
                      ),
                      if (reel.type.toLowerCase().contains("youtube"))
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(10),
                              child: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        right: 8,
                        child: Text(
                          reel.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                offset: Offset(0, 1),
                                blurRadius: 3,
                              )
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
