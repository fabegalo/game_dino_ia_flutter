import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// By using the Flutter Widgets we can handle all non-game related UI through
/// widgets.
class MenuGame extends StatefulWidget {
  /// The reference to the game.
  const MenuGame({Key? key}) : super(key: key);

  @override
  _MenuGameState createState() => _MenuGameState();
}

class _MenuGameState extends State<MenuGame> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Menu"),
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
                    _getButton('Jogar',
                        () => {Navigator.popAndPushNamed(context, "/game")}),
                    _getButton('Configurações',
                        () => {Navigator.pushNamed(context, "/config")}),
                    _getButton('Sair do Jogo', () {
                      if (Platform.isAndroid) {
                        //SystemNavigator.pop();
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                      } else if (Platform.isIOS) {
                        exit(0);
                      }
                    }),
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

  String _getTitle() {
    return "Dino Game IA";
  }
}
