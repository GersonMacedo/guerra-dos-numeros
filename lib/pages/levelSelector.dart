import 'dart:math';
import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/pages/game.dart';
import 'package:guerra_dos_numeros/utils.dart';

class LevelSelector extends StatefulWidget {
  const LevelSelector({super.key, required this.changePage, required this.vertical});
  final void Function(Widget?) changePage;
  final bool vertical;

  @override
  State<LevelSelector> createState() => _LevelSelectorState();
}

class _LevelSelectorState extends State<LevelSelector>{
  String operator = "+";
  int digits = 2;
  int number1 = -1;
  int number2 = -1;
  Color disabled = const Color(0xFF101010);

  int getRandomNumber(){
    Random random = Random();
    return pow(10, digits - 1).toInt() + random.nextInt(pow(10, digits).toInt() - pow(10, digits - 1).toInt() - 1);
  }

  @override
  Widget build(BuildContext context){
    Random random = Random();
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            backButton(widget.changePage),
            const SizedBox(height: 15),
            buildOperators(),
            const SizedBox(height: 15),
            buildDigits(),
            const SizedBox(height: 15),
            const Text("Numero 1: Aleatório", style: TextStyle(fontSize: 22, color: Colors.black)),
            const SizedBox(height: 15),
            const Text("Numero 2: Aleatório", style: TextStyle(fontSize: 22, color: Colors.black)),
            const SizedBox(height: 15),
            customIconButton(context, operator == "+" ? Colors.green : disabled, const Icon(Icons.play_circle), " Jogar", 22, Colors.white, 120, 50,(){
              if(operator == "+"){
                widget.changePage(Game(operation: operator, questionNumber: 0, number1: number1 == -1 ? getRandomNumber() : number1, number2: number2 == -1 ? getRandomNumber() : number2, changePage: widget.changePage, vertical: widget.vertical));
              }
            }),
          ],
        )
    );
  }

  Widget buildOperators(){
    List<String> operators = ["+", "-", "x", "/"];
    List<Widget> row = [
      const Text("Operação:", style: TextStyle(color: Colors.black))
    ];

    for(int i = 0; i < operators.length; i++){
      row.add(const SizedBox(width: 15));
      row.add(
        SizedBox(
          width: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: operator == operators[i] ? Colors.green : const Color(0xFF828DF4),
            ),
            onPressed: (){
              setState(() {
                operator = operators[i];
              });
            },
            child: Text(operators[i]),
          ),
        )
      );
    }

    return Row(
      children: row
    );
  }

  Widget buildDigits(){
    return Row(
      children: [
        const Text("Digitos:", style: TextStyle(color: Colors.black)),
        const SizedBox(width: 15),
        SizedBox(
          width: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: digits == 2 ? disabled : const Color(0xFF828DF4),
            ),
            onPressed: (){
              setState(() {
                digits = max(2, digits - 1);
              });
            },
            child: const Text("<"),
          ),
        ),
        const SizedBox(width: 15),
        Text("$digits", style: const TextStyle(color: Colors.black)),
        const SizedBox(width: 15),
        SizedBox(
          width: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: digits == 9 ? disabled : const Color(0xFF828DF4),
            ),
            onPressed: (){
              setState(() {
                digits = min(9, digits + 1);
              });
            },
            child: const Text(">"),
          ),
        ),
      ],
    );
  }
}