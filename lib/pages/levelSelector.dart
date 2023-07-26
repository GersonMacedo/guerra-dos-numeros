import 'dart:math';
import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/levels.dart';
import 'package:guerra_dos_numeros/pages/game/game.dart';

class LevelSelector extends StatefulWidget {
  const LevelSelector(this.changePage, this.skinNumber, {super.key});
  final void Function(Widget?, {bool bottom, bool back, bool keep}) changePage;
  final int skinNumber;

  @override
  State<LevelSelector> createState() => _LevelSelectorState();
}

class _LevelSelectorState extends State<LevelSelector>{
  final List<String> title = ["      adição e subtração", "      multiplicação e divisão"];
  final List<String> type = ["+", "x"];
  int mode = Levels.type;
  int first = 1;
  int last = Levels.getTotalLevels();
  late int lastPage = last - ((last - 1) % 12);
  late int next = Levels.next[mode];

  void update(int v){
    setState(() {
      first = min(max(1, first + v * 12), lastPage);
    });
  }

  @override
  Widget build(BuildContext context){double width = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 960 : 540;
    double height = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 540 : 960;

    if(MediaQuery.of(context).size.width / width > MediaQuery.of(context).size.height / height){
      width = MediaQuery.of(context).size.width * height / MediaQuery.of(context).size.height;
    }else{
      height = MediaQuery.of(context).size.height * width / MediaQuery.of(context).size.width;
    }

    height -= 360;
    double aspectRatio = width / height;

    int x, y;
    if(aspectRatio < 0.55){
      x = 2;
      y = 6;
    }else if(aspectRatio < 1.0){
      x = 3;
      y = 4;
    }else if(aspectRatio < 1.8){
      x = 4;
      y = 3;
    }else{
      x = 6;
      y = 2;
    }

    Widget levels = buildLevels(width, height, x, y);

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
                        color: Color(0xff212A3E),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    alignment: Alignment.center,
                    width: 50,
                    height: 50,
                    child: Text(type[mode], style: const TextStyle(fontSize: 30, color: Colors.white))
                  ),
                  Text(title[mode], style: const TextStyle(fontSize: 30, color: Colors.black))
                ],
              )
          ),
          const SizedBox(height: 20),
          Expanded(child: levels),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(first != 1 ? 0xff828DF4 : 0x44ffffff),
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
                      backgroundColor: Color(first != lastPage ? 0xff828DF4 : 0x44ffffff),
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

  Widget buildLevels(double width, double height, int x, int y){
    const double spaceBetween = 20;
    double size = min(width / x - spaceBetween, height / y - spaceBetween);
    List<Widget> collumn = [];

    for(int i = 0; i < y; i++){
      List<Widget> row = [];
      for(int j = 0; j < x; j++){
        int actual = i * x + j + first;
        if(actual > last){
          row.add(
              Container(
                  width: size,
                  height: size
              )
          );
          continue;
        }

        Widget container = Container(
          decoration: BoxDecoration(
            color: Color(actual < next ? 0xff50CB93 : (actual == next ? 0xff212A3E : 0x44ffffff)),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          width: size,
          height: size,
          alignment: Alignment.center,
          child: Text("$actual", style: const TextStyle(color: Colors.white, fontSize: 40)),
        );

        if(actual > next){
          row.add(container);
          row.add(const SizedBox(width: spaceBetween));
          continue;
        }

        row.add(
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
              )
            ),
            onPressed: (){
              Levels.actual = actual - 1;
              widget.changePage(
                Game(widget.changePage, Levels.getLevel(), widget.skinNumber),
                back: false,
                bottom: false,
                keep: true
              );
            },
            child: container
          )
        );
        row.add(const SizedBox(width: spaceBetween));
      }
      row.removeLast();
      collumn.add(Row(children: row, mainAxisAlignment: MainAxisAlignment.center,));
      collumn.add(const SizedBox(width: spaceBetween, height: spaceBetween));
    }

    collumn.removeLast();
    return Column(children: collumn);
  }
}