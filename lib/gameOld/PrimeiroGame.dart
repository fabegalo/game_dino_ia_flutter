//import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:game_dino_ia/game/componentes/DinoBox.dart';
import 'package:game_dino_ia/game/componentes/EnemyCrate.dart';
import 'package:game_dino_ia/game/componentes/PlacarScore.dart';
import 'componentes/fly.dart';
import 'componentes/background.dart';
import 'componentes/Collider.dart';
import 'componentes/EnemyBox.dart';
import 'componentes/dino.dart';

import 'dart:math';

class PrimeiroGame extends FlameGame {
  int mortes = 0;
  double populacao = 50;
  double velocity = 2;
  double gravity = 2;
  Size screenSize;
  double tileSize;
  Background background;
  List<Fly> flies;
  List<DinoBox> dinos;
  List<EnemyBox> enemys;
  Collider colliderController;
  PlacarScore placar;
  Random rnd;
  bool gameStarted = false;

  PrimeiroGame() {
    initialize();
  }

  @override
  Future<void> onLoad() async {
    return super.onLoad();
  }

  void initialize() async {
    flies = List<Fly>();
    dinos = List<DinoBox>();
    enemys = List<EnemyBox>();
    colliderController = new Collider(this);
    placar = new PlacarScore(this);
    rnd = Random();
    resize(await Flame.util.initialDimensions());

    background = Background(this);

    for (var x = 0; x < populacao; x++) {
      dinos.add(Dino(this, (screenSize.width - tileSize) - 310,
          (screenSize.height - tileSize) - 170));
    }

    spawnFly();
  }

  void spawnFly() {
    //double x = rnd.nextDouble() * (screenSize.width - tileSize);
    //double y = rnd.nextDouble() * (screenSize.height - tileSize);

    enemys.add(EnemyCrate(this, (screenSize.width - tileSize) - (-400),
        (screenSize.height - tileSize) - 150));

    //flies.add(HouseFly(this, x, y));
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    background.render(canvas);
    dinos.forEach((DinoBox dinos) => dinos.render(canvas));
    flies.forEach((Fly fly) => fly.render(canvas));

    enemys.forEach((EnemyBox enemy) => enemy.render(canvas));

    placar.render(canvas);

    super.render(canvas);
  }

  @override
  void update(double t) {
    // TODO: implement update

    if (mortes == dinos.length) {
      initialize();
    }

    if (gameStarted) {
      flies.forEach((Fly fly) => fly.update(t));
      flies.removeWhere((Fly fly) => fly.isOffScreen);

      dinos.forEach((DinoBox dinos) => dinos.update(t));

      var aux = 0;

      for (DinoBox d in dinos) {
        if (d.isDead) {
          aux++;
        }
      }

      mortes = aux;

      try {
        enemys.forEach((EnemyBox enemy) => {enemy.update(t)});
      } catch (e) {
        print(e);
      }

      enemys.removeWhere((EnemyBox enemy) => enemy.isOffScreen);

      background.update(t);

      colliderController.verificarColisao(enemys, dinos);

      dinos.forEach((DinoBox dino) => {
            if (dino != dinos[0]) {dino.pensa(velocity, enemys)}
          });
    }

    //print(velocity);

    if (velocity >= 10) {
      velocity = 10;
    }

    super.update(t);
  }

  @override
  void resize(Size size) {
    screenSize = size;
    print(size);
    tileSize = screenSize.width / 9;
    super.resize(size);
  }

  void onTapDown(TapDownDetails d) {
    print('Bati na tela!');
    //gameStarted = true;
    velocity++;

    //dinos.forEach((DinoBox dinos) {
    //if (dinos.flyRect.contains(d.globalPosition)) {
    dinos[0].startJump(velocity);
    //}
    //});

    flies.forEach((Fly fly) {
      if (fly.flyRect.contains(d.globalPosition)) {
        fly.onTapDown();
      }
    });
  }
}
