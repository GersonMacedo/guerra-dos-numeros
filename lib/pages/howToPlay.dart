import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HowToPlay extends StatelessWidget {
  const HowToPlay({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      margin: const EdgeInsetsDirectional.all(10),
      decoration: const BoxDecoration(
          color: Color(0xFF828DF4),
          borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      child: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Como Jogar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "\nNo inicio do jogo você precisará ler a questão que aparece no topo da tela e responder corretamente qual operação precisa ser feito para resolver ela.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
                textAlign: TextAlign.justify,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(width: 5)
                ),
                child: Image.asset("assets/images/tutorial/0.jpeg"),
              ),
              const Text(
                "Depois de responder corretamente a operação você precisará tocar e arrastar os numeros para as posições corretas como mostrado na próxima image.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
                textAlign: TextAlign.justify,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(width: 5)
                ),
                child: Image.asset("assets/images/tutorial/1.jpeg"),
              ),
              const Text(
                "Na soma e multiplicação a ordem dos numeros não importam. Em seguida responda corretamente o cálculo.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
                textAlign: TextAlign.justify,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(width: 5)
                ),
                child: Image.asset("assets/images/tutorial/2.jpeg"),
              ),
              const Text(
                "Na sequencia mova o resultado da pergunta anterior para a posição correta, quando ele tem 2 digitos voce também precisa colocar o 'vai 1' no lugar correto.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
                textAlign: TextAlign.justify,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(width: 5)
                ),
                child: Image.asset("assets/images/tutorial/3.jpeg"),
              ),
              const Text(
                "Depois dissos os passos vão se repetir até que você termine todo o calculo.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
                textAlign: TextAlign.justify,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(width: 5)
                ),
                child: Image.asset("assets/images/tutorial/4.jpeg"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
