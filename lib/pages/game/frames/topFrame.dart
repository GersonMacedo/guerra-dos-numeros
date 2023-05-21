import 'package:flutter/material.dart';

class TopGameFrame extends StatefulWidget {
  const TopGameFrame(this.state, this.question, this.numbers, this.initialState,this.totalStages, this.changePage, {super.key});

  final TopGameState state;
  final String question;
  final List<int> numbers;
  final int initialState;
  final int totalStages;
  final void Function(Widget?) changePage;

  @override
  State<TopGameFrame> createState() => state;
}

class TopGameState extends State<TopGameFrame>{
  @override
  void initState() {
    List<String> questionPieces = widget.question.split("|");
    builtQuestion = "${questionPieces[0]}${widget.numbers[0]}${questionPieces[1]}${widget.numbers[1]}${questionPieces[2]}";

    super.initState();
  }

  late String builtQuestion;
  int stage = 0;

  void updateStage(int newStage){
    setState(() {
      stage = newStage;
    });
  }

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
          onPressed: (){widget.changePage(null);},
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
            flex: stage - widget.initialState,
            child: Container(color: Colors.green)
          ),
          Expanded(
            flex: widget.totalStages - stage - widget.initialState,
            child: Container(color: Colors.white)
          )
        ]
      )
    );
  }
}