import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/authenticate.dart';
import 'package:guerra_dos_numeros/imagesLoader.dart';

import 'package:google_sign_in/google_sign_in.dart';

class Ranking extends StatefulWidget {
  const Ranking({Key? key}) : super(key: key);

  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  bool authenticated = false;

  static const usersList = [
    {
      'name': 'Paulo José',
      'score': 1000,
    },
    {
      'name': 'Ana Maria',
      'score': 500,
    },
    {
      'name': 'Ana Maria',
      'score': 500,
    },
    {
      'name': 'Ana Maria',
      'score': 500,
    },
    {
      'name': 'Ana Maria',
      'score': 500,
    },
    {
      'name': 'Ana Maria',
      'score': 500,
    },
    {
      'name': 'Paulo José',
      'score': 1000,
    },
    {
      'name': 'Ana Maria',
      'score': 500,
    },
    {
      'name': 'Ana Maria',
      'score': 500,
    },
  ];



  void _onRefreshButtonPressed() async {
    print('antes do login');
    await signInWithGoogle();
    print('depois do login');
  }

  @override
  Widget build(BuildContext context) {
    ImagesLoader images = ImagesLoader(false, true);

    double width =
    MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
        ? 960
        : 540;
    double height =
    MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
        ? 540
        : 960;

    if (MediaQuery.of(context).size.width / width >
        MediaQuery.of(context).size.height / height) {
      width = MediaQuery.of(context).size.width *
          height /
          MediaQuery.of(context).size.height;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "RANKING",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
              SizedBox(
                width: 93,
                height: 96,
                child: images.trophy,
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: usersList
                  .map((user) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: _buildListItem(user),
              ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _onRefreshButtonPressed,
              child: Text('loggin ${authenticated ? '1' : '0'}'),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListItem(Map<String, dynamic> user) {
    String name = user['name'];
    int score = user['score'];

    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                name,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            height: 64,
            width: 100,
            decoration: const BoxDecoration(
              color: Color(0xFF212A3E),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
            ),
            child: Text(
              '$score',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
