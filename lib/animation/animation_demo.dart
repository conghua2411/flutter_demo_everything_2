import 'package:flutter/material.dart';
import 'package:flutter_demo_everything_2/demo_info.dart';

import 'ani_demos.dart';

class AnimationDemo extends StatefulWidget {
  @override
  _AnimationDemoState createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo> {
  late List<DemoInfo> anims;

  @override
  void initState() {
    super.initState();
    anims = aniDemos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Demo'),
      ),
      body: ListView.builder(
        itemBuilder: (_, index) {
          return _buildDemoBtn(anims[index]);
        },
        itemCount: anims.length,
      ),
    );
  }

  Widget _buildDemoBtn(DemoInfo info) {
    return TextButton(
      onPressed: () {
        _gotoAnim(info.demo!);
      },
      child: Text('${info.name}'),
    );
  }

  void _gotoAnim(Widget demo) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => demo,
      ),
    );
  }
}
