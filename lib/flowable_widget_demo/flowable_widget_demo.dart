import 'package:flutter/material.dart';

class FlowableWidgetDemo extends StatefulWidget {
  @override
  _FlowableWidgetDemoState createState() => _FlowableWidgetDemoState();
}

class _FlowableWidgetDemoState extends State<FlowableWidgetDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: TextButton(
                child: Text('hello'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        content: Text('hello'),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          FlowableWidget(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
            onClick: () {
              showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    content: Text('balabala'),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class FlowableWidget extends StatefulWidget {
  final double parentWidth;
  final double parentHeight;

  final double padding;

  final Function()? onClick;

  final double size;

  FlowableWidget(
    this.parentWidth,
    this.parentHeight, {
    this.size = 50,
    this.padding = 12,
    this.onClick,
  });

  @override
  _FlowableWidgetState createState() => _FlowableWidgetState();
}

class _FlowableWidgetState extends State<FlowableWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  /// position
  late double? left;
  late double? top;

  late double? startX;
  late double? endX;

  late double? startY;
  late double? endY;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        updatePosition();
      });

    left = widget.parentWidth - widget.padding - widget.size;
    top = widget.parentHeight - widget.padding - widget.size;
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void checkPosition(double x, double y) {
    startX = x;

    if (x + (widget.size / 2) < widget.parentWidth / 2) {
      endX = widget.padding;
    } else {
      endX = widget.parentWidth - widget.padding - widget.size;
    }

    startY = y;

    endY = y;

    if (y < widget.padding) {
      endY = widget.padding;
    }

    if (y + widget.size > widget.parentHeight - widget.padding) {
      endY = widget.parentHeight - widget.padding - widget.size;
    }

    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: Draggable(
        feedback: Container(
          height: widget.size,
          width: widget.size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.size),
            color: Colors.lightBlueAccent,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(
                  2,
                  3,
                ),
                spreadRadius: 3,
                blurRadius: 3,
              )
            ],
          ),
          child: Center(
            child: Icon(
              Icons.person,
            ),
          ),
        ),
        childWhenDragging: Container(),
        onDragEnd: (detail) {
          setState(() {
            left = detail.offset.dx;
            top = detail.offset.dy;
            checkPosition(
              detail.offset.dx,
              detail.offset.dy,
            );
          });
        },
        onDragStarted: () {
          _controller.stop();
        },
        child: InkWell(
          borderRadius: BorderRadius.circular(widget.size),
          onTap: widget.onClick,
          child: Container(
            height: widget.size,
            width: widget.size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.size),
              color: Colors.lightBlueAccent,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(
                    2,
                    3,
                  ),
                  spreadRadius: 3,
                  blurRadius: 3,
                )
              ],
            ),
            child: Center(
              child: Icon(
                Icons.person,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updatePosition() {
    setState(() {
      left = getProgressValue(_animation.value, startX!, endX!);
      top = getProgressValue(_animation.value, startY!, endY!);
    });
  }

  double getProgressValue(double progress, double start, double end) {
    return (end - start) * progress + start;
  }
}
