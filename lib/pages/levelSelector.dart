import 'dart:math';
import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/levels.dart';
import 'package:guerra_dos_numeros/pages/game/game.dart';

class LevelSelector extends StatefulWidget {
  const LevelSelector(this.changePage, {super.key});
  final void Function(Widget?, {bool bottom, bool back, bool keep}) changePage;

  @override
  State<LevelSelector> createState() => _LevelSelectorState();
}

class _LevelSelectorState extends State<LevelSelector>{
  final List<String> title = ["Adição", "Multiplicação"];
  final List<String> type = ["+", "x"];
  int mode = Levels.type;
  int last = Levels.getTotalLevels();
  late int lastPage = last - ((last - 1) % 12);
  late int next = Levels.next[mode];

  void update(int v){
    setState(() {
      Levels.page[mode] = min(max(1, Levels.page[mode] + v * 12), lastPage);
    });
  }

  @override
<<<<<<< HEAD
  Widget build(BuildContext context){
    bool vertical = MediaQuery.of(context).size.height > MediaQuery.of(context).size.width;
    List<Widget> column = [];
    for(int i = 0; i < (vertical ? 4 : 2); i++){
      List<Widget> row = [];
      for(int j = 0; j < (vertical ? 3 : 6); j++){
        int actual = (vertical ? 3 : 6) * i + j + first;
        if(actual > last){
          row.add(
            const SizedBox(
              width: 90,
              height: 90
            )
          );
          continue;
        }
=======
  Widget build(BuildContext context){double width = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 960 : 540;
    double height = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 540 : 960;
>>>>>>> b4878a0f941ad913c768ad05490f526adfeb1c64

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
          const SizedBox(height: 20),
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
                  Expanded(child: Text(title[mode], style: const TextStyle(fontSize: 30, color: Colors.black), textAlign: TextAlign.center))
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
                  backgroundColor: Color(Levels.page[mode] != 1 ? 0xff828DF4 : 0x44ffffff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                ),
                onPressed: () => update(-1),
                child: Container(
                  height: 50,
                  width: 100,
                  alignment: Alignment.center,
                  child: const Text("<", style: TextStyle(fontSize: 40))
                )
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(Levels.page[mode] != lastPage ? 0xff828DF4 : 0x44ffffff),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                      )
                  ),
                  onPressed: () => update(1),
                  child: Container(
                      height: 50,
                      width: 100,
                      alignment: Alignment.center,
                      child: const Text(">", style: TextStyle(fontSize: 40))
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
        int actual = i * x + j + Levels.page[mode];
        if(actual > last){
          row.add(
              Container(
                  width: size,
                  height: size
              )
          );
          row.add(const SizedBox(width: spaceBetween));
          continue;
        }

        Color color = Color(actual < next ? 0xff50CB93 : (actual == next ? 0xff212A3E : 0x44ffffff));
        Widget container = Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
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

        if(Levels.levelsWithoutMistakes[mode][actual - 1]){
          color = Colors.yellow;
        }
        row.add(
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: color, width: 5)
              )
            ),
            onPressed: (){
              Levels.actual = actual - 1;
              widget.changePage(
                Game(widget.changePage, Levels.getLevel()),
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