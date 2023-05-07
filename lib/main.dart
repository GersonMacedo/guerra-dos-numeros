import 'dart:math';

import 'package:flutter/material.dart';

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
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget  {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF54436B),
      padding: const EdgeInsets.all(30),
      child: FittedBox(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const Text(
              "Guerra dos números, Robôs e coisas matemáticas",
              style: TextStyle(fontSize: 29, color: Colors.white)
            ),
            const SizedBox(height: 15),
            Image.asset('assets/images/main.png'),
            const SizedBox(height: 15),
            MediaQuery.of(context).size.width > 1.1 * MediaQuery.of(context).size.height ? horizontal(context) : vertical(context)
          ],
        )
      )
    );
  }

  Widget horizontal(BuildContext context){
    return Row(
      children: [
        SizedBox(
          width: 155,
          child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PlayPage()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Row(
                children: const [
                  Icon(Icons.play_circle),
                  Text(" Jogar", style: TextStyle(fontSize: 14, color: Colors.white))
                ],
              )
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 155,
          child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AchievementsPage()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Row(
                children: const [
                  Icon(Icons.emoji_events),
                  Text(" Conquistas", style: TextStyle(fontSize: 14, color: Colors.white))
                ],
              )
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 155,
          child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Row(
                children: const [
                  Icon(Icons.settings),
                  Text(" Configurações", style: TextStyle(fontSize: 14, color: Colors.white))
                ],
              )
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 155,
          child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Row(
                children: const [
                  Icon(Icons.info_outline),
                  Text(" Sobre", style: TextStyle(fontSize: 14, color: Colors.white))
                ],
              )
          ),
        )
      ],
    );
  }

  Widget vertical(BuildContext context){
    return Column(
      children: [
        SizedBox(
          width: 300,
          child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PlayPage()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Row(
                children: const [
                  Icon(Icons.play_circle),
                  Text(" Jogar", style: TextStyle(fontSize: 30, color: Colors.white))
                ],
              )
          ),
        ),
        const SizedBox(height: 19),
        SizedBox(
          width: 300,
          child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AchievementsPage()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Row(
                children: const [
                  Icon(Icons.emoji_events),
                  Text(" Conquistas", style: TextStyle(fontSize: 30, color: Colors.white))
                ],
              )
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: 300,
          child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Row(
                children: const [
                  Icon(Icons.settings),
                  Text(" Configurações", style: TextStyle(fontSize: 30, color: Colors.white))
                ],
              )
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: 300,
          child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Row(
                children: const [
                  Icon(Icons.info_outline),
                  Text(" Sobre", style: TextStyle(fontSize: 30, color: Colors.white))
                ],
              )
          ),
        )
      ],
    );
  }
}

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFF54436B),
        padding: const EdgeInsets.all(30),
        child: FittedBox(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder()
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text("Voltar", style: const TextStyle(fontSize: 22, color: Colors.black))
                  )
                ]
              ),
              const Text("TODO: tela Jogar")
            ],
          )
        )
    );
  }
}

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFF54436B),
        padding: const EdgeInsets.all(30),
        child: FittedBox(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Column(
                    children: [
                      const SizedBox(height: 15),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder()
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text("Voltar", style: const TextStyle(fontSize: 22, color: Colors.black))
                      )
                    ]
                ),
                const Text("TODO: tela de conquistas")
              ],
            )
        )
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFF54436B),
        padding: const EdgeInsets.all(30),
        child: FittedBox(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Column(
                    children: [
                      const SizedBox(height: 15),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder()
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text("Voltar", style: const TextStyle(fontSize: 22, color: Colors.black))
                      )
                    ]
                ),
                const Text("TODO: tela de configurações")
              ],
            )
        )
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFF54436B),
        padding: const EdgeInsets.all(30),
        child: FittedBox(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Column(
                    children: [
                      const SizedBox(height: 15),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder()
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text("Voltar", style: const TextStyle(fontSize: 22, color: Colors.black))
                      )
                    ]
                ),
                const Text("TODO: tela de sobre")
              ],
            )
        )
    );
  }
}

