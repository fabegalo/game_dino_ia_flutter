import 'dart:math';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:game_dino_ia/RedeNeural/rede_neural.dart';
import 'package:game_dino_ia/components/enemy_component.dart';
import 'package:game_dino_ia/dino_game.dart';
import 'package:flame/sprite.dart';
import 'package:game_dino_ia/game_state.dart';
import 'package:flame/palette.dart';

/// Descreve o estado de renderização do [DinoComponent].
enum DinoState {
  /// Dino Parado.
  idle,

  /// Dino Pulando.
  //jumping,

  /// Dino Correndo.
  running,

  /// Dino Correndo Igual Flash.
  runningFlash,
}

/// A component that renders the Rocket with the different states.
class DinoComponent extends SpriteAnimationGroupComponent<DinoState>
    with CollisionCallbacks, HasGameRef<DinoGame> {
  /// Create a new Dino component at the given [position].
  DinoComponent({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size, animations: {});

  //final _speed = 10;
  //final _animationSpeed = .1;
  // _animationTime = 0.0;
  bool isJumping = false;
  double initialJumpVelocity = -25.5;
  double jumpVelocity = 10;
  bool reachedMinHeight = false;
  int jumpCount = 0;
  bool isDead = false;
  bool isBot = true;
  bool isOffScreen = false;

  int score = 0;
  List<double> genes = [];
  late RedeNeural cerebro;

  double get groundYPos {
    if (gameRef.size.y > gameRef.size.x) {
      return gameRef.size.yx.y / 0.6;
    } else {
      return gameRef.size.y / 1.5;
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    setRandom();
    position.y = groundYPos;
    cerebro = RedeNeural(this);

    const stepTime = .2;
    const frameCount = 2;
    Image image;

    if (!isBot) {
      image = await gameRef.images.load('spritesheet_player.png');
    } else {
      image = await gameRef.images.load('spritesheet.png');
    }

    final sheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: frameCount,
      rows: 1,
    );

    final idle = sheet.createAnimation(row: 1, stepTime: stepTime);
    final running = sheet.createAnimation(row: 0, stepTime: stepTime);

    final runningFlash = SpriteSheet.fromColumnsAndRows(
            image: await gameRef.images.load('spritesheet_flash.png'),
            columns: frameCount,
            rows: 1)
        .createAnimation(row: 0, stepTime: .1);

    animations = {
      DinoState.idle: idle,
      DinoState.running: running,
      DinoState.runningFlash: runningFlash,
    };

    current = DinoState.running;

    // final shape = PolygonHitbox([
    //   //X - Y
    //   Vector2(0.4, 0.9), //Canto Inferior Direito
    //   Vector2(1, -1), //Canto Superior Direito
    //   Vector2(-1, -0.5), //Canto Superior Esquerdo
    //   Vector2(-0.6, 0.9), //Canto Inferior Esquerdo
    // ]);

    // final shape = PolygonComponent.relative([
    //   //X - Y
    //   Vector2(0.4, 0.9), //Canto Inferior Direito
    //   Vector2(1, -1), //Canto Superior Direito
    //   Vector2(-1, -0.5), //Canto Superior Esquerdo
    //   Vector2(-0.6, 0.9), //Canto Inferior Esquerdo
    // ], parentSize: size, paint: Paint());

    final shape = PolygonHitbox.relative([
      //X - Y
      Vector2(0.4, 0.9), //Canto Inferior Direito
      Vector2(1, -1), //Canto Superior Direito
      Vector2(-1, -0.5), //Canto Superior Esquerdo
      Vector2(-0.6, 0.9), //Canto Inferior Esquerdo
    ], parentSize: size);

    add(shape);

    // final hitboxPaint = BasicPalette.white.paint()
    //   ..style = PaintingStyle.stroke;

    // add(
    //   PolygonHitbox.relative(
    //     [
    //       Vector2(0.0, -1.0),
    //       Vector2(-1.0, -0.1),
    //       Vector2(-0.2, 0.4),
    //       Vector2(0.2, 0.4),
    //       Vector2(1.0, -0.1),
    //     ],
    //     parentSize: size,
    //   )
    //     ..paint = hitboxPaint
    //     ..renderShape = true,
    // );

    //addHitbox(HitboxCircle());
  }

  // @override
  // bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
  //   if (event is RawKeyDownEvent) {
  //     if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
  //     } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
  //     } else {}
  //   }
  //   return true;
  // }

  // // Place holder, later we need to animate based on speed in a given direction.
  // void _setAnimationState() {
  //   switch (_heading) {
  //     case RocketHeading.idle:
  //       if (current != RocketState.idle) {
  //         if (current == RocketState.farLeft) {
  //           current = RocketState.left;
  //         } else if (current == RocketState.farRight) {
  //           current = RocketState.right;
  //         } else {
  //           current = RocketState.idle;
  //         }
  //       }
  //       break;
  //     case RocketHeading.left:
  //       if (current != RocketState.farLeft) {
  //         if (current == RocketState.farRight) {
  //           current = RocketState.right;
  //         } else if (current == RocketState.right) {
  //           current = RocketState.idle;
  //         } else if (current == RocketState.idle) {
  //           current = RocketState.left;
  //         } else {
  //           current = RocketState.farLeft;
  //         }
  //       }
  //       break;
  //     case RocketHeading.right:
  //       if (current != RocketState.farRight) {
  //         if (current == RocketState.farLeft) {
  //           current = RocketState.left;
  //         } else if (current == RocketState.left) {
  //           current = RocketState.idle;
  //         } else if (current == RocketState.idle) {
  //           current = RocketState.right;
  //         } else {
  //           current = RocketState.farRight;
  //         }
  //       }
  //       break;
  //   }
  // }

  void setRandom() {
    genes.clear();

    double maximum = 10;
    double minimum = -10;
    Random random = Random();

    double newGene = 0;
    for (int z = 0; z < 8; z++) {
      newGene = random.nextDouble() * ((maximum - minimum)) + minimum;
      genes.add(newGene);
    }
  }

  // @override
  // void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
  //   super.onCollisionStart(intersectionPoints, other);
  //   flipVertically();

  //   print('bateu');
  //   print(other);
  // }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is EnemyComponent &&
        GameState.playState == PlayingState.playing &&
        isDead == false &&
        isBot == false) {
      isDead = true;
    }

    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is EnemyComponent &&
        GameState.playState == PlayingState.playing &&
        isDead == false) {
      isDead = true;
    }

    super.onCollisionEnd(other);
  }

  void pensa(double velocidade, List<EnemyComponent> enemys) {
    if (enemys.isEmpty || isBot == false) {
      return;
    }

    EnemyComponent aux = enemys.first;

    int distancia = (aux.x.toInt() - x.toInt()) - 30;

    cerebro.setDistancia(distancia);

    cerebro.setVelocidade(velocidade.toInt());

    bool acao = cerebro.redeNeural();

    if (acao) {
      startJump(velocidade);
    }
  }

  void reset() {
    y = groundYPos;
    jumpVelocity = 0.0;
    jumpCount = 0;
    isJumping = false;
  }

  void startJump(double speed) {
    if (isJumping) {
      return;
    }

    isJumping = true;
    jumpVelocity = initialJumpVelocity - (speed / 10);

    reachedMinHeight = false;
  }

  @override
  void update(double dt) {
    if (isDead && isOffScreen) {
      removeFromParent();
      //remove(this);
      return;
    }

    if (gameRef.velocity >= 20) {
      current = DinoState.runningFlash;
    }

    if (isDead) {
      x = x - gameRef.velocity;

      double screnWidth = (gameRef.size.x - gameRef.size.x) - gameRef.size.x;

      if (position.x < screnWidth) {
        isOffScreen = true;
      }
    } else {
      pensa(gameRef.velocity, gameRef.enemys);
      score++;

      // position.y += _speed * dt;
      // _animationTime += dt;
      // if (_animationTime >= _animationSpeed) {
      //   //_setAnimationState();
      //   _animationTime = 0;
      // }

      if (isJumping) {
        position.y += jumpVelocity;
        jumpVelocity += gameRef.gravity;

        if (y > groundYPos) {
          reset();
          jumpCount++;
        }
      } else {
        position.y = groundYPos;
      }
    }

    super.update(dt);
  }
}
