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
          Card(
            child: Row(
              children: <Widget>[
                Text("Simon", style: Theme.of(context).textTheme.headline4),
                Spacer(),
                Icon(
                  Icons.person,
                  size: 75,
                  color: Colors.grey.shade300,
                )
              ],
            ),
          ),
          SwitchListTile.adaptive(
            title: Text("Deaktiviert"),
            subtitle: Text("Biometrische Bildschirmsperre "),
            onChanged: (enabled) {
              print("Aktiviert: $enabled");
            },
            value: false,
          ),
          DarkModeSwitch(),
        ],
      ),
    );
  }
}
