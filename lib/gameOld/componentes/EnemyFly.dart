import 'dart:ui';
import 'package:flame/sprite.dart';
import 'fly.dart';
import '../PrimeiroGame.dart';

class HouseFly extends Fly {
  double get speed => game.tileSize * 5;

  HouseFly(PrimeiroGame game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.5, game.tileSize * 1.5);
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('flies/house-fly-1.png'));
    flyingSprite.add(Sprite('flies/house-fly-1.png'));
    deadSprite = Sprite('flies/house_dead.png');
  }
}
