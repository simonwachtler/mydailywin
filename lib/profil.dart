import 'package:flutter/material.dart';

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
                Icon(Icons.settings, color: Colors.black, size: 40),
              ],
            ),
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            print("isRecording");
          },
          child: Padding(
            padding: EdgeInsets.only(left: 3.0, top: 100),
            child: Container(
              width: 370,
              decoration: new BoxDecoration(
                color: Colors.purple[200],
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Text(
                  "JETZT ENTWICKLER UNTERSTÜTZEN! >>",
                  style: TextStyle(fontSize: 20, fontFamily: 'Abadi'),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            print("isRecording");
          },
          child: Padding(
            padding: EdgeInsets.only(left: 3.0, top: 15),
            child: Container(
              width: 370,
              decoration: new BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Text(
                  "GIB UNS 5 STERNE!",
                  style: TextStyle(fontSize: 25, fontFamily: 'Abadi'),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            print("isRecording");
          },
          child: Padding(
            padding: EdgeInsets.only(left: 3.0, top: 15),
            child: Container(
              width: 370,
              decoration: new BoxDecoration(
                color: Colors.green[300],
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Text(
                  "SUPPORT ERHALTEN!",
                  style: TextStyle(fontSize: 25, fontFamily: 'Abadi'),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class ProfilBox extends StatelessWidget {
  final Color color;
  final Widget child;

  const ProfilBox({Key key, this.color, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
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
