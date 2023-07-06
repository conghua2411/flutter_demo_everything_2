import 'dart:math';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

int score = 0;
bool pause = false;

class ShootingDuck extends FlameGame {
  List<Duck> listDucks = [];
  int _maxDuck = 10;

  double _timePass = 0;
  Random rng = Random();

  late TextComponent scoreText;

  final _shaded = TextPaint(
    style: TextStyle(
      color: BasicPalette.white.color,
      fontSize: 40.0,
      shadows: const [
        Shadow(
          color: Colors.red,
          offset: Offset(2, 2),
          blurRadius: 2,
        ),
        Shadow(
          color: Colors.yellow,
          offset: Offset(4, 4),
          blurRadius: 4,
        ),
      ],
    ),
  );

  @override
  Future<void> onLoad() async {
    scoreText = TextComponent(text: 'Score: $score', textRenderer: _shaded)
      ..anchor = Anchor.topRight
      ..position = size - Vector2.all(100);
    add(
      scoreText,
    );
  }

  Duck? _spawnDuck() {
    for (var duck in listDucks) {
      if (!duck.visible) {
        duck.resetDuck();
        return duck;
      }
    }

    if (listDucks.length < _maxDuck) {
      Duck duck = Duck();

      listDucks.add(duck);
      add(duck);

      return duck;
    }

    return null;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (pause) {
      scoreText..anchor = Anchor.center;
      return;
    }

    _timePass += dt;

    scoreText.text = 'Score: $score';

    if (_timePass >= 0.8) {
      _timePass = 0;
      Duck? duck = _spawnDuck();
      if (duck != null) {
        duck.position = Vector2(
          rng.nextDouble() * (size.x - 100),
          0,
        );
      }
    }
  }
}

class Duck<T extends FlameGame> extends SpriteAnimationComponent
    with HasGameRef<T>, TapCallbacks {
  bool _visible = true;

  bool get visible => _visible;

  void resetDuck() async {
    _visible = true;
    animation = await gameRef.loadSpriteAnimation(
      'animations/ember.png',
      SpriteAnimationData.sequenced(
        amount: 3,
        stepTime: 0.2,
        textureSize: Vector2.all(16),
      ),
    );
  }

  double dropSpeed;

  Duck({
    Vector2? position,
    Vector2? size,
    this.dropSpeed = 150,
  }) : super(
          position: position,
          size: size ?? Vector2.all(50),
        );

  @override
  Future<void> onLoad() async {
    animation = await gameRef.loadSpriteAnimation(
      'animations/ember.png',
      SpriteAnimationData.sequenced(
        amount: 3,
        stepTime: 0.2,
        textureSize: Vector2.all(16),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (pause) {
      return;
    }

    y += dropSpeed * dt;

    if (y > gameRef.size.y) {
      _visible = false;
      pause = true;
    }
  }

  @override
  bool onTapDown(TapDownEvent event) {
    if (pause) {
      return true;
    }

    score++;
    _visible = false;
    animation = null;
    return true;
  }
}
