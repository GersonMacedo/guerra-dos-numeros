import 'package:flutter/material.dart';

class TopGameFrame extends StatefulWidget {
  const TopGameFrame(this.state, this.question, this.numbers, this.initialState,this.totalStages, this.changePage, {super.key});

  final TopGameState state;
  final String question;
  final List<String> numbers;
  final int initialState;
  final int totalStages;
  final void Function(Widget?) changePage;

  @override
  State<TopGameFrame> createState() => state;
}

class TopGameState extends State<TopGameFrame>{
  @override
  void initState() {
    buildQuestion(widget.question, widget.numbers);
    initialState = widget.initialState;
    totalStages = widget.totalStages;

    super.initState();
  }

  late String builtQuestion;
  late int initialState;
  late int totalStages;
  int stage = 0;

  void buildQuestion(String question, List<String> numbers){
    List<String> questionPieces = question.split("|");
    builtQuestion = "${questionPieces[0]}${numbers[0]}${questionPieces[1]}${numbers[1]}${questionPieces[2]}";
  }

  void updateQuestion(String question, List<String> numbers, int initial, int total){
    buildQuestion(question, numbers);
    stage = 0;
    initialState = initial;
    totalStages = total;

    setState((){});
  }

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
              buildQuestionWidget(),
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

  Widget buildQuestionWidget(){
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFF54436B),
        borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      child: Text(
        builtQuestion,
        style: const TextStyle(fontSize: 28, color: Colors.white),
        textAlign: TextAlign.justify,
      )
    );
  }

  Widget buildProgressBar(){
    return SizedBox(
      height: 10,
      child: Row(
        children: [
          Expanded(
            flex: stage - initialState,
            child: Container(color: Colors.green)
          ),
          Expanded(
            flex: totalStages - stage - initialState,
            child: Container(color: Colors.white)
          )
        ]
      )
    );
  }
}