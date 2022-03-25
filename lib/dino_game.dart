import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/painting.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:game_dino_ia/components/dino_component.dart';
import 'package:game_dino_ia/components/enemy_component.dart';
import 'package:game_dino_ia/components/placar_component.dart';
import 'package:game_dino_ia/game_state.dart';

class DinoGame extends FlameGame
    with
        HasCollidables,
        HasTappables,
        HasKeyboardHandlerComponents,
        HasDraggables,
        FPSCounter {
  late DinoComponent _dino;

  Function refresher;

  DinoGame(this.refresher);

  ///The rocket component currnetly in the game
  DinoComponent get dino => _dino;

  late int mortes;
  late int populacao;
  late double velocity;
  late double gravity;
  late ParallaxComponent parallaxComponent;

  List<DinoComponent> dinos = [];
  List<EnemyComponent> enemys = [];

  static final fpsTextConfig = TextPaint();

  void onOverlayChanged() {
    if (overlays.isActive('pause')) {
      pauseEngine();
    } else {
      resumeEngine();
      GameState.playState = PlayingState.playing;
    }
  }

  @override
  bool onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);
    _dino.startJump(velocity);
    velocity++;
    parallaxComponent.parallax?.baseVelocity = Vector2(velocity * 10, 0);
    return true;
  }

  @override
  bool get debugMode => GameState.showDebugInfo;

  @override
  void onMount() {
    overlays.addListener(onOverlayChanged);
    super.onMount();
  }

  @override
  void onRemove() {
    overlays.removeListener(onOverlayChanged);
    super.onRemove();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final fpsCount = fps(120); // The average FPS for the last 120 microseconds.
    fpsTextConfig.render(
        canvas, 'FPS:' + fpsCount.toString(), Vector2(size.x - 130, 20));
  }

  @override
  void update(double dt) {
    refresher();
    enemys.removeWhere((EnemyComponent enemy) => enemy.isOffScreen);
    dinos.removeWhere((DinoComponent dino) => dino.isOffScreen);

    var aux = 0;
    for (DinoComponent d in dinos) {
      if (d.isDead) {
        aux++;
      }
    }
    mortes = aux;

    if (mortes == dinos.length && GameState.playState == PlayingState.playing) {
      removeAll(enemys);
      gameOver();
    }

    if (velocity >= 20) {
      velocity = 20;
    }

    super.update(dt);
  }

  void spawnEnemy() async {
    double maximum = 10;
    double minimum = 1.2;
    Random random = Random();

    var enemy = EnemyComponent(
        position:
            size * (random.nextDouble() * ((maximum - minimum)) + minimum),
        size: Vector2(20, 70));

    enemys.add(enemy);
    await add(enemy);
  }

  @override
  Future<void> onLoad() async {
    await inicializaBotsAndPlayer();

    return super.onLoad();
  }

  void gameOver() {
    GameState.playState = PlayingState.lost;
    overlays.add('pause');
  }

  void restart() async {
    removeAll(enemys);
    removeAll(dinos);
    _removeAnyOverlay();
    children.removeAll(children);

    await inicializaBotsAndPlayer();
    GameState.playState = PlayingState.playing;
  }

  Future<void> inicializaBotsAndPlayer() async {
    dinos = [];
    enemys = [];
    mortes = 0;
    populacao = GameState.populacao;
    velocity = GameState.velocidade;
    gravity = GameState.gravidade;

    parallaxComponent = await loadParallaxComponent(
      [
        ParallaxImageData('background.jpg'),
        ParallaxImageData('background.jpg'),
      ],
      baseVelocity: Vector2(velocity * 10, 0),
      velocityMultiplierDelta: Vector2(1.8, 1.0),
    );
    await add(parallaxComponent);

    parallaxComponent.parallax?.baseVelocity = Vector2(velocity * 10, 0);

    for (var x = 0; x < populacao; x++) {
      dinos.add(DinoComponent(position: size / 10, size: Vector2(74, 90)));
    }

    for (DinoComponent dino in dinos) {
      await add(dino);
      //await add(DinoPosition(dino));
    }

    _dino = DinoComponent(position: size / 10, size: Vector2(74, 90));
    _dino.isBot = false;
    dinos.add(_dino);
    await add(_dino);
    //await add(DinoPosition(_dino));

    await add(PlacarComponent(dinos));

    for (var x = 0; x < 2; x++) {
      enemys.add(EnemyComponent(position: size * 1.2, size: Vector2(20, 70)));
    }

    for (EnemyComponent enemy in enemys) {
      await add(enemy);
    }
  }

  void _removeAnyOverlay() {
    for (final activeOverlay in overlays.value.toList()) {
      overlays.remove(activeOverlay);
    }
  }
}
