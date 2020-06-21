import 'package:flutter/material.dart';
import 'package:persist_theme/ui/theme_widgets.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Spacer(),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.purple[900],
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(16)),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child:
                          Icon(Icons.camera_alt, color: Colors.white, size: 75),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 33, left: 12, right: 12),
            child: Card(
              child: Row(
                children: <Widget>[
                  Text(" Simon", style: Theme.of(context).textTheme.headline4),
                  Spacer(),
                  Icon(
                    Icons.person,
                    size: 75,
                    color: Colors.grey.shade300,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
            child: SwitchListTile.adaptive(
              title: Text("Deaktiviert"),
              subtitle: Text("Biometrische Bildschirmsperre "),
              onChanged: (enabled) {
                print("Aktiviert: $enabled");
              },
              value: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7, left: 12, right: 12),
            child: Column(
              children: <Widget>[
                DarkModeSwitch(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
                '\n\n                              ver 1\n\n© Debertol Michael & Wachtler Simon'),
          )
        ],
      ),
    );
  }
}
