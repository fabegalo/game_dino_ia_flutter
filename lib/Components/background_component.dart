import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:game_dino_ia/dino_game.dart';

class BackgroundComponent extends SpriteComponent with HasGameRef<DinoGame> {
  @override
  Future<void>? onLoad() async {
    sprite = await Sprite.load('background.jpg');
    size = gameRef.size;

    return super.onLoad();
  }
}