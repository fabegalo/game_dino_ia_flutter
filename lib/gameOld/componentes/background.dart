import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:game_app_flutter/game/PrimeiroGame.dart';
import '../PrimeiroGame.dart';

class Background {
  PrimeiroGame game;
  double velocity;

  Sprite bgSprite;
  Rect backRect;
  double aux = -85;

  Sprite bgSprite2;
  Rect backRect2;
  double aux2 = 390;

  Background(this.game) {
    bgSprite = Sprite('background.jpg');
    bgSprite2 = Sprite('background.jpg');
  }

  void render(Canvas c) {
    backRect = new Rect.fromLTWH(
      aux,
      game.screenSize.height - (game.tileSize * 23),
      game.tileSize * 11,
      game.tileSize * 23,
    );

    backRect2 = new Rect.fromLTWH(
      aux2,
      game.screenSize.height - (game.tileSize * 23),
      game.tileSize * 11,
      game.tileSize * 23,
    );

    bgSprite.renderRect(c, backRect);
    bgSprite2.renderRect(c, backRect2);
  }

  void update(double t) {
    velocity = game.velocity;

    aux = aux - velocity;
    aux2 = aux2 - velocity;

    if (aux < (-550) + velocity) {
      //print('1 : $aux');
      aux = 400;
    }

    if (aux2 < (-550) + velocity) {
      //print('2: $aux2');
      aux2 = 400;
    }
  }
}
