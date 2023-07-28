import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/authenticate.dart';
import 'package:guerra_dos_numeros/imagesLoader.dart';
import 'package:provider/provider.dart';

<<<<<<< HEAD
import 'package:google_sign_in/google_sign_in.dart';
=======
import '../provider/databaseProvider.dart';
import '../provider/googleSignInProvider.dart';
>>>>>>> b4878a0f941ad913c768ad05490f526adfeb1c64

class Ranking extends StatefulWidget {
  const Ranking({Key? key}) : super(key: key);

  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
<<<<<<< HEAD
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
=======
  ImagesLoader images = ImagesLoader(false, false, false, false);
  List<Map<String, dynamic>> usersList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshUsersList();
  }

  void _refreshUsersList() {
    setState(() {
      isLoading = true;
    });

    DatabaseProvider databaseProvider = DatabaseProvider();
    databaseProvider.getUpdatedDatabase().then((updatedUsersList) {
      setState(() {
        usersList = updatedUsersList;
        isLoading = false;
      });
    });
>>>>>>> b4878a0f941ad913c768ad05490f526adfeb1c64
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 960 : 540;
    double height = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 540 : 960;

<<<<<<< HEAD
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
=======
    if (MediaQuery.of(context).size.width / width > MediaQuery.of(context).size.height / height) {
      width = MediaQuery.of(context).size.width * height / MediaQuery.of(context).size.height;
    }

    return Container(
      padding: const EdgeInsets.only(left: 60, right: 60),
>>>>>>> b4878a0f941ad913c768ad05490f526adfeb1c64
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
<<<<<<< HEAD
          const SizedBox(height: 50),
=======
>>>>>>> b4878a0f941ad913c768ad05490f526adfeb1c64
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "RANKING    ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: images.trophy,
              ),
            ],
          ),
          Expanded(
<<<<<<< HEAD
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
=======
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : usersList.isEmpty
                ? Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: width - 10),
                child: FittedBox( // Wrap the text in a FittedBox
                  fit: BoxFit.scaleDown, // Scale down the text to fit the available width
                  child: Text(
                    "Aperte em 'Atualizar' para receber a lista",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            )
                : ListView(
              children: usersList.map((user) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _buildListItem(user),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 5),
          Flex(
            direction: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? Axis.horizontal : Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  DatabaseProvider databaseProvider = DatabaseProvider();
                  await databaseProvider.saveUserData();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff50CB93),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Container(
                  width: 250,
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
              ),
              const SizedBox(width: 20, height: 20),
              ElevatedButton(
                  onPressed: () {
                    // Chama a função para atualizar a lista quando o botão é pressionado
                    _refreshUsersList();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff50CB93),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                  child: Container(
                      width: 250,
                      height: 50,
                      alignment: Alignment.center,
                      child:  const Text("Atualizar", style: TextStyle(fontSize: 30))
                  )
              ),
            ],
          ),
          const SizedBox(height: 5),
>>>>>>> b4878a0f941ad913c768ad05490f526adfeb1c64
        ],
      ),
    );
  }

  Widget _buildListItem(Map<String, dynamic> user) {
    String name = user['name'];
    int score = user['score'];

    return Container(
<<<<<<< HEAD
      height: 64,
=======
      height: 50,
>>>>>>> b4878a0f941ad913c768ad05490f526adfeb1c64
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
<<<<<<< HEAD
                style: const TextStyle(fontSize: 24),
=======
                style: const TextStyle(fontSize: 20),
>>>>>>> b4878a0f941ad913c768ad05490f526adfeb1c64
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
<<<<<<< HEAD
            height: 64,
=======
            height: 50,
>>>>>>> b4878a0f941ad913c768ad05490f526adfeb1c64
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
