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
                    height: 30,
                  ),
                  Icon(Icons.person, color: Colors.white, size: 150),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 135),
              child:
                  Text("Simon", style: Theme.of(context).textTheme.headline4),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3.0, top: 150),
          child: Text(
            'JETZT ENTWICKLER UNTERSTÜTZEN!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontFamily: 'Abadi'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3.0, top: 60),
          child: Text(
            'GIB UNS 5 STERNE!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontFamily: 'Abadi'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3.0, top: 60),
          child: Text(
            'SUPPORT ERHALTEN!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontFamily: 'Abadi'),
          ),
        ),
      ]),
      // Um de drei Sochn mias mo jeweils no so a Box mochn.
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
