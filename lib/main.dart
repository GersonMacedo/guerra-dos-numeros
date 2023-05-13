import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guerra_dos_numeros/pages/about.dart';
import 'package:guerra_dos_numeros/pages/achievements.dart';
import 'package:guerra_dos_numeros/pages/menu.dart';
import 'package:guerra_dos_numeros/pages/settings.dart';
import 'package:guerra_dos_numeros/utils.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home()
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  _HomeState(){
    selected = Menu(changePage, frame, fps, key: UniqueKey());
    _timer = Timer.periodic(
      Duration(microseconds: 1000000 ~/ fps), (timer) {
        setState(() {
          frame++;
        });
      }
    );
  }

  late Timer _timer;
  int frame = 0;
  int fps = 10;
  bool bottomButtons = true;
  bool backButton = false;
  late Widget selected;

  void changePage(Widget? page, {bool bottom = true, bool back = false}){
    setState(() {
      if(page == null){
        selected = Menu(changePage, frame, fps, key: const ValueKey("Menu"));
      }else{
        selected = page;
      }

      bottomButtons = bottom;
      backButton = back;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    bool vertical = onVertical(context);
    double width = vertical ? 540 : 960;
    double height = vertical ? 960 : 540;

    if(MediaQuery.of(context).size.width / width < MediaQuery.of(context).size.height / height){
      height = MediaQuery.of(context).size.height * width / MediaQuery.of(context).size.width;
    }else{
      width = MediaQuery.of(context).size.width * height / MediaQuery.of(context).size.height;
    }

    return WillPopScope(
      onWillPop: (){
        if(selected.key == const ValueKey("Menu")){
          return Future(() => true);
        }

        changePage(null);
        return Future(() => false);
      },
      child: Material(
        child: Container(
          color: Colors.black,
          child: FittedBox(
            alignment: Alignment.topCenter,
            child: Container(
                width: width,
                height: height,
                color: const Color(0xFF54436B),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildBackButton(),
                    Expanded(child: selected),
                    buildBottomButtons()
                  ],
                )
            )
          )
        )
      )
    );
  }

  Widget buildBackButton(){
    if(!backButton){
      return Container();
    }

    return Container(
        height: 60,
        width: 100,
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: ElevatedButton(
            onPressed: (){changePage(null);},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              shape: RoundedRectangleBorder()
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
                Text("  Voltar  ", style: TextStyle(color: Colors.black, fontSize: 18))
              ]
            )
        )
    );
  }

  Widget buildBottomButtons(){
    if(!bottomButtons){
      return Container();
    }

    return Container(
      height: 50,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: (){changePage(Achievements(), back: true);},
            child: Row(
              children: [
                Image.asset('assets/images/medal.png'),
                const Text("Conquistas", style: TextStyle(color: Colors.white, fontSize: 25))
              ],
            )
          ),
          TextButton(
              onPressed: (){changePage(About(), back: true);},
              child: Row(
                children: const [
                  Icon(Icons.info_outline, color: Colors.white, size: 40),
                  Text(" Sobre", style: TextStyle(color: Colors.white, fontSize: 25))
                ],
              )
          ),
          TextButton(
              onPressed: (){changePage(Settings(), back: true);},
              child: Row(
                children: const [
                  Icon(Icons.emoji_events_outlined, color: Colors.white, size: 40),
                  Text(" Ranking", style: TextStyle(color: Colors.white, fontSize: 25))
                ],
              )
          )
        ]
      )
    );
  }
}