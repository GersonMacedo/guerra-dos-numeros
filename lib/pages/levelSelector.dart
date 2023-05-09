import 'dart:math';
import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/pages/game.dart';
import 'package:guerra_dos_numeros/utils.dart';

//TODO: Adicionar mais questões
//TODO: Pegar as questões de um arquivo separado
//0: adição
//1: subtração
//2: multiplicação
//3: divisão
List<List<String>> questionsMatrix = [
  [
    "Mariazinha tinha | reais guardado, no seu aniversário ela ganhou mais | reais do seu pai. Quantos reais ela tem hoje?",
    "Joãozinho tinha | maçãs e acabou de pegar | da macieira do seu vizinho, quantas maçãs ele tem agora?"
  ],
  [],
  [],
  []
];

class LevelSelector extends StatefulWidget {
  const LevelSelector({super.key, required this.changePage});
  final void Function(Widget?) changePage;

  @override
  State<LevelSelector> createState() => _LevelSelectorState();
}

class _LevelSelectorState extends State<LevelSelector>{
  int operator = 0;
  bool interpretation = true;
  int digits = 2;
  int number1 = -1;
  int number2 = -1;
  Color disabled = const Color(0xFF101010);

  int getRandomNumber(){
    Random random = Random();
    return pow(10, digits - 1).toInt() + random.nextInt(pow(10, digits).toInt() - pow(10, digits - 1).toInt() - 1);
  }

  List<int> getNumberList(int size){
    List<int> list = [];
    for(int i = 0; i < size; i++){
      list.add(getRandomNumber());
    }
    return list;
  }

  String getQuestion(){
    if(!interpretation || questionsMatrix[operator].isEmpty){
      return "";
    }

    Random random = Random();
    int questionNumber = random.nextInt(questionsMatrix[operator].length).toInt();
    return questionsMatrix[operator][questionNumber];
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
            buildInterpretation(),
            const SizedBox(height: 15),
            buildOperators(),
            const SizedBox(height: 15),
            buildDigits(),
            const SizedBox(height: 15),
            const Text("Numero 1: Aleatório", style: TextStyle(fontSize: 22, color: Colors.black)),
            const SizedBox(height: 15),
            const Text("Numero 2: Aleatório", style: TextStyle(fontSize: 22, color: Colors.black)),
            const SizedBox(height: 15),
            customIconButton(context, operator == 0 ? Colors.green : disabled, const Icon(Icons.play_circle), " Jogar", 22, Colors.white, 120, 50,(){
              if(operator == 0){
                widget.changePage(Game(operation: operator, questionNumber: 0, question: getQuestion(),numbers: getNumberList(2), changePage: widget.changePage));
              }
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
        const Text("Interpretação: ", style: TextStyle(color: Colors.black)),
        Material(
          color: const Color(0xFF54436B),
          child: Checkbox(
              value: interpretation,
              fillColor: MaterialStateColor.resolveWith(getColor),
              onChanged: (newValue){
                setState(() {
                  interpretation = newValue!;
                });
              }
          )
        )
      ],
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
              backgroundColor: operator == i ? Colors.green : const Color(0xFF828DF4),
            ),
            onPressed: (){
              setState(() {
                operator = i;
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