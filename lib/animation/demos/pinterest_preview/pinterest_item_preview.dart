import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';

class PinterestItemPreview extends StatefulWidget {
  final PinterestItemDpo dpo;

  const PinterestItemPreview({
    Key? key,
    required this.dpo,
  }) : super(key: key);

  @override
  State<PinterestItemPreview> createState() => _PinterestItemPreviewState();
}

class _PinterestItemPreviewState extends State<PinterestItemPreview>
    with TickerProviderStateMixin {
  bool _clicked = false;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      _animationController,
    )..addListener(
        _animationListener,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          _clicked = !_clicked;
          if (_clicked) {
            _animationController.forward();
          } else {
            _animationController.reverse();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: _clicked ? Color(0xFF36E3EB) : Colors.grey[200],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 140,
                height: 140,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Transform.rotate(
                          angle: -pi / (15 + 10 * (1 - _animation.value)),
                          origin: Offset(0, 140),
                          child: _image(widget.dpo.first),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      bottom: 30 * _animation.value,
                      child: Align(
                        alignment: Alignment.center,
                        child: _image(
                          widget.dpo.second,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Transform.rotate(
                          angle: pi / (15 + 10 * (1 - _animation.value)),
                          origin: Offset(0, 140),
                          child: _image(
                            widget.dpo.third,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  widget.dpo.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _image(String url) {
    return Container(
      width: 70,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 10,
            spreadRadius: 2,
            color: Colors.black12,
          ),
        ],
      ),
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
}

class PinterestItemDpo {
  final String first;
  final String second;
  final String third;

  final String name;

  PinterestItemDpo({
    required this.first,
    required this.second,
    required this.third,
    required this.name,
  });
}
