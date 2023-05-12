import 'package:flutter/material.dart';

class DragQuestionFrame extends StatelessWidget {
  const DragQuestionFrame({super.key, required this.question, required this.questions, required this.dragElement});

  final String question;
  final List<String> questions;
  final List<bool> dragElement;

  @override
  Widget build(BuildContext context) {
    List<Widget> row = [];

    for(int i = 0; i < questions.length; i++){
      Widget yellowText = Text(" ${questions[i]} ", style: const TextStyle(fontSize: 40, color: Colors.yellow, decoration: TextDecoration.none));
      Widget hidedText = Text(" ${questions[i]} ", style: const TextStyle(fontSize: 40, color: Color(0xFF54436B)));
      if(!dragElement[i]){
        row.add(hidedText);
        continue;
      }

      row.add(
        Draggable<int>(
          data: i,
          feedback: yellowText,
          childWhenDragging: hidedText,
          child: yellowText
        )
      );
    }

    Widget dragWidget = Row(
      mainAxisAlignment: questions[0].length > 1 ? MainAxisAlignment.spaceEvenly: MainAxisAlignment.center,
      children: row
    );

    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 115 : 175,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Color(0xFF828DF4),
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Text(question, style: const TextStyle(fontSize: 20,color: Colors.black)),
          ),
          const SizedBox(height: 10),
          dragWidget,
        ]
      )
    );
  }
}