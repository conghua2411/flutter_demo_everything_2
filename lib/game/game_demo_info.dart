import '../demo_info.dart';
import 'game_demos.dart';
import 'games/shooting_duck/shooting_duck_info.dart';

var gameDemoInfo = DemoInfo(
  name: 'Game',
  demo: GameDemos(),
  subDemo: gameDemos,
);

var gameDemos = [
  shootingDuckInfo,
];
