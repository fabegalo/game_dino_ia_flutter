import 'package:game_app_flutter/game/PrimeiroGame.dart';
import 'package:game_app_flutter/game/componentes/DinoBox.dart';
import 'package:game_app_flutter/game/componentes/EnemyBox.dart';

class Collider {
  PrimeiroGame game;

  Collider(this.game);

  void verificarColisao(List<EnemyBox> enemys, List<DinoBox> dinos) {
    for (DinoBox dino in dinos) {
      for (EnemyBox enemy in enemys) {
        if (checkForCollision(enemy, dino)) {
          //print('Bateu Porra!');
          dino.isDead = true;
        }
      }
    }
  }

  bool checkForCollision(EnemyBox obstacle, DinoBox tRex) {
    final tRexBox = CollisionBox(
      x: tRex.x + 1,
      y: tRex.y + 1,
      width: tRex.width - 2,
      height: tRex.height - 2,
    );

    final obstacleBox = CollisionBox(
      x: obstacle.x + 1,
      y: obstacle.y + 1,
      width: obstacle.width - 2,
      height: obstacle.height - 2,
    );

    if (boxCompare(tRexBox, obstacleBox)) {
      bool crashed = false;

      crashed = crashed || boxCompare(tRexBox, obstacleBox);

      return crashed;
    }

    return false;
  }

  bool boxCompare(CollisionBox tRexBox, CollisionBox obstacleBox) {
    final double obstacleX = obstacleBox.x;
    final double obstacleY = obstacleBox.y;

    return tRexBox.x < obstacleX + obstacleBox.width &&
        tRexBox.x + tRexBox.width > obstacleX &&
        tRexBox.y < obstacleBox.y + obstacleBox.height &&
        tRexBox.height + tRexBox.y > obstacleY;
  }

  CollisionBox createAdjustedCollisionBox(
      CollisionBox box, CollisionBox adjustment) {
    return CollisionBox(
      x: box.x + adjustment.x,
      y: box.y + adjustment.y,
      width: box.width,
      height: box.height,
    );
  }
}

class CollisionBox {
  const CollisionBox({
    this.x,
    this.y,
    this.width,
    this.height,
  });
  final double x;
  final double y;
  final double width;
  final double height;
}
