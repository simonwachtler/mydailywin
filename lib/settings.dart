import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_auth/local_auth.dart';
import 'package:my_daily_win/notification_time.dart';
import 'package:persist_theme/ui/theme_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:file_picker/file_picker.dart';

import 'animations.dart';
import 'main.dart';
import 'data.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<bool> canCheckBiometrics;

  @override
  void initState() {
    canCheckBiometrics = LocalAuthentication().canCheckBiometrics;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DataModel>();
    return Scaffold(
      body: AnimatedColumn(
        children: [
          Row(
            key: ValueKey(0),
            children: [
              IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Spacer(),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
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
                          model.imageFilePath = (await ImagePicker()
                                  .getImage(source: ImageSource.gallery))
                              .path;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 33, left: 12, right: 12),
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {
                  showNameDialog(context);
                },
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(model.name,
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
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
            child: SwitchListTile.adaptive(
              title: Text(model.dailyNotificationsEnabled
                  ? "Aktiviert"
                  : "Deaktiviert"),
              subtitle: Text("Täglich ans Eintragen erinnern"),
              onChanged: (enabled) {
                model.dailyNotificationsEnabled = enabled;
                updateNotifications(
                  enabled,
                  model.notificationTime.toTime(),
                );
              },
              value: model.dailyNotificationsEnabled,
            ),
          ),
          AnimatedCrossFade(
            duration: Duration(milliseconds: 300),
            sizeCurve: Curves.ease,
            crossFadeState: model.dailyNotificationsEnabled
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Padding(
              padding: const EdgeInsets.only(left: 24, right: 12),
              child: NotificationTimeWidget(),
            ),
            secondChild: Container(),
          ),
          FutureBuilder(
            future: canCheckBiometrics,
            builder: (context, snapshot) => Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: SwitchListTile.adaptive(
                title: Text(
                  snapshot.hasData && snapshot.data
                      ? model.screenlockerEnabled
                          ? "Aktiviert"
                          : "Deaktiviert"
                      : "Nicht verfügbar",
                ),
                subtitle: Text("Biometrische Bildschirmsperre "),
                onChanged: snapshot.hasData && snapshot.data
                    ? (enabled) {
                        LocalAuthentication()
                            .authenticateWithBiometrics(
                                localizedReason:
                                    "Zum ${enabled ? "Aktivieren" : "Deaktivieren"} bestätigen")
                            .then((success) async {
                          if (success) {
                            model.screenlockerEnabled = enabled;
                          }
                        });
                      }
                    : null,
                value: model.screenlockerEnabled,
              ),
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
          ListTile(
              title: Text("Daten exportieren "),
              onTap: () async {
                Share.shareFiles([(await getDataFile()).path]);
              }),
          ListTile(
              title: Text("Daten importieren"),
              onTap: () async {
                FilePickerResult result = await FilePicker.platform.pickFiles();
                if (result != null) {
                  File file = File(result.files.single.path);

                  final previousImagePath = model.imageFilePath;
                  model.setData(
                      Data.fromJson(json.decode(await file.readAsString())));
                  model.imageFilePath = previousImagePath;
                  updateNotifications(model.dailyNotificationsEnabled,
                      model.notificationTime.toTime());
                }
              }),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Text(
                "ver 1\n© Debertol Michael & Wachtler Simon",
                textAlign: TextAlign.center,
              ),
            ),
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

const morningRoutineId = 1;
void updateNotifications(bool enabled, Time time) async {
  // if notifications are not yet initialized, do nothing
  // we will call this again when we have initialized
  if (flutterLocalNotificationsPlugin == null) return;
  if (enabled) {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'morning_routine', 'Tägliche Routine', 'Deine tägliche Routine',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      morningRoutineId,
      'Tägliche Routine',
      'Zeit für deine tägliche Routine!',
      time,
      platformChannelSpecifics,
    );
  } else {
    await flutterLocalNotificationsPlugin.cancel(morningRoutineId);
  }
}
