import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(55.0),
            child: Text(
              'Guten Tag, Michael!',
              style: TextStyle(
                  fontSize: 38.0,
                  fontFamily: 'Abadi',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              print("isRecording");
            },
            child: Padding(
              padding: EdgeInsets.only(left: 65.0, top: 3.0),
              child: Container(
                decoration: new BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Text("MORGEN-ROUTINE: Perfekt in den Tag starten!"),
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
              padding: EdgeInsets.only(left: 65.0, top:  15.0,),
              child: Container(
                decoration: new BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Text("TÄGLICHE REFLEXION: Positive Stimmung!"),
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
              padding: EdgeInsets.only(left: 65.0, top:  18.0,),
              child: Container(
                decoration: new BoxDecoration(
                  color: Colors.pink[200],
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Text("SELBSTVERTRAUEN-BOOST: Ja, ich schaffe es!"),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.red,
            ),
            title: Text("Startseite"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.show_chart,
              color: Colors.grey,
            ),
            title: Text("Level"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.grade,
              color: Colors.grey,
            ),
            title: Text("Mutmacher"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              color: Colors.grey,
            ),
            title: Text("Profil"),
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.red,
        onTap: (_) {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        tooltip: "Hinzufügen",
      ),
    );
  }
}
