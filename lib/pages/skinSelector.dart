import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/imagesLoader.dart';
import 'package:guerra_dos_numeros/levels.dart';

class SkinSelector extends StatefulWidget {
  const SkinSelector({super.key});

  @override
  State<SkinSelector> createState() => _SkinSelector();
}

class _SkinSelector extends State<SkinSelector> {
  _SkinSelector();
  ImagesLoader images = ImagesLoader(false, false, false, true);

  @override
  void didChangeDependencies(){
    images.cacheImages(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ImagesLoader images = ImagesLoader(false, false, false, true);
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
          child: Text("Escolha seu personagem", style: TextStyle(fontSize: 30, color: Colors.white), textAlign: TextAlign.center),
        ),
        const SizedBox(height: 20),
        buildSkins(width, height, x, y),
      ],
    );
  }

  Widget buildSkins(double width, double height, int x, int y){
    const double spaceBetween = 20;
    double size = min(width / x - spaceBetween, height / y - spaceBetween);
    List<Widget> collumn = [];
    for(int i = 0; i < y; i++){
      List<Widget> row = [];
      for(int j = 0; j < x; j++){
        int index = i * x + j;

        if(index >= images.hamburgerSkins){
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
          row.add(const SizedBox(width: spaceBetween, height: spaceBetween));
          continue;
        }

        if(index * 5 > Levels.next[0] + Levels.next[1] - 2){
          row.add(
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3)
              ),
              width: size,
              height: size,
              child: Stack(
                children: [
                  images.storeHamburger[index],
                  Flex(
                    direction: Axis.vertical,
                    children: [
                      Expanded(
                      child: FittedBox(
                          child: Container(
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                            color: Color(0xf054436B),
                            child: Text(
                              "Complete ${index * 5} fases para desbloquear",
                              style: const TextStyle(fontSize: 12, color: Colors.white),
                              textAlign: TextAlign.center
                            )
                          )
                        ),
                      ),
                    ]
                  )
                ],
              ),
            )
          );
          row.add(const SizedBox(width: spaceBetween, height: spaceBetween));
          continue;
        }

        Color color = index == Levels.hamburgerType ? Colors.green : Colors.white;
        row.add(
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: color, width: 3)
            ),
            width: size,
            height: size,
            child: GestureDetector(
              onTap: () {
                Levels.changeHamburgerType(index);
                setState(() {});
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: images.storeHamburger[index],
              ),
            )
          )
        );
        row.add(const SizedBox(width: spaceBetween, height: spaceBetween));
      }
      row.removeLast();
      collumn.add(Row(children: row, mainAxisAlignment: MainAxisAlignment.center,));
      collumn.add(const SizedBox(width: spaceBetween, height: spaceBetween));
    }

    return Column(children: collumn);
  }
}
