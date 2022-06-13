import 'dart:ui';

import 'package:flutter/material.dart';

class ScreenBlurDemo extends StatefulWidget {
  const ScreenBlurDemo({Key? key}) : super(key: key);

  @override
  State<ScreenBlurDemo> createState() => _ScreenBlurDemoState();
}

class _ScreenBlurDemoState extends State<ScreenBlurDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 7.0,
    ).animate(
      _animationController,
    )..addListener(
        _animationListener,
      );

    _animationController.repeat(
      reverse: true,
    );
  }

  void _animationListener() {
    setState(() {});
  }

  @override
  void dispose() {
    _animation.removeListener(_animationListener);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Screen blur demo'),
          ),
          body: SafeArea(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ItemImageWidget(
                  url: 'https://picsum.photos/id/${200 + index}/200/300',
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _showBur,
            child: Icon(
              Icons.blur_circular,
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: _animation.value,
            sigmaY: _animation.value,
          ),
          child: IgnorePointer(
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }

  void _showBur() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext ctx) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: AlertDialog(
            elevation: 10,
            title: const Text('Title'),
            content: const Text('Some content here'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'))
            ],
          ),
        );
      },
    );
  }
}

class ItemImageWidget extends StatelessWidget {
  final String url;

  const ItemImageWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
