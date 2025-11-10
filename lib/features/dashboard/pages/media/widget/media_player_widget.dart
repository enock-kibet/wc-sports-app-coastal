import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MediaPlayerWidget extends StatefulWidget {
  final String image;
  final String? url;
  final String? type; // "image", "video", "youtube"
  final String title;
  final String? subtitle;

  const MediaPlayerWidget({
    super.key,
    required this.image,
    required this.url,
    this.type,
    required this.title,
    this.subtitle,
  });

  @override
  State<MediaPlayerWidget> createState() => _MediaPlayerWidgetState();
}

class _MediaPlayerWidgetState extends State<MediaPlayerWidget> {
  VideoPlayerController? _videoController;
  YoutubePlayerController? _youtubeController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    if (widget.type == "video" && widget.url != null) {
      _videoController = VideoPlayerController.network(widget.url!)
        ..initialize().then((_) {
          setState(() {});
          _videoController?.setLooping(true);
          // Do NOT autoplay
        });
    } else if (widget.type?.toLowerCase() == "youtube" && widget.url != null) {
      final videoId = YoutubePlayer.convertUrlToId(widget.url!);
      if (videoId != null) {
        _youtubeController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
            controlsVisibleAtStart: true,
          ),
        );
      }
    }
  }

  void _openYoutubeFullScreen() {
    if (_youtubeController == null) return;

    Navigator.of(context)
        .push(
      MaterialPageRoute(
        fullscreenDialog: true, // 👈 ensures it's a full overlay
        builder: (_) => YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _youtubeController!,
            showVideoProgressIndicator: true,
          ),
          builder: (context, player) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: SafeArea(
                child: Stack(
                  children: [
                    Center(child: player),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    )
        .then((_) {
      // Restore system UI when closed
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    });

    // Hide system UI while playing fullscreen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _youtubeController?.dispose();
    super.dispose();
  }

  void _openVideoFullScreen() {
    if (_videoController == null || !_videoController!.value.isInitialized)
      return;

    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => WillPopScope(
          onWillPop: () async {
            // Restore system UI on back
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
            return true;
          },
          child: Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Center(
                    child: AspectRatio(
                      aspectRatio: _videoController!.value.aspectRatio,
                      child: VideoPlayer(_videoController!),
                    ),
                  ),
                  _buildVideoControls(),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        SystemChrome.setEnabledSystemUIMode(
                            SystemUiMode.edgeToEdge);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // Enter fullscreen immersive
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  Widget _buildVideoControls() {
    return Container(
      color: Colors.black54,
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            color: Colors.white,
            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              setState(() {
                if (_isPlaying) {
                  _videoController?.pause();
                } else {
                  _videoController?.play();
                }
                _isPlaying = !_isPlaying;
              });
            },
          ),
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.fullscreen),
            onPressed: _openVideoFullScreen,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mediaWidget;

    String? getYoutubeThumbnail(String url) {
      final videoId = YoutubePlayer.convertUrlToId(url);
      if (videoId == null) return null;
      // You can choose hqdefault.jpg or maxresdefault.jpg
      return "https://img.youtube.com/vi/$videoId/hqdefault.jpg";
    }

    if (widget.type == "video" &&
        _videoController != null &&
        _videoController!.value.isInitialized) {
      mediaWidget = Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: VideoPlayer(_videoController!),
          ),
          _buildVideoControls(),
        ],
      );
    } else if (widget.type?.toLowerCase() == "youtube" &&
        _youtubeController != null) {
      final thumbnail = getYoutubeThumbnail(widget.url!);

      mediaWidget = GestureDetector(
        onTap: _openYoutubeFullScreen,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.network(
              thumbnail!,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const Icon(Icons.play_circle_fill, size: 64, color: Colors.white),
          ],
        ),
      );
    } else {
      mediaWidget = Image.network(widget.image, fit: BoxFit.cover);
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 180, child: mediaWidget),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Text(widget.title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          // if (widget.subtitle != null)
          //   Padding(
          //     padding:
          //         const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          //     child: Text(widget.subtitle!,
          //         style: const TextStyle(color: Colors.grey)),
          //   ),
        ],
      ),
    );
  }
}
