import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guerra_dos_numeros/pages/menu.dart';
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
  bool menu = true;
  Widget selected = Container();
  Widget back = Container();

  void changePage(Widget? page){
    setState(() {
      if(page == null){
        menu = true;
      }else{
        menu = false;
        selected = page;
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
        if(menu){
          return Future(() => true);
        }

        setState(() {
          menu = true;
        });
        return Future(() => false);
      },
      child: Material(
        child: Container(
          color: Colors.black,
          child: FittedBox(
            alignment: Alignment.topCenter,
            child: SizedBox(
                width: width,
                height: height,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF54436B),
                  ),
                  child: menu ? Menu(changePage: changePage) : selected
                )
            )
          )
        )
      )
    );
  }
}