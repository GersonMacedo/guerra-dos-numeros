import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/imagesLoader.dart';
import 'package:provider/provider.dart';

import '../provider/databaseProvider.dart';
import '../provider/googleSignInProvider.dart';

class Ranking extends StatefulWidget {
  const Ranking({Key? key}) : super(key: key);

  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
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
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 960 : 540;
    double height = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 540 : 960;

    if (MediaQuery.of(context).size.width / width > MediaQuery.of(context).size.height / height) {
      width = MediaQuery.of(context).size.width * height / MediaQuery.of(context).size.height;
    }

    return Container(
      padding: const EdgeInsets.only(left: 60, right: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
        ],
      ),
    );
  }

  Widget _buildListItem(Map<String, dynamic> user) {
    String name = user['name'];
    int score = user['score'];

    return Container(
      height: 50,
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
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            height: 50,
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
