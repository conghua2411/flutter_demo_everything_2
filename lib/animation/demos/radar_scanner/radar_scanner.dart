import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;

class RadarScanner extends StatefulWidget {
  const RadarScanner({Key? key}) : super(key: key);

  @override
  State<RadarScanner> createState() => _RadarScannerState();
}

class _RadarScannerState extends State<RadarScanner> {
  StreamController<List<PosRadar>> streamController =
      StreamController.broadcast();

  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration(seconds: 2),
      () {
        streamController.add(
          [
            PosRadar(id: 1, lat: 10.001, lng: 10.001),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radar Scanner'),
      ),
      body: Center(
        child: RadarScannerWidget(
          radarSize: MediaQuery.of(context).size.width - 20,
          streamListPosRadar: streamController.stream,
        ),
      ),
    );
  }
}

class RadarScannerWidget extends StatefulWidget {
  final Stream<List<PosRadar>>? streamListPosRadar;

  final double radarSize;

  const RadarScannerWidget({
    Key? key,
    required this.radarSize,
    this.streamListPosRadar,
  }) : super(key: key);

  @override
  State<RadarScannerWidget> createState() => _RadarScannerWidgetState();
}

class _RadarScannerWidgetState extends State<RadarScannerWidget>
    with TickerProviderStateMixin {
  /// example
  ///
  PosRadar userPos = PosRadar(
    id: -1,
    lat: 10,
    lng: 10,
  );

  double oneLatToKm = 111;

  double maxDistance = 10.0;

  late double maxR;

  double get maxSize => widget.radarSize;

  double get maxSizeRadar => widget.radarSize - 50;

  Stream<List<PosRadar>>? get _streamListPosRadar => widget.streamListPosRadar;

  late AnimationController animationController;
  late Animation<double> animation;

  double _currentScannerWidth = 0;
  double _currentScannerHeight = 0;

  double _currentDirection = 0;

  late AnimationController rotateAnimationController;
  late Animation<double> rotateAnimation;

  StreamSubscription? rotateSub;

  @override
  void initState() {
    super.initState();

    maxR = maxDistance / oneLatToKm;

    animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      animationController,
    )
      ..addListener(_scannerAnimationListener)
      ..addStatusListener(_scannerAnimationStatusListener);

    rotateAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
    );

    rotateAnimation = Tween<double>(
      begin: 0,
      end: 0,
    ).animate(
      rotateAnimationController,
    );

    _fetchPermissionStatus().then((value) {
      if (value) {
        _initAnimation();
        _listenPhoneDirection();
      }
    });
  }

  void _initAnimation() {
    animationController.forward(from: 0);
    animationController.repeat();
  }

  bool isRotate = false;

  void _listenPhoneDirection() {
    rotateSub = FlutterCompass.events?.listen((event) {
      if (!isRotate) {
        setState(() {
          isRotate = true;
          rotateAnimation = Tween<double>(
            begin: _currentDirection * (math.pi / 180),
            end: (event.heading ?? 0) * (math.pi / 180),
          ).animate(
            rotateAnimationController,
          );

          rotateAnimationController.forward(from: 0);

          _countDownRotate(event.heading ?? 0);
        });
      }
    });
  }

  void _countDownRotate(double direction) {
    Future.delayed(Duration(milliseconds: 300), () {
      isRotate = false;
      _currentDirection = direction;
    });
  }

  void _scannerAnimationListener() {
    setState(() {
      _currentScannerWidth = maxSizeRadar * animation.value;
      _currentScannerHeight = maxSizeRadar * animation.value;
    });
  }

  void _scannerAnimationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    animationController.removeListener(_scannerAnimationListener);
    animationController.removeStatusListener(_scannerAnimationStatusListener);
    animationController.dispose();

    rotateAnimationController.dispose();

    rotateSub?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('direction: ${rotateAnimation.value}'),
        Container(
          width: maxSize,
          height: maxSize,
          child: Stack(
            children: [
              Center(
                child: AnimatedBuilder(
                  animation: rotateAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: rotateAnimation.value,
                      child: child,
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _centerDirection(
                        child: Text('W'),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _centerDirection(
                              child: Text('N'),
                            ),
                            Flexible(
                              child: Container(
                                width: _currentScannerWidth,
                                height: _currentScannerHeight,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    _currentScannerWidth,
                                  ),
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            _centerDirection(
                              child: Text('S'),
                            ),
                          ],
                        ),
                      ),
                      _centerDirection(
                        child: Text('E'),
                      ),
                    ],
                  ),
                ),
              ),
              _posRadar(_streamListPosRadar),
              Center(
                child: _centerDirection(
                  child: Icon(
                    Icons.arrow_upward_sharp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _centerDirection({
    required Widget child,
    double size = 20,
  }) {
    return SizedBox(
      height: size,
      width: size,
      child: Center(
        child: child,
      ),
    );
  }

  Future<bool> _fetchPermissionStatus() {
    // return Future.value(true);

    return Permission.location.status.then((value) {
      if (!value.isGranted) {
        return _requestPermission();
      }

      return value.isGranted;
    });
  }

  Future<bool> _requestPermission() {
    return Permission.location.request().then((value) {
      if (value.isGranted) {
        return value.isGranted;
      } else {
        return Future.error('Do not have permission');
      }
    });
  }

  Widget _posRadar(Stream<List<PosRadar>>? streamListPosRadar) {
    if (streamListPosRadar == null) {
      return Container();
    }

    return Container(
      width: maxSizeRadar,
      height: maxSizeRadar,
      child: StreamBuilder<List<PosRadar>>(
        initialData: [],
        stream: streamListPosRadar,
        builder: (context, snapshot) {
          return Stack(
            children: snapshot.data!
                .map(
                  (pos) => positionedPosRadar(
                    pos,
                    userPos,
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }

  Widget positionedPosRadar(
    PosRadar pos,
    PosRadar userPos,
  ) {
    double vectorX = (userPos.lat - pos.lat);
    double vectorY = (userPos.lng - pos.lng);

    double vectorXRatio = vectorX / maxR;
    double vectorYRatio = vectorY / maxR;

    double left = maxSizeRadar / 2 - vectorXRatio * (maxSizeRadar / 2);
    double top = maxSizeRadar / 2 - vectorYRatio * (maxSizeRadar / 2);

    return Positioned(
      left: left,
      top: top,
      child: Container(
        child: PosRadarWidget(
          pos: pos,
        ),
      ),
    );
  }
}

class PosRadar {
  int id;
  double lat;
  double lng;

  PosRadar({
    required this.id,
    required this.lat,
    required this.lng,
  });

  double calDistance(PosRadar pos) {
    double r = 6371;
    double dLat = deg2rad(pos.lat - lat);
    double dLon = deg2rad(pos.lng - lng);
    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(deg2rad(lat)) *
            math.cos(deg2rad(pos.lat)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    double d = r * c;
    return d;
  }

  double deg2rad(deg) {
    return deg * (math.pi / 180);
  }
}

class PosRadarWidget extends StatefulWidget {
  final PosRadar pos;
  final double dotSize;
  final Color dotColor;

  const PosRadarWidget({
    Key? key,
    required this.pos,
    this.dotSize = 10,
    this.dotColor = Colors.red,
  }) : super(key: key);

  @override
  State<PosRadarWidget> createState() => _PosRadarWidgetState();
}

class _PosRadarWidgetState extends State<PosRadarWidget>
    with TickerProviderStateMixin {
  double get _dotSize => widget.dotSize;

  Color get _dotColor => widget.dotColor;

  late AnimationController dotController;
  late Animation<double> dotAnimation;

  @override
  void initState() {
    super.initState();

    dotController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    dotAnimation = Tween<double>(begin: 0.1, end: 1).animate(dotController);

    dotController.repeat();
  }

  @override
  void dispose() {
    dotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: dotAnimation,
      builder: (ctx, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(500),
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                spreadRadius: 10 * dotAnimation.value,
                blurRadius: 10,
                color: Colors.black12,
              ),
            ],
          ),
          child: child,
        );
      },
      child: Container(
        width: _dotSize,
        height: _dotSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_dotSize),
          color: _dotColor,
        ),
      ),
    );
  }
}
