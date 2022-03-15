import 'package:flutter/material.dart';

class AniCircleClose extends StatefulWidget {
  @override
  _AniCircleCloseState createState() => _AniCircleCloseState();
}

class _AniCircleCloseState extends State<AniCircleClose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Animation Circle Close'),
      ),
      body: Center(
        child: CircleClose(),
      ),
    );
  }
}

class CircleClose extends StatefulWidget {
  @override
  _CircleCloseState createState() => _CircleCloseState();
}

class _CircleCloseState extends State<CircleClose>
    with TickerProviderStateMixin {
  double widgetWidth = 200;
  double widgetHeight = 200;

  double sizeBLur = 40;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(_aniListener);

    _animationController.forward();
  }

  void _aniListener() {
    setState(() {});
  }

  void _aniStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animation.removeListener(_aniListener);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _action,
      child: Container(
        height: widgetWidth,
        width: widgetWidth,
        child: Stack(
          children: [
            Image.network(
              'https://picsum.photos/id/10/200/300',
              width: widgetWidth,
              height: widgetWidth,
              fit: BoxFit.cover,
            ),
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(1), BlendMode.srcOut),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      backgroundBlendMode: BlendMode.dstOut,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: widgetWidth * _animation.value,
                      width: widgetWidth * _animation.value,
                      // height: widgetWidth,
                      // width: widgetWidth,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.7),
                BlendMode.srcOut,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      backgroundBlendMode: BlendMode.dstOut,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: _calSizeBlur(widgetWidth, _animation.value),
                      width: _calSizeBlur(widgetHeight, _animation.value),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calSizeBlur(double widgetHeight, double percent) {
    double finalSize = widgetHeight * percent - sizeBLur;

    if (finalSize < 0) {
      finalSize = 0;
    }

    return finalSize;
  }

  void _action() {
    AnimationStatus status = _animationController.status;

    if (status == AnimationStatus.completed) {
      _animationController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _animationController.forward();
    }
  }
}
