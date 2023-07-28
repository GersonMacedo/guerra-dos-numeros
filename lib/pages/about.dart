import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
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
      padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
      child: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
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
              width: width * 0.8,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  "'Guerra dos Números, Robôs e coisas Matemáticas' foi um jogo produzido pelos alunos da UNIVASF em parceria com o Colégio Rui Barbosa.\n\n"
                  "Seu objetivo é ajudar nosso querido Hamburguito a derrotar o exército de robôs utilizando contas matemáticas com as operações básicas.\n\n"
                  "Organização:\n"
                  "Jogo distribuído gratuitamente pelos alunos de Engenharia de Software 3, ministrada pelo professor Ricardo Argenton Ramos.\n\n"
                  "Maria Clara Mendes da Silva - Designer e Product Owner (PO)\n"
                  "Richard Lima Ribeiro - Programador e Scrum Master\n"
                  "Carlos Lamark de Barros Alencar - Programador\n"
                  "Gerson Vinicius Rodrigues de Macedo - Programador\n"
                  "Luiz Fernando Barbosa da Silva - Programador\n\n"
                  "Agradecimentos: Neildson Sobreira de Lima Filho, Professora Joselita do Colégio Rui Barbosa.",
                  style: TextStyle(
=======

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      margin: const EdgeInsetsDirectional.all(10),
      decoration: const BoxDecoration(
          color: Color(0xFF828DF4),
          borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      child: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.info_outline,
>>>>>>> b4878a0f941ad913c768ad05490f526adfeb1c64
                    color: Colors.white,
                    size: 50,
                  ),
<<<<<<< HEAD
                ),
              ),
            ),
            Container(
              width: width * 0.8,
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
                    child: Padding(
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
=======
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 4),
                    child: Text(
                      "Sobre",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
>>>>>>> b4878a0f941ad913c768ad05490f526adfeb1c64
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                "\n'Guerra dos Números, Robôs e coisas Matemáticas' foi um jogo produzido pelos alunos da UNIVASF em parceria com o Colégio Rui Barbosa.\n\n"
                "Seu objetivo é ajudar nosso querido Hamburguito a derrotar o exército de robôs utilizando contas matemáticas com as operações básicas.\n\n"
                "Organização:\n"
                "Jogo distribuído gratuitamente pelos alunos de Engenharia de Software 3, ministrada pelo professor Ricardo Argenton Ramos.\n\n"
                "Maria Clara Mendes da Silva - Designer e Product Owner (PO)\n\n"
                "Richard Lima Ribeiro - Programador e Scrum Master\n\n"
                "Carlos Lamark de Barros Alencar - Programador\n\n"
                "Gerson Vinicius Rodrigues de Macedo - Programador\n\n"
                "Luiz Fernando Barbosa da Silva - Programador\n\n"
                "Agradecimentos: Neildson Sobreira de Lima Filho, Professora Joselita do Colégio Rui Barbosa.\n\n\n",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
                textAlign: TextAlign.justify,
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(
                      Icons.book,
                      color: Colors.white,
                      size: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Sinopse",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                        ),
                      ),
                    ),
                  ]
              ),
              const Text(
                "\nPrepare-se para uma aventura matemática eletrizante, "
                "onde robôs se enfrentam em uma batalha épica contra "
                "hambúrgueres. Enfrente desafios de matemática, enquanto  se diverte. ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
                textAlign: TextAlign.justify,
              )
            ],
          ),
        ),
      ),
    );
  }
}
