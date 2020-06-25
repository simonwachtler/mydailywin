import 'package:flutter/material.dart';
import 'package:my_daily_success/main.dart';
import 'package:url_launcher/url_launcher.dart';

import 'data.dart';
import 'settings.dart';
import 'spende.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Row(
          children: [
            Container(
              decoration: new BoxDecoration(
                color: Colors.purple[900],
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(16)),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: imageFile == null
                        ? Icon(Icons.person, color: Colors.white, size: 150)
                        : Image.file(imageFile),
                    height: 150,
                    width: 150,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 115),
              child: Text(name, style: Theme.of(context).textTheme.headline4),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 126, left: 6),
              child: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () async {
                  await showNameDialog(context);
                  writeName();
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 360, top: 19),
          child: Container(
            decoration: new BoxDecoration(
              color: Colors.grey.withAlpha(100),
              borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 130,
                ),
                IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () async {
                      await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => Settings()));
                      if (this.mounted) setState(() {});
                    }),
              ],
            ),
          ),
        ),
        ProfilBox(
          color: Colors.purple,
          text: "JETZT ENTWICKLER UNTERSTÜTZEN! >>",
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Spenden()));
          },
        ),
        ProfilBox(
          color: Colors.blue,
          text: "GIB UNS 5 STERNE!",
        ),
        ProfilBox(
          color: Colors.green,
          text: "SUPPORT ERHALTEN!",
          onTap: () {
            launch("https://form.jotform.com/201736647022047");
          },
          // diese Seite verlinken:
        ),
      ]),
    );
  }
}

class ProfilBox extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onTap;

  const ProfilBox({Key key, this.color, this.text, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3.0, top: 15),
      child: Container(
        width: 370,
        child: Material(
          color: color.withAlpha(150),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 25, fontFamily: 'Abadi'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: RaisedButton(
          child: Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsRoute()),
            );
          },
        ),
      ),
    );
  }
}

class SettingsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
