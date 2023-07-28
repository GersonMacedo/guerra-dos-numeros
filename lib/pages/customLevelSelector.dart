import 'dart:math';
import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/levels.dart';
import 'package:guerra_dos_numeros/pages/game/game.dart';
import 'package:guerra_dos_numeros/utils.dart';

//TODO: Adicionar mais questões
//TODO: Pegar as questões de um arquivo separado
//TODO: Quando interpretação estiver ativo, deixar escolher uma ou mais operações para um sorteio
//TODO: Melhorar o visual da tela
//TODO: Aba "personalizado" para escolher numeros e até uma expressão numérica
//0: adição
//1: subtração
//2: multiplicação
//3: divisão

class CustomLevelSelector extends StatefulWidget {
  const CustomLevelSelector(this.changePage, {super.key});
  final void Function(Widget?, {bool bottom, bool back, bool keep}) changePage;

  @override
  State<CustomLevelSelector> createState() => _CustomLevelSelectorState();
}

class _CustomLevelSelectorState extends State<CustomLevelSelector>{
  Color disabled = const Color(0xFF101010);

  @override
  Widget build(BuildContext context){
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Container(
            alignment: Alignment.center,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              width: 450,
              height: 70,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff212A3E),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    alignment: Alignment.center,
                    width: 50,
                    height: 50,
                    child: Text("?", style: const TextStyle(fontSize: 30, color: Colors.white))
                  ),
                  const Expanded(child: Text("Aleatório", style: const TextStyle(fontSize: 30, color: Colors.black), textAlign: TextAlign.center))
                ],
              )
            )
          ),
          const SizedBox(height: 25),
          buildOperators(),
          const SizedBox(height: 10),
          buildDigits(),
          const SizedBox(height: 10),
          buildTime(),
          const SizedBox(height: 10),
          customIconButton(context, Colors.green, const Icon(Icons.play_circle), " Jogar", 22, Colors.white, 120, 50,(){
            widget.changePage(
              Game(widget.changePage, Levels.getLevel()),
              back: false,
              bottom: false,
              keep: true
            );
          }),
        ],
      )
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.green;
    }
    return const Color(0xFF828DF4);
  }

  Widget buildInterpretation(){
    return Row(
      children: [
        const Text("Interpretação: ", style: TextStyle(color: Colors.white, fontSize: 30)),
        Material(
          color: const Color(0xFF54436B),
          child: Checkbox(
              value: Levels.interpretation,
              fillColor: MaterialStateColor.resolveWith(getColor),
              onChanged: (newValue){
                setState(() {
                  Levels.interpretation = newValue!;
                });
              }
          )
        )
      ],
    );
  }

  Widget buildOperators(){
    List<Widget> row = [
      Container(
        width: 150,
        child: const Text("Operação:", style: TextStyle(color: Colors.white, fontSize: 30)),
      )
    ];

    for(int i = 0; i < Levels.operators.length; i++){
      row.add(const SizedBox(width: 15));
      row.add(
        SizedBox(
          width: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Levels.operator == i ? Colors.green : (i == 0 || i == 2 ? const Color(0xFF828DF4) : Colors.black),
            ),
            onPressed: (){
              setState(() {
                if(i == 0 || i == 2){
                  Levels.operator = i;
                }
              });
            },
            child: Text(Levels.operators[i]),
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
        Container(
          width: 150,
          child: const Text("Digitos:", style: TextStyle(color: Colors.white, fontSize: 30)),
        ),
        const SizedBox(width: 15),
        SizedBox(
          width: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Levels.digits == 2 ? disabled : const Color(0xFF828DF4),
            ),
            onPressed: (){
              setState(() {
                Levels.digits = max(2, Levels.digits - 1);
              });
            },
            child: const Text("<"),
          ),
        ),
        const SizedBox(width: 15),
        Text("${Levels.digits}", style: const TextStyle(color: Colors.black, fontSize: 30)),
        const SizedBox(width: 15),
        SizedBox(
          width: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Levels.digits == 9 ? disabled : const Color(0xFF828DF4),
            ),
            onPressed: (){
              setState(() {
                Levels.digits = min(9, Levels.digits + 1);
              });
            },
            child: const Text(">"),
          ),
        ),
      ],
    );
  }


  Widget buildTime(){
    List<String> options = ["Fácil", "Médio", "Difícil", "Extremo"];
    List<Widget> row = [
      Container(
        width: 150,
        child: const Text("Tempo:", style: TextStyle(color: Colors.white, fontSize: 30)),
      )
    ];

    for(int i = 0; i < options.length; i++){
      row.add(const SizedBox(width: 15));
      row.add(
          SizedBox(
            width: 70,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Levels.time == i ? Colors.green : const Color(0xFF828DF4),
                padding: const EdgeInsets.all(0)
              ),
              onPressed: (){
                setState(() {
                  Levels.time = i;
                });
              },
              child: Text(options[i], style: const TextStyle(fontSize: 15)),
            ),
          )
      );
    }

    return Row(
        children: row
    );
  }
}