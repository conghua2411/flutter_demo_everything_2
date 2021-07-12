import 'dart:math';

import 'package:flutter/material.dart';

class SteamCardImageDemo extends StatefulWidget {
  @override
  _SteamCardImageDemoState createState() => _SteamCardImageDemoState();
}

class _SteamCardImageDemoState extends State<SteamCardImageDemo> {
  double _rotateX = 0;
  double _rotateY = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onPanUpdate: (dragUpdateInfo) {
              _setNewRotate(offset: dragUpdateInfo.localPosition);
            },
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(_rotateX / 180 * pi)
                ..rotateY(-_rotateY / 180 * pi),
              alignment: Alignment.center,
              child: Container(
                width: _getImageSize(),
                height: _getImageSize(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.amberAccent,
                    width: 5,
                  ),
                  image: DecorationImage(
                    image: NetworkImage('https://picsum.photos/id/586/200/300'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _getImageSize() {
    return MediaQuery.of(context).size.width * 0.8;
  }

  double _getRotate(double pos, double max, double maxDegree) {
    pos = pos - max / 2;
    return (pos / (max / 2)) * maxDegree;
  }

  void _setNewRotate({Offset? offset}) {
    if (offset == null) {
      return;
    }

    setState(() {
      _rotateX = _getRotate(offset.dy, _getImageSize(), 20);
      _rotateY = _getRotate(offset.dx, _getImageSize(), 20);
    });
  }
}
