
import 'package:flutter/material.dart';

class HallOfFame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            "Ich schaffe das",
            style: TextStyle(fontSize: 28.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 7, bottom: 15.0),
          child: Text(
            "Lorem ipsum.....",
            style: TextStyle(fontSize: 28.0),
          ),
        ),
        DayWidget(),
        DayWidget(),
        DayWidget(),
        DayWidget(),
        DayWidget(),
      ]),
    );
  }
}

class DayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: IntrinsicHeight(
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      "30",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
                Text("Samstag"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text("1. Lorem ipsum"),
                Text("1. Lorem ipsum"),
                Text("1. Lorem ipsum"),
                Text("1. Lorem ipsum"),
                Text("1. Lorem ipsum"),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
