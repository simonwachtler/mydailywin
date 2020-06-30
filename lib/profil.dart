import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'animations.dart';
import 'main.dart';
import 'settings.dart';
import 'spende.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return AnimatedColumn(
      children: [
        Row(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
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
                    child: data.imageFilePath == null
                        ? Icon(Icons.person, color: Colors.white, size: 150)
                        : Image.file(File(data.imageFilePath)),
                    height: 150,
                    width: 150,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 129, left: 16),
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(50),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                        width: 170,
                        height: 60,
                        child: Center(
                          child: Text(data.name,
                              style: Theme.of(context).textTheme.headline4),
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 129, left: 7),
              child: Material(
                clipBehavior: Clip.hardEdge,
                color: Colors.grey.withAlpha(50),
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 50,
                      height: 60,
                      child: Center(
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            await showNameDialog(context);
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Spacer(),
            Material(
              clipBehavior: Clip.hardEdge,
              color: Colors.grey.withAlpha(100),
              borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
              child: IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () async {
                    await Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => Settings()));
                    if (this.mounted) setState(() {});
                  }),
            ),
          ],
        ),
        ProfilBox(
          color: Colors.purple,
          text: "JETZT ENTWICKLER UNTERSTÜTZEN!",
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
        ),
        ProfilBox(
          color: Colors.orange,
          text: "FOLGE UNS!",
          onTap: () {
            launch("https://www.instagram.com");
          },
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
      padding: EdgeInsets.only(left: 9.0, top: 17),
      child: Material(
        clipBehavior: Clip.hardEdge,
        elevation: 4,
        color: Color.lerp(
          color,
          Theme.of(context).scaffoldBackgroundColor,
          .300,
        ),
        borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
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
    );
  }
}
