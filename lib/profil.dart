import 'package:flutter/material.dart';

import 'settings.dart';

class Profil extends StatelessWidget {
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
                  Icon(Icons.person, color: Colors.white, size: 150),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 115),
              child:
                  Text("Simon", style: Theme.of(context).textTheme.headline4),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 125, left: 6),
              child:
                  Text("Level 5", style: Theme.of(context).textTheme.headline6),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 360, top: 15),
          child: Container(
            decoration: new BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 130,
                ),
                IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => Settings()));
                    }),
              ],
            ),
          ),
        ),
        ProfilBox(
          color: Colors.purple[200],
          text: "JETZT ENTWICKLER UNTERSTÜTZEN! >>",
        ),
        ProfilBox(
          color: Colors.blue[200],
          text: "GIB UNS 5 STERNE!",
        ),
        ProfilBox(
          color: Colors.green[300],
          text: "SUPPORT ERHALTEN!",
        ),
      ]),
    );
  }
}

class ProfilBox extends StatelessWidget {
  final Color color;
  final String text;

  const ProfilBox({Key key, this.color, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3.0, top: 15),
      child: Container(
        width: 370,
        child: Material(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: InkWell(
            onTap: () {
              print("isRecording");
            },
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
