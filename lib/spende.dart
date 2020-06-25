import 'package:flutter/material.dart';
import 'main.dart';

class Spenden extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        appBar: AppBar(title: Text("Unterstütze uns jetzt, $name!")),
        body: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text("Spende jetzt einen Kaffee!"),
                subtitle: Text("Betrag: 1,99€"),
                leading: Image.asset(darkMode
                    ? "assets/coffee-white.png"
                    : "assets/coffee-black.png"),
              ),
            ),
            Card(
              child: ListTile(
                  title: Text("Werde jetzt Gönner!"),
                  subtitle: Text("Betrag: 0,97€/Monat"),
                  leading: Image.asset(darkMode
                      ? "assets/goenner-white.png"
                      : "assets/goenner-black.png")),
            ),
            Card(
              child: ListTile(
                title: Text("Werde jetzt Freund!"),
                subtitle: Text("Betrag: 2,97/Monat"),
                leading: Image.asset(darkMode
                    ? "assets/herz-white.png"
                    : "assets/herz-black.png"),
              ),
            ),
            Card(
              child: ListTile(
                  title: Text("Individuelle Spende!"),
                  subtitle: Text("Hier geht's zur Website!"),
                  leading: Image.asset(darkMode
                      ? "assets/Sparschwein-white.png"
                      : "assets/Sparschwein-black.png")),
            ),
          ],
        ));
  }
}
