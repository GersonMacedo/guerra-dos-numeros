import 'dart:math';

import 'package:flutter/material.dart';

import '../levels.dart';

//TODO: toda a pagina de conquistas

class Achievements extends StatelessWidget {
  const Achievements({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Container(
        padding: const EdgeInsets.all(10),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Text("TODO: tela de conquistas")
          ],
        )
=======
    double width = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 960 : 540;
    double height = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 540 : 960;

    if(MediaQuery.of(context).size.width / width > MediaQuery.of(context).size.height / height){
      width = MediaQuery.of(context).size.width * height / MediaQuery.of(context).size.height;
    }else{
      height = MediaQuery.of(context).size.height * width / MediaQuery.of(context).size.width;
    }

    height -= 270;
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const SizedBox(
          height: 80,
          width: double.infinity,
          child: Text("Conquistas", style: TextStyle(fontSize: 30, color: Colors.white), textAlign: TextAlign.center),
        ),
        const SizedBox(height: 20),
        buildAchievements(width, height, x, y),
      ],
>>>>>>> b4878a0f941ad913c768ad05490f526adfeb1c64
    );
  }

  Widget buildAchievements(double width, double height, int x, int y){
    List<Widget> achievements = [];

    const double spaceBetween = 20;
    double size = min(width / x - spaceBetween, height / y - spaceBetween);
    List<Widget> collumn = [];

    for(int i = 1; i <= 27; i *= 3){
      Color color = Levels.next[0] > i ? Colors.green : Colors.white;
      achievements.add(
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 3)
          ),
          width: size,
          height: size,
          alignment: Alignment.center,
          child: Text(
            "Vença $i ${i == 1 ? 'fase' : 'fases'} de soma",
            style: const TextStyle(fontSize: 18, color: Colors.white),
            textAlign: TextAlign.center
          )
        )
      );
    }

    for(int i = 1; i <= 27; i *= 3){
      Color color = Levels.next[1] > i ? Colors.green : Colors.white;
      achievements.add(
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 3)
          ),
          width: size,
          height: size,
          alignment: Alignment.center,
          child: Text(
            "Vença $i ${i == 1 ? 'fase' : 'fases'} de multiplicação",
            style: const TextStyle(fontSize: 18, color: Colors.white),
            textAlign: TextAlign.center
          )
        )
      );
    }

    for(int i = 1; i <= 27; i *= 3){
      Color color = Levels.totalWithoutMistakes >= i ? Colors.green : Colors.white;
      achievements.add(
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: color, width: 3)
              ),
              width: size,
              height: size,
              alignment: Alignment.center,
              child: Text(
                  "Vença $i ${i == 1 ? 'fase' : 'fases'} sem errar nada",
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center
              )
          )
      );
    }

    for(int i = 0; i < y; i++){
      List<Widget> row = [];
      for(int j = 0; j < x; j++){
        int index = i * x + j;

        if(index >= achievements.length){
          row.add(
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3)
                ),
                width: size,
                height: size,
              )
          );
        }else{
          row.add(achievements[index]);
        }

        row.add(const SizedBox(width: spaceBetween, height: spaceBetween));
      }
      row.removeLast();
      collumn.add(Row(children: row, mainAxisAlignment: MainAxisAlignment.center,));
      collumn.add(const SizedBox(width: spaceBetween, height: spaceBetween));
    }

    return Column(children: collumn);
  }
}