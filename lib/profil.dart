import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import 'animations.dart';
import 'data.dart';
import 'main.dart';
import 'settings.dart';
import 'spende.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<DataModel>();

    // https://github.com/flutter/flutter/issues/14842
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: AnimatedListView(
        children: [
          Row(
            children: [
              Container(
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
                      child: model.imageFilePath == null
                          ? Icon(Icons.person, color: Colors.white, size: 150)
                          : Image.file(File(model.imageFilePath)),
                      height: 150,
                      width: 150,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 129, left: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(50),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(model.name,
                          style: Theme.of(context).textTheme.headline4),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 129, left: 7, right: 7),
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
                            onPressed: () {
                              showNameDialog(context);
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
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(16)),
                child: IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => Settings()));
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
            onTap: () {
              if (Platform.isAndroid) {
                launch("market://details?id=com.mydailywin");
              } else if (Platform.isIOS) {
                launch(
                    "https://apps.apple.com/app/id1522047675?action=write-review");
              }
            },
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
              launch("https://www.instagram.com/mydaily.win");
            },
          ),
        ],
      ),
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
      padding: EdgeInsets.only(left: 9.0, top: 8, bottom: 9),
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
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
