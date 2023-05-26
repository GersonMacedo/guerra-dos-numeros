import 'dart:math';
import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/pages/game/game.dart';

class LevelSelector extends StatefulWidget {
  const LevelSelector(this.changePage, this.mode, {super.key});
  final void Function(Widget?, {bool bottom, bool back, bool keep}) changePage;
  final int mode;

  @override
  State<LevelSelector> createState() => _LevelSelectorState();
}

class _LevelSelectorState extends State<LevelSelector>{
  final List<String> title = ["      adição e subtração", "      multiplicação e divisão"];
  int first = 1;

  void update(int v){
    setState(() {
      first = min(max(1, first + v * 12), 85);
    });
  }

  @override
  Widget build(BuildContext context){
    bool vertical = MediaQuery.of(context).size.height > MediaQuery.of(context).size.width;
    List<Widget> column = [];
    for(int i = 0; i < (vertical ? 4 : 2); i++){
      List<Widget> row = [];
      for(int j = 0; j < (vertical ? 3 : 6); j++){
        row.add(
          Container(
            decoration: const BoxDecoration(
              color: Color(0xff212A3E),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            width: 90,
            height: 90,
            alignment: Alignment.center,
            child: Text("${(vertical ? 3 : 6) * i + j + first}", style: TextStyle(color: Colors.white, fontSize: 40),),
          )
        );
      }

      column.add(Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: row));
    }
    Widget levels = Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: column);

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Container(
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
                          color: Color(0xFF212A3E),
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      width: 50,
                      height: 50
                  ),
                  Text(title[widget.mode], style: const TextStyle(fontSize: 30, color: Colors.black))
                ],
              )
          ),
          const SizedBox(height: 20),
          Expanded(child: levels),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff828DF4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                ),
                onPressed: () => update(-1),
                child: Container(
                  height: 50,
                  width: 100,
                  alignment: Alignment.center,
                  child: Text("<", style: TextStyle(fontSize: 40))
                )
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff828DF4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                      )
                  ),
                  onPressed: () => update(1),
                  child: Container(
                      height: 50,
                      width: 100,
                      alignment: Alignment.center,
                      child: Text(">", style: TextStyle(fontSize: 40))
                  )
              )
            ],
          )
        ],
      )
    );
  }
}