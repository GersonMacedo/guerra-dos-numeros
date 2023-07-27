import 'dart:async';
import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/imagesLoader.dart';
import 'package:guerra_dos_numeros/levels.dart';
import 'package:guerra_dos_numeros/pages/howToPlay.dart';
import 'package:guerra_dos_numeros/pages/modeSelector.dart';
import 'package:guerra_dos_numeros/pages/skinSelector.dart';
import 'package:provider/provider.dart';

import '../provider/databaseProvider.dart';
import '../provider/googleSignInProvider.dart';

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
  ImagesLoader images = ImagesLoader(true, true, false, false);

  @override
  Widget build(BuildContext context){
    double width = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 960 : 540;
    double height = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 540 : 960;
    
    if(MediaQuery.of(context).size.width / width > MediaQuery.of(context).size.height / height){
      width = MediaQuery.of(context).size.width * height / MediaQuery.of(context).size.height;
    }

    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              Levels.title,
              style: TextStyle(fontSize: 50, color: Colors.white),
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
          buildButtons()
        ],
      )
    );
  }

  Widget buildButtons(){
    const double buttonsWidth = 250;
    String loginOrLogout = "Entrar na Conta";
    DatabaseProvider databaseProvider = DatabaseProvider();

    return Flex(
      direction: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? Axis.horizontal : Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: (){widget.changePage(ModeSelector(widget.changePage), keep: true);},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff50CB93),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            )
          ),
          child: Container(
            width: buttonsWidth,
            height: 50,
            alignment: Alignment.center,
            child:  const Text("Iniciar", style: TextStyle(fontSize: 30))
          )
        ),
        const SizedBox(width: 20, height: 20),
        ElevatedButton(
            onPressed: (){widget.changePage(const HowToPlay(), keep: true);},
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff50CB93),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            child: Container(
                width: buttonsWidth,
                height: 50,
                alignment: Alignment.center,
                child:  const Text("Como Jogar", style: TextStyle(fontSize: 30))
            )
        ),
        const SizedBox(width: 20, height: 20),
        ElevatedButton(
            onPressed: (){widget.changePage(const SkinSelector(), keep: true);},
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff50CB93),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            child: Container(
                width: buttonsWidth,
                height: 50,
                alignment: Alignment.center,
                child:  const Text("Personagens", style: TextStyle(fontSize: 30))
            )
        ),
        const SizedBox(width: 20, height: 20),
        ElevatedButton(
          onPressed: () async {
            final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
            if (provider.user != null) {
              // O usuário está logado
              await provider.logout();
            } else {
              // O usuário não está logado
              await provider.googleLogin();
            }
            await databaseProvider.saveUserData();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff50CB93),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Container(
            width: buttonsWidth,
            height: 50,
            alignment: Alignment.center,
            child: Consumer<GoogleSignInProvider>(
              builder: (context, provider, _) {
                String buttonText = provider.user != null ? "Sair da Conta" : "Entrar na Conta";
                return Text(
                  buttonText,
                  style: TextStyle(fontSize: 30),
                );
              },
            ),
          ),
        )
      ]
    );
  }
}