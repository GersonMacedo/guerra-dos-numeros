import 'package:flutter/material.dart';

class NumbersGridFrame extends StatefulWidget {
  const NumbersGridFrame(this.state, this.successDrag, this.totalStages, {super.key});

  final NumbersGridState state;
  final void Function(int, int, int) successDrag;
  final int totalStages;

  @override
  State<NumbersGridFrame> createState() => state;
}

class NumbersGridState extends State<NumbersGridFrame>{
  List<Widget> gridWidget = [];
  late List<List<String>> grid;
  late List<List<int>> acceptDrag;

  Color getColor(int i, int j){
    if(j == 0 && i != 3){
      return const Color(0xFF54436B);
    }

    if(i % 2 == j % 2){
      return const Color(0xFF54436B + 0x00060606);
    }

    return const Color(0xFF54436B - 0x00060606);
  }

  void clearDrag(){
    for(int i = 0; i < acceptDrag.length; i++){
      for(int j = 0; j < acceptDrag[i].length; j++){
        acceptDrag[i][j] = 0;
      }
    }
  }

  void updateGrid(int stage){
    gridWidget = [];
    int maxSize = grid[0].length;
    List<Widget> lineWidget = [];

    for (int j = 0; j < grid[0].length; j++) {
      Widget container = Container(
        height: 10,
        width: 5,
        color: getColor(0, j),
        child: Text(
          grid[0][j],
          style: TextStyle(
            fontSize: 10,
            color: stage % 2 == 0 && stage != widget.totalStages && maxSize - j - 1 == (stage ~/ 2 - 1) ? Colors.blue : Colors.black
          )
        )
      );

      lineWidget.add(DragTarget<int>(
        builder: (context, data, rejectedData) {
          return container;
        },
        onAccept: (data) {
          if ((acceptDrag[0][j] & (1 << data)) != 0) {
            widget.successDrag(0, j, data);
          }
        },
      ));

      if (j != grid[0].length) {
        lineWidget.add(const SizedBox(height: 10, width: 5));
      }
    }

    gridWidget.add(Row(mainAxisAlignment: MainAxisAlignment.start, children: lineWidget));

    for (int i = 1; i < 4; i++) {
      lineWidget = [];
      for (int j = 0; j < maxSize; j++) {
        Widget container = Container(
          height: 20,
          width: 10,
          color: getColor(i, j),
          child: Text(
            grid[i][j],
            style: TextStyle(
              fontSize: 16,
              color: stage % 2 == 0 && stage != widget.totalStages && maxSize - j - 1 == (stage ~/ 2 - 1) ? Colors.blue : Colors.black
            )
          )
        );

        lineWidget.add(DragTarget<int>(
          builder: (context, data, rejectedData) {
            return container;
          },
          onAccept: (data) {
            if ((acceptDrag[i][j] & (1 << data)) != 0) {
              widget.successDrag(i, j, data);
            }
          },
        ));
      }

      gridWidget.add(Row(mainAxisAlignment: MainAxisAlignment.start, children: lineWidget));

      if (i == 2) {
        gridWidget.add(
          SizedBox(
            width: 10.0 * maxSize,
            child: const Divider(
              height: 5,
              color: Colors.black
            )
          )
        );
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context){
    if(gridWidget.isEmpty){
      return Expanded(child: Container());
    }

    return Expanded(
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: gridWidget
        ),
      )
    );
  }
}