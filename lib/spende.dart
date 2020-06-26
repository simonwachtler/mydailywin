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
            Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 10, right: 10),
              child: Card(
                elevation: 10,
                child: ListTile(
                  title: Text("Spendiere jetzt einen Kaffee!"),
                  subtitle: Text("Betrag: 1,99€"),
                  leading: Image.asset(darkMode
                      ? "assets/coffee-white.png"
                      : "assets/coffee-black.png"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
              child: Card(
                elevation: 10,
                child: ListTile(
                    title: Text("Werde jetzt Gönner!"),
                    subtitle: Text("Betrag: 0,97€/Monat"),
                    leading: Image.asset(darkMode
                        ? "assets/goenner-white.png"
                        : "assets/goenner-black.png")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
              child: Card(
                elevation: 10,
                child: ListTile(
                  title: Text("Werde jetzt Freund!"),
                  subtitle: Text("Betrag: 2,97/Monat"),
                  leading: Image.asset(darkMode
                      ? "assets/herz-white.png"
                      : "assets/herz-black.png"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
              child: Card(
                elevation: 10,
                child: ListTile(
                    title: Text("Individuelle Spende!"),
                    subtitle: Text("Hier geht's zur Website!"),
                    leading: Image.asset(darkMode
                        ? "assets/Sparschwein-white.png"
                        : "assets/Sparschwein-black.png")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 45.0, left: 15),
              child: Text(
                "Jetzt sicher unterstützen mit",
                style: TextStyle(
                    fontFamily: 'Abadi', fontSize: 18, color: Colors.grey[700]),
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 10, height: 75),
                Image.asset(
                  "assets/applepay.png",
                  height: 60,
                  width: 80,
                ),
                SizedBox(width: 10),
                Image.asset(
                  "assets/Google_Pay.png",
                  height: 60,
                  width: 80,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 10, right: 10),
              child: Card(
                elevation: 10,
                child: ListTile(
                    title: Text("Werde jetzt Gönner!"),
                    subtitle: Text("Betrag: 0,97€/Monat"),
                    leading: Image.asset(darkMode
                        ? "assets/goenner-white.png"
                        : "assets/goenner-black.png")),
              ),
            ),
          ],
        ));
  }
}
