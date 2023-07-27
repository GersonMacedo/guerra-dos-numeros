import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/levels.dart';
import 'package:guerra_dos_numeros/pages/customLevelSelector.dart';
import 'package:guerra_dos_numeros/pages/levelSelector.dart';
import 'package:guerra_dos_numeros/pages/skinSelector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModeSelector extends StatefulWidget {
  const ModeSelector(this.changePage, {super.key});
  final void Function(Widget?, {bool bottom, bool back, bool keep}) changePage;

  @override
  State<ModeSelector> createState() => _ModeSelectorState();
}

class _ModeSelectorState extends State<ModeSelector> {
  bool numericMode = true;
  int skinNumber = 0;

  @override
  void initState() {
    super.initState();
    _loadSkinNumber();
  }

  Future<void> _loadSkinNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      skinNumber = prefs.getInt('skinNumber') ?? 0;
    });
  }

  Future<void> _saveSkinNumber(int newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('skinNumber', newValue);
  }

  void setMode(bool mode) {
    setState(() {
      numericMode = mode;
    });
  }

  void updateSkin(int newValue) {
    setState(() {
      skinNumber = newValue;
      _saveSkinNumber(newValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("Escolha um modo", style: TextStyle(color: Colors.white, fontSize: 38)),
            const SizedBox(height: 20, width: double.infinity),
            ElevatedButton(
              onPressed: () {
                Levels.type = 0;
                widget.changePage(LevelSelector(widget.changePage, skinNumber), keep: true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Container(
                width: 400,
                height: 70,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF212A3E),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      child: const Text("+", style: TextStyle(fontSize: 30, color: Colors.white)),
                    ),
                    const Expanded(child: Text("Adição", style: TextStyle(fontSize: 30, color: Colors.black), textAlign: TextAlign.center))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20, width: double.infinity),
            ElevatedButton(
              onPressed: () {
                Levels.type = 1;
                widget.changePage(LevelSelector(widget.changePage, skinNumber), keep: true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Container(
                width: 400,
                height: 70,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF212A3E),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      child: const Text("x", style: TextStyle(fontSize: 30, color: Colors.white)),
                    ),
                    const Expanded(child: Text("Multiplicação", style: TextStyle(fontSize: 30, color: Colors.black), textAlign: TextAlign.center)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20, width: double.infinity),
            ElevatedButton(
              onPressed: () {
                Levels.type = -1;
                widget.changePage(CustomLevelSelector(widget.changePage, skinNumber), keep: true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Container(
                width: 400,
                height: 70,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF212A3E),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      child: const Text("?", style: TextStyle(fontSize: 30, color: Colors.white)),
                    ),
                    const Expanded( child: Text("Aleatório", style: TextStyle(fontSize: 30, color: Colors.black), textAlign: TextAlign.center,)),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(),
      ],
    );
  }
}
