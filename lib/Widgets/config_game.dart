import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_dino_ia/ComponentesWidgets/checkbox.dart';
import 'package:game_dino_ia/ComponentesWidgets/container_widget.dart';
import 'package:game_dino_ia/dino_game.dart';
import 'package:game_dino_ia/game_state.dart';

/// By using the Flutter Widgets we can handle all non-game related UI through
/// widgets.
class ConfigGame extends StatefulWidget {
  /// The reference to the game.
  const ConfigGame({Key? key}) : super(key: key);

  @override
  _ConfigGameState createState() => _ConfigGameState();
}

class _ConfigGameState extends State<ConfigGame> {
  // late final BannerAd banner;
  // final listener = BannerAdListener(
  //   // Called when an ad is successfully received.
  //   onAdLoaded: (Ad ad) => print('Ad loaded.'),
  //   // Called when an ad request failed.
  //   onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //     // Dispose the ad here to free resources.
  //     ad.dispose();
  //     print('Ad failed to load: $error');
  //   },
  //   // Called when an ad opens an overlay that covers the screen.
  //   onAdOpened: (Ad ad) => print('Ad opened.'),
  //   // Called when an ad removes an overlay that covers the screen.
  //   onAdClosed: (Ad ad) => print('Ad closed.'),
  //   // Called when an impression occurs on the ad.
  //   onAdImpression: (Ad ad) => print('Ad impression.'),
  // );

  @override
  void initState() {
    super.initState();

    // if (!kIsWeb) {
    //   banner = BannerAd(
    //     adUnitId: Platform.isIOS
    //         ? 'ca-app-pub-3940256099942544/2934735716'
    //         : 'ca-app-pub-3940256099942544/6300978111',
    //     size: AdSize.banner,
    //     request: const AdRequest(),
    //     listener: listener,
    //   );
    //   banner.load();
    // }
  }

  void onChangeDebugCheckbox(bool newValue) {
    setStateIfMounted(() {
      GameState.showDebugInfo = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Configurações"),
        ),
        body: Stack(
          children: [
            Align(
              child: Container(
                width: 320,
                padding: const EdgeInsets.all(8),
                color: Colors.white,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Center(
                      child: Text(
                        _getTitle(),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    _getCheckBoxOption("Ativar Som", GameState.playSounds,
                        onChangeDebugCheckbox),
                    _getCheckBoxOption("Ativar Debug", GameState.showDebugInfo,
                        onChangeDebugCheckbox),
                    _getCheckBoxOption("Manter Colisão", GameState.hasCollision,
                        onChangeDebugCheckbox),

                    _getValueContainer('Velocidade', 'velocidade'),
                    _getValueContainer('Gravidade', 'gravidade'),
                    _getValueContainer('População', 'populacao')

                    // containerShadowHeightAndWidth(context,
                    //     const Text("Velocidade"), Colors.red, size, width),

                    //if (GameState.playState == PlayingState.paused)
                    //   _getButton(
                    //       'Resume', () => widget.game.overlays.remove('pause')),
                    // _getButton(
                    //   'Restart',
                    //   () {
                    //     widget.game.overlays.remove('pause');
                    //     widget.game.restart();
                    //   },
                    //),
                    //if (GameState.currentLevel != null)
                    // _getButton(
                    //   'Highscorse',
                    //   () {
                    //     widget.game.overlays.remove('pause');
                    //     widget.game.overlays.add('highscore');
                    //   },
                    // ),
                    // _getButton(
                    //   'Levels',
                    //   () {
                    //     widget.game.overlays.remove('pause');
                    //     widget.game.overlays.add('levelSelection');
                    //   },
                    // ),
                    // _getButton(
                    //   'Enter seed',
                    //   () {
                    //     widget.game.overlays.remove('pause');
                    //     widget.game.overlays.add('enterSeed');
                    //   },
                    // ),
                    //if (!kIsWeb) _getBannerAd(),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  // Widget _getBannerAd() {
  //   return Container(
  //     alignment: Alignment.center,
  //     width: banner.size.width.toDouble(),
  //     height: banner.size.height.toDouble(),
  //     child: AdWidget(ad: banner),
  //   );
  // }

  void addQtde(name) {
    switch (name) {
      case 'velocidade':
        setState(() {
          GameState.velocidade = GameState.velocidade + 1;
        });
        break;
      case 'gravidade':
        setState(() {
          GameState.gravidade = GameState.gravidade + 1;
        });
        break;
      case 'populacao':
        setState(() {
          GameState.populacao = GameState.populacao + 1;
        });
        break;
      default:
        return;
    }
  }

  void removeQtde(name) {
    switch (name) {
      case 'velocidade':
        setState(() {
          if (GameState.velocidade == 0) {
            return;
          }
          setState(() {
            GameState.velocidade = GameState.velocidade - 1;
          });
        });
        break;
      case 'gravidade':
        setState(() {
          if (GameState.gravidade == 0) {
            return;
          }
          setState(() {
            GameState.gravidade = GameState.gravidade - 1;
          });
        });
        break;
      case 'populacao':
        setState(() {
          if (GameState.populacao == 0) {
            return;
          }
          setState(() {
            GameState.populacao = GameState.populacao - 1;
          });
        });
        break;
      default:
        return;
    }
  }

  Widget _getValueContainer(campo, value) {
    return Row(children: <Widget>[
      const Spacer(),
      Text(campo + ": "),
      const Spacer(),
      Container(
        width: 50,
        margin: const EdgeInsets.all(2),
        child: TextButton(
          style: TextButton.styleFrom(
              primary: Colors.white, backgroundColor: Colors.red),
          child: const Icon(Icons.remove_circle_outline),
          onPressed: () {
            removeQtde(value);
          },
        ),
      ),
      Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(_getValorByName(value)),
        ),
      ),
      Container(
        width: 50,
        margin: const EdgeInsets.all(2),
        child: TextButton(
          style: TextButton.styleFrom(
              primary: Colors.white, backgroundColor: Colors.green),
          child: const Icon(Icons.add_circle_outline),
          onPressed: () {
            addQtde(value);
          },
        ),
      ),
      const Spacer(),
    ]);
  }

  String _getValorByName(name) {
    switch (name) {
      case 'velocidade':
        return GameState.velocidade.toString();
      case 'gravidade':
        return GameState.gravidade.toString();
      case 'populacao':
        return GameState.populacao.toString();
      default:
        return "0";
    }
  }

  Widget _getButton(
    String label,
    VoidCallback onPressed, {
    bool includeTopMargin = true,
  }) {
    final button = ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
    if (includeTopMargin) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: button,
      );
    }
    return button;
  }

  Widget _getCheckBoxOption(text, value, setValue,
      {bool includeTopMargin = true}) {
    final checboxContainer = Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(width: 0.1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.blue,
            blurRadius: 1.0, // soften the shadow
            spreadRadius: 1.0, //extend the shadow
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: const TextStyle(color: Colors.black, fontSize: 20)),
          CheckBox(value: value, setValue: setValue).show(),
        ],
      ),
    );
    if (includeTopMargin) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: checboxContainer,
      );
    }
    return checboxContainer;
  }

  String _getTitle() {
    return "Dino Game IA";
  }

  setStateIfMounted(f) {
    if (mounted) setState(f);
  }
}
