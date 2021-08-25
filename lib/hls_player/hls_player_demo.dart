import 'package:flutter/material.dart';
import 'package:flutter_playout/player_state.dart';

import 'package:flutter_playout/video.dart';

class HlsPlayerDemo extends StatefulWidget {
  @override
  _HlsPlayerDemoState createState() => _HlsPlayerDemoState();
}

class _HlsPlayerDemoState extends State<HlsPlayerDemo> {

  PlayerState _desiredState = PlayerState.PLAYING;
  bool _showPlayerController = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Video(
          autoPlay: true,
          title: "Test hls",
          isLiveStream: false,
          position: 0,
          url: 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8',
        ),
      ),
    );
  }
}
