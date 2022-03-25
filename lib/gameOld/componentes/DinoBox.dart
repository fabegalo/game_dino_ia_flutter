import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
import 'package:game_app_flutter/game/componentes/EnemyBox.dart';
import 'package:game_app_flutter/game/redeNeural/redeNeural.dart';
import '../PrimeiroGame.dart';

class DinoBox {
  final PrimeiroGame game;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  Rect flyRect;
  bool isDead = false;
  bool isOffScreen = false;
  bool isJumping = false;
  double x, y;
  double initialJumpVelocity = -25.5;
  double jumpVelocity = 0;
  bool reachedMinHeight = false;
  int jumpCount = 0;
  double height = 50.0;
  double width = 50.0;
  int score = 0;
  List<double> genes = new List<double>();
  RedeNeural cerebro;

  DinoBox(this.game, this.x, this.y) {
    this.setRandom();
    cerebro = new RedeNeural(this);
  }

  double get groundYPos {
    if (game.screenSize == null) {
      return null;
    }

    return (game.screenSize.height - game.tileSize) - 170;
  }

  void render(Canvas c) {
    flyRect = new Rect.fromLTWH(
      x,
      y,
      90,
      90,
    );

    if (isDead) {
      deadSprite.renderRect(c, flyRect.inflate(2));
    } else {
      flyingSprite[flyingSpriteIndex.toInt()].renderRect(c, flyRect.inflate(2));
    }
  }

  void update(double t) async {
    if (isDead) {
      x = x - game.velocity;
    } else {
      score++;

      flyingSpriteIndex += game.velocity * t;
      if (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }

      if (isJumping) {
        y += jumpVelocity;
        jumpVelocity += game.gravity;

        if (y > groundYPos) {
          reset();
          jumpCount++;
        }
      } else {
        y = groundYPos;
      }
    }
  }

  void startJump(double speed) {
    if (isJumping) {
      return;
    }

    isJumping = true;
    jumpVelocity = initialJumpVelocity - (speed / 10);

    reachedMinHeight = false;
  }

  void reset() {
    y = groundYPos;
    jumpVelocity = 0.0;
    jumpCount = 0;
    isJumping = false;
  }

  void jump() {
    print('Pulei!');
    isJumping = true;
  }

  void onTapDown() {
    jump();
    //isDead = true;
    //game.spawnFly();
  }

  void setRandom() {
    genes.clear();

    double maximum = 10;
    double minimum = -10;
    Random random = new Random();

    double newGene = 0;
    for (int z = 0; z < 8; z++) {
      newGene = random.nextDouble() * ((maximum - minimum)) + minimum;
      this.genes.add(newGene);
    }
  }

  void pensa(double velocidade, List<EnemyBox> enemys) {
    EnemyBox aux = enemys.first;

    //print(aux.x);
    //print(x);
    int distancia = (aux.x.toInt() - x.toInt()) - 30;

    print('Distancia é: $distancia');

    cerebro.setDistancia(distancia);

    cerebro.setVelocidade(velocidade.toInt());

    bool acao = cerebro.redeNeural();

    if (acao) {
      this.startJump(velocidade);
    }
  }
}
