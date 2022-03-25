import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import 'dart:async';
import 'package:game_dino_ia/dino_game.dart';
import 'package:game_dino_ia/game_state.dart';
import 'package:game_dino_ia/widgets/config_game.dart';
import 'package:game_dino_ia/widgets/menu_game.dart';
import 'package:game_dino_ia/widgets/pause_menu.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.setPortrait();
  //await Flame.device.setOrientation(DeviceOrientation.portraitUp);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/menu": (context) => const MenuGame(),
        "/config": (context) => const ConfigGame(),
        "/game": (context) => const ModalGame(),
      },
      title: 'App Game Dino',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const MenuGame(),
    );
  }
}

class ModalGame extends StatefulWidget {
  const ModalGame({Key? key}) : super(key: key);

  @override
  _ModalGameState createState() {
    return _ModalGameState();
  }
}

class _ModalGameState extends State<ModalGame> {
  late DinoGame game;

  @override
  void initState() {
    super.initState();
    game = DinoGame(refresh);
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('App Bar Do Game'),
      // ),
      body: GameWidget(
        game: game,
        //Work in progress loading screen on game start
        loadingBuilder: (context) => const Material(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        //Work in progress error handling
        errorBuilder: (context, ex) {
          //Print the error in th dev console
          debugPrint(ex.toString());
          return const Material(
            child: Center(
              child: Text('Desculpe, algo deu errado. Recarregue-me'),
            ),
          );
        },
        overlayBuilderMap: {
          'pause': (context, DinoGame game) => PauseMenu(game: game),
          // 'levelSelection': (context, MoonlanderGame game) => LevelSelection(
          //       game,
          //     ),
          // 'highscore': (context, MoonlanderGame game) =>
          //     HighscoreOverview(game),
          // 'enterSeed': (context, MoonlanderGame game) => EnterSeed(game),
        },
      ),
      floatingActionButton: (GameState.playState == PlayingState.playing)
          ? FloatingActionButton(
              child: game.paused
                  ? const Icon(Icons.play_arrow)
                  : const Icon(Icons.pause),
              onPressed: () {
                if (game.overlays.isActive('pause')) {
                  game.overlays.remove('pause');
                  if (GameState.playState == PlayingState.paused) {
                    GameState.playState = PlayingState.playing;
                  }
                } else {
                  if (GameState.playState == PlayingState.playing) {
                    GameState.playState = PlayingState.paused;
                  }
                  game.overlays.add('pause');
                }

                setState(() {});
              },
            )
          : SizedBox(),
    );

    //return game.widget;
  }
}
