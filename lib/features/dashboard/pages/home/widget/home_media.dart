import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/features/app/blocs/media/media_bloc.dart';
import 'package:sports_app/data/models/stats/stat.dart';
import 'package:video_player/video_player.dart'; // add this dependency in pubspec.yaml
import 'package:sports_app/common/dimens.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeMediaBanner extends StatelessWidget {
  const HomeMediaBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaBloc, MediaState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status.isFailure) {
          return const Center(
            child: Text('Failed to load media',
                style: TextStyle(color: Colors.red)),
          );
        }

        final reels = state.homeMedia ?? [];
        if (reels.isEmpty) {
          return const Center(child: Text('No media available'));
        }

        return CarouselSlider.builder(
          itemCount: reels.length,
          itemBuilder: (context, index, realIndex) {
            final reel = reels[index];
            return _buildMediaItem(context, reel);
          },
          options: CarouselOptions(
              height: 180,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 16 / 9,
              autoPlayInterval: const Duration(seconds: 6),
              pauseAutoPlayOnTouch: true),
        );
      },
    );
  }

  Widget _buildMediaItem(BuildContext context, HighlightReel reel) {
    final isVideo = reel.type.toLowerCase().contains('video') ||
        reel.type.toLowerCase().contains('youtube') ||
        reel.url.endsWith('.mp4');

    return GestureDetector(
      onTap: () {
        if (isVideo) {
          _showVideoPopup(context, reel.url);
        } else {
          _showImagePopup(context, reel.url);
        }
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kSmall),
          color: Colors.black,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: reel.image,
              fit: BoxFit.cover,
              placeholder: (context, _) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, _, __) =>
                  const Icon(Icons.broken_image, color: Colors.white),
            ),
            if (isVideo)
              const Center(
                child: Icon(Icons.play_circle_fill,
                    size: 60, color: Colors.white70),
              ),
          ],
        ),
      ),
    );
  }

  void _showImagePopup(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(kSmall),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  void _showVideoPopup(BuildContext context, String videoUrl) {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (videoId == null) return;

    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: const EdgeInsets.all(10),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: videoId,
              flags: const YoutubePlayerFlags(
                autoPlay: true,
                mute: false,
              ),
            ),
            showVideoProgressIndicator: true,
          ),
        ),
      ),
    );
  }
}

class _VideoPlayerPopup extends StatefulWidget {
  final String videoUrl;
  const _VideoPlayerPopup({required this.videoUrl});

  @override
  State<_VideoPlayerPopup> createState() => _VideoPlayerPopupState();
}

class _VideoPlayerPopupState extends State<_VideoPlayerPopup> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}
