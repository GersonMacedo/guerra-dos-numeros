import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guerra_dos_numeros/provider/databaseProvider.dart';
import 'package:guerra_dos_numeros/provider/googleSignInProvider.dart';
import 'package:guerra_dos_numeros/levels.dart';
import 'package:guerra_dos_numeros/pages/about.dart';
import 'package:guerra_dos_numeros/pages/achievements.dart';
import 'package:guerra_dos_numeros/pages/menu.dart';
import 'package:guerra_dos_numeros/pages/ranking.dart';
import 'package:guerra_dos_numeros/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

//TODO: adicionar sons ao jogo
//TODO: adicionar conquistas

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
      Provider<DatabaseProvider>(create: (context) => DatabaseProvider()),
    ],
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    ),
  );

}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  _HomeState(){
    selected.add(Menu(changePage, key: UniqueKey()));
    bottomButtons.add(true);
    backButton.add(false);
    Levels.addDemoLevels(30, 20);
    Levels.loadData();
  }

  List<Widget> selected = [];
  List<bool> bottomButtons = [];
  List<bool> backButton = [];

  void changePage(Widget? page, {bool bottom = true, bool back = true, bool keep = false}){
    setState(() {
      if(page == null){
        selected.removeLast();
        bottomButtons.removeLast();
        backButton.removeLast();
      }else{
        if(!keep){
          selected = [selected[0]];
          bottomButtons = [bottomButtons[0]];
          backButton = [backButton[0]];
        }

        bottomButtons.add(bottom);
        selected.add(page);
        backButton.add(back);
      }
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
        if(selected.last.key == const ValueKey("Menu")){
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
                    Expanded(child: selected.last),
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
    if(!backButton.last){
      return Container();
    }

    return Container(
        height: 80,
        width: 250,
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: ElevatedButton(
            onPressed: (){changePage(null);},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              shape: const RoundedRectangleBorder()
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(Icons.arrow_back_ios, size: 40, color: Colors.black),
                Text("         voltar  ", style: TextStyle(color: Colors.black, fontSize: 30))
              ]
            )
        )
    );
  }

  Widget buildBottomButtons(){
    if(!bottomButtons.last){
      return Container();
    }

    return Container(
      height: 70,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: (){changePage(Achievements());},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/medal.png'),
                const Text("Conquistas", style: TextStyle(color: Colors.white, fontSize: 25))
              ],
            )
          ),
          TextButton(
              onPressed: (){changePage(About());},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.info_outline, color: Colors.white, size: 40),
                  Text(" Sobre", style: TextStyle(color: Colors.white, fontSize: 25))
                ],
              )
          ),
          TextButton(
              onPressed: (){

                changePage(Ranking());
                },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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