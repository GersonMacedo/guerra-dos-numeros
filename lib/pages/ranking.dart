import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/imagesLoader.dart';

import '../provider/databaseProvider.dart';

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
          SizedBox(height: 30),
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
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child:
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
                  width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  child:  const Text("Atualizar", style: TextStyle(fontSize: 30))
              )
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
