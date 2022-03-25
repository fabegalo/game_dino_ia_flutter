import 'dart:math';
import 'package:game_dino_ia/components/dino_component.dart';

class RedeNeural {
  late int distancia;
  late int velocidade;
  //8 genes -900 123 -090 -123 -1234 -1234 -3454 -0909
  late DinoComponent individuo;

  RedeNeural(dino) {
    individuo = dino;
  }

  void setDistancia(int distancia) {
    this.distancia = distancia;
  }

  void setVelocidade(int velocidade) {
    this.velocidade = velocidade;
  }

  bool redeNeural() {
    double finalSinapse = 0.0;

    List<double> arrSinapse = [];

    for (int i = 0; i < individuo.genes.length; i++) {
      arrSinapse.add(positron(i));
      i++;
    }

    //gambiarra
    for (int i = 0; i < arrSinapse.length; i++) {
      // print(arrSinapse[i]);
      // print(i);

      if (arrSinapse[i] >= 0.5) {
        finalSinapse++;
      }
    }

    if (finalSinapse >= 3) {
      return true;
    } else {
      return false;
    }
    //return finalSinapse >= 2 ?? true;
  }

  double positron(int i) {
    //bias
    //senoide 1/(1 + Math.exp(-x)) achata qqr numero e deixda ele entre 0 e 1
    double entrada1 = ((distancia * 1000) * individuo.genes[i]) / 1000000;
    double entrada2 = ((velocidade * 1000) * individuo.genes[++i]) / 1000000;
    double x = entrada1 + entrada2;
    return 1 / (1 + exp(-x));
  }
}
