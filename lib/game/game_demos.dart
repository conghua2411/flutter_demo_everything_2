import 'package:flutter/material.dart';

import '../demo_info.dart';
import 'game_demo_info.dart';

class GameDemos extends StatefulWidget {
  const GameDemos({Key? key}) : super(key: key);

  @override
  State<GameDemos> createState() => _GameDemosState();
}

class _GameDemosState extends State<GameDemos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game'),
      ),
      body: ListView.builder(
        itemCount: gameDemos.length,
        itemBuilder: (context, index) {
          return _buildGameDemoButton(
            gameDemos[index],
          );
        },
      ),
    );
  }

  Widget _buildGameDemoButton(DemoInfo game) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => game.demo!,
          ),
        );
      },
      child: Text('${game.name}'),
    );
  }
}
