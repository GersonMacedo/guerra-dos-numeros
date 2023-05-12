import 'package:flutter/material.dart';

class NumbersGridFrame extends StatelessWidget {
  NumbersGridFrame({super.key, required this.grid, required this.acceptDrag, required this.successDrag, required this.stage, required this.total}){
    maxSize = grid[0].length;
    gridWidget = [];
    List<Widget> lineWidget = [];

    for(int j = 0; j < grid[0].length; j++){
      Widget container = Container(
          height: 10,
          width: 5,
          color: getColor(0, j),
          child: Text(grid[0][j], style: TextStyle(fontSize: 10, color: stage % 2 == 0 && stage != total && maxSize - j - 1 == (stage ~/ 2 - 1) ? Colors.blue : Colors.black))
      );

      lineWidget.add(DragTarget<int>(
        builder: (context, data, rejectedData){
          return container;
        },
        onAccept: (data){
          if((acceptDrag[0][j] & (1 << data)) != 0){
            successDrag(0, j, data);
          }
        },
      ));

      if(j != grid[0].length){
        lineWidget.add(const SizedBox(height: 10, width: 5));
      }
    }

    gridWidget.add(Row(mainAxisAlignment: MainAxisAlignment.start, children: lineWidget));

    for(int i = 1; i < 4; i++){
      lineWidget = [];
      for(int j = 0; j < maxSize; j++){
        Widget container = Container(
            height: 20,
            width: 10,
            color: getColor(i, j),
            child: Text(grid[i][j], style: TextStyle(fontSize: 16, color: stage % 2 == 0 && stage != total && maxSize - j - 1 == (stage ~/ 2 - 1) ? Colors.blue : Colors.black))
        );

        lineWidget.add(DragTarget<int>(
          builder: (context, data, rejectedData){
            return container;
          },
          onAccept: (data){
            if((acceptDrag[i][j] & (1 << data)) != 0) {
              successDrag(i, j, data);
            }
          },
        ));
      }

      gridWidget.add(Row(mainAxisAlignment: MainAxisAlignment.start, children: lineWidget));

      if(i == 2){
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
  }

  final List<List<String>> grid;
  final List<List<int>> acceptDrag;
  final void Function(int, int, int) successDrag;
  final int stage;
  final int total;
  late int maxSize;
  late List<Widget> gridWidget;

  Color getColor(int i, int j){
    if(j == 0 && i != 3){
      return const Color(0xFF54436B);
    }

    if(i % 2 == j % 2){
      return const Color(0xFF54436B + 0x00060606);
    }

    return const Color(0xFF54436B - 0x00060606);
  }

  void updateGrid(){
  }

  @override
  Widget build(BuildContext context) {
    if(stage == 0){
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