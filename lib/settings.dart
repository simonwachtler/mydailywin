import 'dart:io';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:my_daily_success/animations.dart';
import 'package:my_daily_success/screenlocker.dart';
import 'package:persist_theme/ui/theme_widgets.dart';
import 'package:image_picker/image_picker.dart';

import 'main.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool screenlockEnabled = false;
  @override
  void initState() {
    super.initState();
    isScreenlockerEnabled()
        .then((isEnabled) => setState(() => screenlockEnabled = isEnabled));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedListView(
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
                        padding: const EdgeInsets.only(
                            right: 50, bottom: 50, left: 20, top: 20),
                        child: IconButton(
                          icon: Icon(Icons.camera_alt,
                              color: Colors.white, size: 75),
                          onPressed: () async {
                            imageFile = File((await ImagePicker()
                                    .getImage(source: ImageSource.gallery))
                                .path);
                          },
                        )),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(name,
                        style: Theme.of(context).textTheme.headline4),
                  ),
                  Spacer(),
                  Icon(
                    Icons.person,
                    size: 70,
                    color: Colors.grey.shade300,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
            child: SwitchListTile.adaptive(
              title: Text(screenlockEnabled ? "Aktiviert" : "Deaktiviert"),
              subtitle: Text("Biometrische Bildschirmsperre "),
              onChanged: (enabled) {
                LocalAuthentication()
                    .authenticateWithBiometrics(
                        localizedReason:
                            "Zum ${enabled ? "Aktivieren" : "Deaktivieren"} bestätigen")
                    .then((success) async {
                  if (success) {
                    getScreenlockFile().then((file) {
                      if (enabled) {
                        file.create();
                      } else {
                        file.delete();
                      }
                      setState(() {
                        screenlockEnabled = enabled;
                      });
                    });
                  }
                });
              },
              value: screenlockEnabled,
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
          ),
          AboutListTile(
            child: Center(
              child: Text("Über My Daily Win!"),
            ),
            applicationName: "My Daily Win!",
            applicationLegalese: """Impressum
Wachtler Simon und Debertol Michael
Köstlanerstraße 33/B
39042 Brixen
+39 345 8792946
simon.wachtler@gmail.com


Streitbeilegung
Pflichtinformation nach EU-Verordnung Nr. 524/2013 des Europäischen Parlaments und Rats Plattform zur Online-Beilegung verbraucherrechtlicher Streitigkeiten (ODR) der Europäischen Kommission: http://ec.europa.eu/consumers/odr/

Verantwortlich für Konzeption & Gestaltung / Umsetzung
Debertol Michael und Wachtler Simon
Köstlanerstraße 33/B
39049 Brixen (BZ)
Tel. +39 345 8792946
simon.wachtler@gmail.com

Verantwortlich für den Inhalt:
Wachtler Simon und Debertol Michael

Haftungsausschluss:
Haftung für Inhalte
Die Inhalte unserer Seiten wurden mit größter Sorgfalt erstellt, bearbeitet und überprüft. 
Für die Richtigkeit, Qualität, Vollständigkeit und Aktualität der Inhalte können wir jedoch keine Gewähr übernehmen, auch da möglicherweise in der Zwischenzeit Änderungen eingetreten sein könnten. 
Haftungsansprüche jeglicher Natur, welche durch die Nutzung der bereitgestellten Informationen oder durch fehlende und/oder unvollständige Informationen verursacht wurden, sind grundsätzlich ausgeschlossen.

Haftung für Links
Unser Angebot enthält Links zu externen Webseiten Dritter, auf deren Inhalte wir keinen Einfluss nehmen können. Aus diesem Grund können wir in Bezug auf die Inhalte der verlinkten Webseiten auch keine Gewähr, welcher Natur auch immer, übernehmen. Für die Inhalte der verlinkten Seiten ist ausschließlich der jeweilige Anbieter oder Betreiber dieser Seiten verantwortlich. 

Urheberrecht
Sämtliche durch Debertol Michael und Wachtler Simon erstellten Inhalte und Werke auf dieser Webseite sind urheberrechtlich geschützt. 
Die Vervielfältigung, Bearbeitung, Verbreitung und jegliche Art der Verwertung, insbesondere kommerzieller Natur, außerhalb der Grenzen des Urheberrechtes sind strikt untersagt und bedürfen jedenfalls der vorherigen schriftlichen Zustimmung des jeweiligen Autors bzw. Erstellers. 
Soweit die Inhalte auf dieser Seite nicht vom Betreiber erstellt wurden, werden die Urheberrechte Dritter beachtet. 
Insbesondere werden Inhalte Dritter als solche gekennzeichnet. 
Sollten Sie trotzdem auf eine Urheberrechtsverletzung aufmerksam werden, bitten wir um einen entsprechenden Hinweis. 
Bei Bekanntwerden von Rechtsverletzungen solcher Natur werden wir derartige Inhalte natürlich umgehend entfernen, übernehmen diesbezüglich jedoch keinerlei Haftung.

Debertol Michael & Wachtler Simon
 """,
          )
        ],
      ),
    );
  }
}
