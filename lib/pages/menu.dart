import 'dart:async';
import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/imagesLoader.dart';
import 'package:guerra_dos_numeros/pages/modeSelector.dart';

class Menu extends StatefulWidget {
  const Menu(this.changePage, {super.key});

  final void Function(Widget?, {bool bottom, bool back, bool keep}) changePage;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu>{

  _MenuState(){
    _timer = Timer.periodic(
        Duration(microseconds: 1000000 ~/ fps), (timer) {
      setState(() {
        frame++;
      });
    });
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  void didChangeDependencies(){
    images.cacheImages(context);

    super.didChangeDependencies();
  }

  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }

  late Timer _timer;
  int frame = 0;
  int fps = 10;
  ImagesLoader images = ImagesLoader(true, false);

  @override
  Widget build(BuildContext context){
    double width = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 960 : 540;
    double height = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 540 : 960;

    if(MediaQuery.of(context).size.width / width > MediaQuery.of(context).size.height / height){
      width = MediaQuery.of(context).size.width * height / MediaQuery.of(context).size.height;
    }

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              "Guerra dos números, Robôs e coisas matemáticas",
              style: TextStyle(fontSize: 40, color: Colors.white),
              textAlign: TextAlign.center,
            )
          ),
          Container(
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
                border: Border.symmetric(horizontal: BorderSide(color: Colors.white))
            ),
            child: Stack(
              children: [
                Positioned.fill(child: images.clouds[frame % 16]),
                Positioned(
                    left: width / 2 - 150,
                    top: 20,
                    width: 200,
                    height: 200,
                    child: images.hamburger[frame % 8  < 5 ? frame % 8 : 0]
                ),
                Positioned(
                    right: width / 2 - 150,
                    top: 20,
                    width: 200,
                    height: 200,
                    child: images.robot[frame % 8  > 2 ? frame % 8 - 3 : 0]
                )
              ],
            )
          ),
          ElevatedButton(
            onPressed: (){widget.changePage(ModeSelector(widget.changePage), keep: true);},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff50CB93),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
            child: Container(
              width: 300,
              height: 50,
              alignment: Alignment.center,
              child:  const Text("Iniciar", style: TextStyle(fontSize: 25))
            )
          )
        ],
      )
    );
  }
}