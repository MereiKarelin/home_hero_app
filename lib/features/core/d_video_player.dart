import 'package:homehero/features/core/d_color.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DVideoPlayer extends StatefulWidget {
  final String filePath;
  final bool autoPlay;

  const DVideoPlayer({super.key, required this.filePath, required this.autoPlay});

  @override
  State<DVideoPlayer> createState() => _DVideoPlayerState();
}

class _DVideoPlayerState extends State<DVideoPlayer> {
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    _initializePlayer(widget.filePath);
  }

  @override
  void didUpdateWidget(covariant DVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filePath != widget.filePath) {
      _initializePlayer(widget.filePath);
    }
  }

  void _initializePlayer(String filePath) {
    _disposeController();
    _videoController = VideoPlayerController.asset(filePath)
      ..initialize().then((_) {
        setState(() {});
        if (widget.autoPlay) {
          _videoController?.play();
        }
      });
  }

  void _disposeController() {
    _videoController?.dispose();
  }

  void _togglePlayPause() {
    if (_videoController == null) return;

    setState(() {
      if (_videoController!.value.isPlaying) {
        _videoController!.pause();
      } else {
        _videoController!.play();
      }
    });
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlayPause, // Нажатие на видео
      child: SizedBox(
        height: 175,
        child: _videoController != null && _videoController!.value.isInitialized
            ? Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_videoController!),
                  if (!_videoController!.value.isPlaying)
                    CircleAvatar(
                        radius: 20,
                        backgroundColor: DColor.greenColor,
                        child: Center(child: const Icon(Icons.play_arrow_rounded, size: 30, color: Colors.white))),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
