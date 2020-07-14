import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'animations.dart';
import 'data.dart';

class Spenden extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness == Brightness.dark;
    final model = context.watch<DataModel>();
    return Scaffold(
        appBar: AppBar(title: Text("Unterstütze uns jetzt, ${model.name}!")),
        body: AnimatedListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 10, right: 10),
              child: Card(
                clipBehavior: Clip.hardEdge,
                elevation: 10,
                child: ListTile(
                    title: Text("Spendiere jetzt einen Kaffee!"),
                    subtitle: Text("Betrag: 1,99€"),
                    leading: Image.asset(darkMode
                        ? "assets/coffee-white.png"
                        : "assets/coffee-black.png"),
                    onTap: () {
                      launch(
                          "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=YBGW9QXH8UM3Q&source=url");
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
              child: Card(
                clipBehavior: Clip.hardEdge,
                elevation: 10,
                child: ListTile(
                    title: Text("Werde jetzt Gönner!"),
                    subtitle: Text("Betrag: 0,97€/Monat"),
                    leading: Image.asset(darkMode
                        ? "assets/goenner-white.png"
                        : "assets/goenner-black.png"),
                    onTap: () {
                      launch(
                          "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=DFBK2QCD7EF6C&source=url");
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
              child: Card(
                clipBehavior: Clip.hardEdge,
                elevation: 10,
                child: ListTile(
                    title: Text("Werde jetzt Freund!"),
                    subtitle: Text("Betrag: 2,97/Monat"),
                    leading: Image.asset(darkMode
                        ? "assets/herz-white.png"
                        : "assets/herz-black.png"),
                    onTap: () {
                      launch(
                          "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=5ZCCEN697H3W4&source=url");
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
              child: Card(
                clipBehavior: Clip.hardEdge,
                elevation: 10,
                child: ListTile(
                    title: Text("Individuelle Spende!"),
                    subtitle: Text("Hier geht's zur Website!"),
                    leading: Image.asset(darkMode
                        ? "assets/Sparschwein-white.png"
                        : "assets/Sparschwein-black.png"),
                    onTap: () {
                      launch(
                          "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=6Z2Q5BDH9GLWS&source=url");
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 45.0, left: 28, bottom: 10),
              child: Text(
                "Jetzt uns sicher unterstützen mit",
                style: TextStyle(
                    fontFamily: 'Abadi',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
            ),
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: _launchURL,
                  child: Image.asset(
                    'assets/paypal.png', // On click should redirect to an URL
                    width: 180.0,
                    height: 60.0,
                    //Image.asset("assets/paypal.png", height: 60, width: 180,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 10, right: 10),
              child: Card(
                clipBehavior: Clip.hardEdge,
                elevation: 10,
                child: ListTile(
                    title: Text("Herzliches Dankeschön!"),
                    subtitle: Text(
                        "Wir, Michael & Simon, bedanken uns für \nIhre liebenswerte Unterstützung!"),
                    leading: Image.asset(darkMode
                        ? "assets/herz-white.png"
                        : "assets/herz-black.png"),
                    onTap: () {
                      launch(
                          "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=FQTWZSRWSUXKN&source=url");
                    }),
              ),
            ),
          ],
        ));
  }
}

_launchURL() async {
  const url =
      'https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=FQTWZSRWSUXKN&source=url';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
