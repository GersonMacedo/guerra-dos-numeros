import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Ranking extends StatelessWidget {
  const Ranking({Key? key}) : super(key: key);

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
  ];

  signInWithGoogle() async {
    print('resultado:');
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    print('resultado: $userCredential.user');
  }

  void _onRefreshButtonPressed() {
    signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 50.0),
              child: const Text(
                'Ranking',
                style: TextStyle(fontSize: 60, color: Colors.white),
              )),
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
              child: const Text('Atualizar'),
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
