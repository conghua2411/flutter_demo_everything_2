import 'package:flame/game.dart';
import 'package:flutter_demo_everything_2/demo_info.dart';
import 'package:flutter_demo_everything_2/game/games/shooting_duck/shooting_duck.dart';

var shootingDuckInfo = DemoInfo(
  demo: GameWidget(
    game: ShootingDuck(),
  ),
  name: 'Shooting duck',
);
