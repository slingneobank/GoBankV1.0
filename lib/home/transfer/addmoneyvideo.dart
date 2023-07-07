import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../utils/colornotifire.dart';

class addmoneyvideo extends StatefulWidget {
  final String videoUrl;

   addmoneyvideo({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _addmoneyvideoState createState() => _addmoneyvideoState();
}

class _addmoneyvideoState extends State<addmoneyvideo> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _isVideoError = false;
   late ColorNotifire notifire;

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }
  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  void _initializeVideoPlayer() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      errorBuilder: (context, errorMessage) {
        _isVideoError = true;
        return Center(
          child: Text(
            'Error loading video',
            style: TextStyle(color: Colors.red),
          ),
        );
      },
    );

    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.hasError && !_isVideoError) {
        setState(() {
          _isVideoError = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
     notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
       backgroundColor: notifire.getdarkscolor,
      appBar: AppBar(
        backgroundColor:  notifire.getdarkscolor,
      ),
      body: _isVideoError
          ? Center(
              child: Text(
                'Error loading video',
                style: TextStyle(color: Colors.red),
              ),
            )
          : Chewie(controller: _chewieController),
    );
  }
}
