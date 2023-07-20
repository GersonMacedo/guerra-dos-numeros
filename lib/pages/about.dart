import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 960 : 540;
    double height = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 540 : 960;

    if(MediaQuery.of(context).size.width / width > MediaQuery.of(context).size.height / height){
      width = MediaQuery.of(context).size.width * height / MediaQuery.of(context).size.height;
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.white,
                size: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Sobre",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: width* 0.8,
            child:
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  "O aplicativo 'Guerra dos Números, Robôs e coisas Matemáticas', "
                      "surgiu da necessidade apontada pela professora, Joselita, observada nas salas de aula. ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
              ),
          ),
          Container(
            width: width* 0.8,
            padding: const EdgeInsets.only(left: 10, top: 50),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.book,
                      color: Colors.white,
                      size: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Sinopse",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child:
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Container(
                      child: Text(
                        "Prepare-se para uma aventura matemática eletrizante, "
                            "onde robôs se enfrentam em uma batalha épica contra "
                            "hambúrgueres. Enfrente desafios de matemática, enquanto  se diverte. ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
