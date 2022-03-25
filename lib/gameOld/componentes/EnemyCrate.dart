import 'package:flame/sprite.dart';
import 'package:game_app_flutter/game/componentes/EnemyBox.dart';
import '../PrimeiroGame.dart';

class EnemyCrate extends EnemyBox {
  EnemyCrate(PrimeiroGame game, double x, double y) : super(game, x, y) {
    //flyRect = Rect.fromLTWH(x, y, 90, 90);
    flyingSprite = List<Sprite>();

    // Flame.images.loadAll(["sprite.png"]).then((image) => {
    //   flyingSprite.add(Sprite('dino.png'));
    //   flyingSprite.add(Sprite('dino.png'));
    //   image[0]
    // });

    flyingSprite.add(Sprite('crate2.png'));
    flyingSprite.add(Sprite('crate2.png'));
    deadSprite = Sprite('crate2.png');
  }
}
