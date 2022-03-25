import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_dino_ia/dino_game.dart';
import 'package:flame/sprite.dart';

/// Descreve o estado de renderização do [DinoComponent].
enum EnemyState {
  /// Enemy Parado.
  idle,
}

/// A component that renders the Rocket with the different states.
class EnemyComponent extends SpriteAnimationGroupComponent<EnemyState>
    with HasHitboxes, Collidable, HasGameRef<DinoGame> {
  /// Create a new Dino component at the given [position].
  EnemyComponent({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size, animations: {});

  final _speed = 10;
  final _animationSpeed = .1;
  var _animationTime = 0.0;
  bool isJumping = false;
  double initialJumpVelocity = -25.5;
  double jumpVelocity = 0;
  bool reachedMinHeight = false;
  int jumpCount = 0;
  bool isDead = false;
  bool isOffScreen = false;

  double get groundYPos {
    if (gameRef.size.y > gameRef.size.x) {
      return gameRef.size.y - 110;
    } else {
      return gameRef.size.y - 85;
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    position.y = groundYPos;

    const stepTime = .3;
    const frameCount = 2;
    final image = await gameRef.images.load('spritesheet.png');
    final sheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: frameCount,
      rows: 1,
    );

    final idle = sheet.createAnimation(row: 1, stepTime: stepTime);
    //final running = sheet.createAnimation(row: 0, stepTime: stepTime);

    animations = {
      EnemyState.idle: idle,
      //EnemyState.running: running,
    };

    current = EnemyState.idle;
    addHitbox(HitboxCircle());
  }

  @override
  void update(double dt) {
    if (!isDead) {
      x = x - gameRef.velocity;
      double screnWidth = (gameRef.size.x - gameRef.size.x) - gameRef.size.x;

      if (position.x < screnWidth) {
        gameRef.spawnEnemy();
        isOffScreen = true;
        isDead = true;
        removeFromParent();
        remove(this);
      }
    }

    super.update(dt);
  }
}
