import 'package:flutter/material.dart';

class TopGameFrame extends StatelessWidget {
  TopGameFrame({super.key, required this.changePage, required this.question, required this.numbers, required this.operation, required this.stage, required this.total}){
    List<String> questionPieces = [];
    if(question == ""){
      builtQuestion = "Quanto é ${numbers[0]} ${operation} ${numbers[1]} ?";
    }else{
      questionPieces = question.split("|");
      builtQuestion = "${questionPieces[0]}${numbers[0]}${questionPieces[1]}${numbers[1]}${questionPieces[2]}";
    }
  }

  final void Function(Widget?) changePage;
  final String question;
  List<int> numbers;
  final String operation;
  final int stage;
  final int total;
  late String builtQuestion;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          color: const Color(0xFF828DF4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildExitButton(),
              const SizedBox(height: 5),
              buildQuestion(),
            ]
          )
        ),
        buildProgressBar()
      ],
    );
  }

  Widget buildExitButton(){
    return Container(
      alignment: AlignmentDirectional.topStart,
      width: double.infinity,
      child: SizedBox(
        width: 30,
        height: 30,
        child: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: (){changePage(null);},
          child: const Icon(Icons.close, size: 15),
        )
      )
    );
  }

  Widget buildQuestion(){
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFF54436B),
        borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      child: Text(builtQuestion, style: const TextStyle(fontSize: 20, color: Colors.white))
    );
  }

  Widget buildProgressBar(){
    return SizedBox(
      height: 10,
      child: Row(
        children: [
          Expanded(
            flex: stage,
            child: Container(color: Colors.green)
          ),
          Expanded(
            flex: total - stage,
            child: Container(color: Colors.white)
          )
        ]
      )
    );
  }
}