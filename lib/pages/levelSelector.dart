import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/pages/game.dart';
import 'package:guerra_dos_numeros/utils.dart';

class LevelSelector extends StatelessWidget {
  const LevelSelector({super.key, required this.changePage, required this.vertical});
  final void Function(Widget?) changePage;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    String selectedOperation = "Soma";
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            backButton(changePage),
            const SizedBox(height: 15),
            //TODO: Deixar o usuario escolher a questão e os numeros, colocar uma opção aleatório também
            const Text("Operação: Soma", style: TextStyle(fontSize: 22, color: Colors.black)),
            const SizedBox(height: 15),
            const Text("Numero 1: 13", style: TextStyle(fontSize: 22, color: Colors.black)),
            const SizedBox(height: 15),
            const Text("Numero 2: 78", style: TextStyle(fontSize: 22, color: Colors.black)),
            const SizedBox(height: 15),
            customIconButton(context, Colors.green, Icon(Icons.play_circle), " Jogar", 22, Colors.white, 120, 50,
                    (){changePage(Game(operation: "+", questionNumber: 0, number1: 13, number2: 78, changePage: changePage, vertical: vertical));}),
          ],
        )
    );
  }
}