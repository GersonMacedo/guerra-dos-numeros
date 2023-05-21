import 'dart:math';

import 'package:flutter/material.dart';

class NumbersGridFrame extends StatefulWidget {
  const NumbersGridFrame(this.state, this.successDrag, this.operation, this.x, this.y, this.r, this.maxSize, {super.key});

  final NumbersGridState state;
  final void Function(int, int, int) successDrag;
  final String operation;
  final int x;
  final int y;
  final int r;
  final int maxSize;

  @override
  State<NumbersGridFrame> createState() => state;
}

class NumbersGridState extends State<NumbersGridFrame>{
  List<Widget> gridWidget = [];
  late List<List<String>> grid;
  late List<List<int>> acceptDrag;
  List<List<bool>> highlight = [];
  late String operation;
  late int x;
  late int y;
  late int r;
  late int initialR;
  List<bool> addLine = [];
  List<bool> carryLine = [];
  late int maxSize;

  @override
  initState(){
    operation = widget.operation;
    x = widget.x;
    y = widget.y;
    r = widget.r;
    initialR = r;
    for(int i = 0; i <= r; i++){
      addLine.add(i + 1 == r);
      carryLine.add(i == 0);
    }
    maxSize = widget.maxSize;

    super.initState();
  }

  Color getColor(int i, int j){
    if(i % 2 == (grid[i].length - j) % 2){
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

  void updateOperation(String newOperation, int newX, int newY, int newR, int newMaxSize){
    operation = newOperation;
    x = newX;
    y = newY;

    grid.add([]);
    acceptDrag.add([]);
    for(int i = initialR; i < newR; i++){
      while(grid[i].length <= newMaxSize){
        grid[i].insert(0, "");
        acceptDrag[i].add(0);
      }
    }

    List<String> newCarryLine = [];
    List<int> newAcceptDrag = [];
    for(int i = 0; i <= newMaxSize; i++){
      newCarryLine.add("");
      newAcceptDrag.add(0);
    }
    grid.insert(initialR, newCarryLine);
    acceptDrag.insert(initialR, newAcceptDrag);
    carryLine[initialR] = true;


    addLine.add(true);
    addLine.add(false);
    carryLine.add(false);
    carryLine.add(false);

    r = newR;
    initialR = r;
    maxSize = newMaxSize;
    grid[r-1][0] = operation;
  }

  void updateHighlight(int stage, int step, int iteration, String operation){
    highlight.clear();
    for(int i = 0; i < grid.length; i++){
      List<bool> line = [];
      for(int j = 0; j < grid[i].length; j++){
        if(step != 0){
          line.add(false);
          continue;
        }

        if(operation == "+"){
          line.add(i >= x && i < r && j == y + maxSize - stage + 1);
        }else if(operation == "x") {
          line.add(((i == x || i == x + 1) && j == y + maxSize - iteration) || (i == x + 2 && j == y + maxSize - stage + 1));
        }else{
          line.add(false);
        }
      }

      highlight.add(line);
    }
  }

  void updateGrid(int stage, int step, int iteration, String operation){
    gridWidget = [];
    List<Widget> lineWidget = [];
    updateHighlight(stage, step, iteration, operation);

    for (int i = 0; i < grid.length; i++) {
      lineWidget = [];
      for (int j = 0; j < grid[i].length; j++) {
        Widget container = Container(
          height: carryLine[i] ? 10 : 20,
          width: carryLine[i] ? 5 : 10,
          color: getColor(i, j),
          child: Text(
            grid[i][j],
            style: TextStyle(
              fontSize: carryLine[i] ? 9 : 16,
              color: highlight[i][j] ? Colors.blue : Colors.black
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

        if(carryLine[i]){
          lineWidget.add(const SizedBox(height: 10, width: 5));
        }
      }

      gridWidget.add(Row(mainAxisAlignment: MainAxisAlignment.start, children: lineWidget));

      if(addLine[i]){
        gridWidget.add(
          SizedBox(
            width: 10.0 * grid[i].length,
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
    if(highlight.isEmpty){
      return Expanded(child: Container());
    }

    return Expanded(
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: gridWidget
        ),
      )
    );
  }
}