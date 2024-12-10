import 'package:chewie/chewie.dart';
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
  ChewieController? _chewteController;

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
    _disposeControllers(); // Освобождаем старые ресурсы
    _videoController = VideoPlayerController.asset(filePath)
      ..initialize().then((_) {
        setState(() {}); // Перерисовываем виджет после инициализации
      });

    _chewteController = ChewieController(
      videoPlayerController: _videoController!,
      autoInitialize: true,
      aspectRatio: 2,
      // showControls: false,
      autoPlay: widget.autoPlay,

      placeholder: Container(
        color: Colors.white,
      ),
    );
    if (widget.autoPlay) {
      _chewteController?.play();
    }
  }

  void _disposeControllers() {
    _chewteController?.dispose();
    _videoController?.dispose();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 175,
      child: _chewteController != null && _videoController!.value.isInitialized
          ? Container(color: Colors.transparent, child: Chewie(controller: _chewteController!))
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
