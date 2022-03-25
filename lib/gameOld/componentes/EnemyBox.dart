import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
import '../PrimeiroGame.dart';

class EnemyBox {
  final PrimeiroGame game;
  double x;
  double y;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  Rect flyRect;
  double aux = 0;
  bool isDead = false;
  bool isOffScreen = false;
  double height = 30.0;
  double width = 30.0;

  EnemyBox(this.game, this.x, this.y);

  void render(Canvas c) {
    flyRect = new Rect.fromLTWH(
      x,
      y,
      70,
      70,
    );

    if (isDead) {
      deadSprite.renderRect(c, flyRect.inflate(2));
    } else {
      flyingSprite[flyingSpriteIndex.toInt()].renderRect(c, flyRect.inflate(2));
    }
  }

  void update(double t) async {
    try {
      if (!isDead) {
        x = x - game.velocity;
        double screnWidth = (game.screenSize.width - game.screenSize.width) -
            game.screenSize.width;

        if (flyRect.left < screnWidth) {
          print('Morri!');
          game.spawnFly();
          isOffScreen = true;
          isDead = true;
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
