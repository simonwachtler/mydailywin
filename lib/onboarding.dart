import 'package:flutter/material.dart';
import 'package:my_daily_success/animations.dart';
import 'package:my_daily_success/settings.dart';

import 'main.dart';
import 'data.dart';

class FirstImpression extends StatefulWidget {
  @override
  _FirstImpressionState createState() => _FirstImpressionState();
}

class _FirstImpressionState extends State<FirstImpression> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedColumn(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 170),
            child: Text(
              "Willkommen bei\nMy Daily Win!",
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text("Bevor wir loslegen: Wie heißt du?"),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              onChanged: (n) => setState(() {}),
            ),
          ),
          RaisedButton(
            onPressed: _controller.text.isNotEmpty
                ? () {
                    setData(() => data.name = _controller.text);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Onboarding()),
                    );
                  }
                : null,
            child: Text("Jetzt loslegen!"),
          ),
        ],
      ),
    );
  }
}

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedColumn(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Text(
              "So funktioniert's:",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
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
                Text("Ich möchte am Morgen ans Eintragen erinnert werden"),
            value: data.dailyNotificationsEnabled,
            onChanged: (enabled) {
              setState(() {
                setData(() {
                  data.dailyNotificationsEnabled = enabled;
                });
              });
            },
          ),
          RaisedButton(
            onPressed: () async {
              Navigator.pop(context);
              await initializeNotifications(context);
              updateNotifications();
            },
            child: Text("Los geht's!"),
          )
        ],
      ),
    );
  }
}
