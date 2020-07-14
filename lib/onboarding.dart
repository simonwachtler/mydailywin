import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'animations.dart';
import 'main.dart';
import 'data.dart';
import 'settings.dart';

class FirstImpression extends StatefulWidget {
  @override
  _FirstImpressionState createState() => _FirstImpressionState();
}

class _FirstImpressionState extends State<FirstImpression> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: AnimatedListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 118.0),
              child: Image.asset(
                'assets/win-grey.png',
                height: 220,
                width: 250,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: Text(
                "Herzlich Willkommen \nbei My Daily Win!",
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                  child:
                      Text("Bevor wir gleich loslegen: Dein Vorname, bitte!")),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
                controller: _controller,
                onChanged: (n) => setState(() {}),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                elevation: 7,
                color: Colors.blue,
                onPressed: _controller.text.isNotEmpty
                    ? () {
                        context.read<DataModel>().name = _controller.text;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Onboarding()),
                        );
                      }
                    : null,
                child: Text("Jetzt loslegen!"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<DataModel>();
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: AnimatedColumn(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 118.0),
              child: Image.asset(
                'assets/rakete.png',
                height: 220,
                width: 250,
              ),
            ),
            Text(
              "So funktioniert's:",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Notiere jeden Tag 5 Erfolge, \nbaue dadurch Dein Selbsvertrauen auf \nund gewinne Mut und Motivation \nfür neue Herausforderungen ",
                textAlign: TextAlign.center,
              ),
            ),
            SwitchListTile.adaptive(
              title: Text("Am Morgen erinnern"),
              subtitle:
                  Text("Ich möchte morgens ans Eintragen erinnert werden"),
              value: model.dailyNotificationsEnabled,
              onChanged: (enabled) {
                model.dailyNotificationsEnabled = enabled;
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                elevation: 7,
                color: Colors.blue,
                onPressed: () async {
                  Navigator.pop(context);
                  await initializeNotifications(context);
                  updateNotifications(model.dailyNotificationsEnabled);
                },
                child: Text("Los geht's!"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
