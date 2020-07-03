import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'animations.dart';
import 'main.dart';

class Level extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final level = calculateLevels(
      data.entries.fold(
        0,
        (value, entry) =>
            value +
            entry.success.length +
            entry.grateful.length +
            (entry.images?.fold(0, (value, entry) => value + entry.length) ??
                0),
      ),
    );
    return AnimatedListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 90),
          child: Center(
            child: Text(
              'Guten Tag, ${data.name}!',
              style: TextStyle(
                  fontSize: 29.0,
                  fontFamily: 'Abadi',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 70),
          child: PercentageWidget(percentage: level.item2),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Center(
            child: Text(
              level.item1 == 1
                  ? "Du befindest dich derzeit auf Level 1"
                  : "Glückwunsch, du hast Level ${level.item1} erreicht!",
            ),
          ),
        ),
        Center(
          child: Column(
            children: <Widget>[
              Text(
                "\n\nSo startest du durch:",
                style: TextStyle(fontSize: 26, fontFamily: "Abadi"),
              ),
              Text(
                "\nNotiere täglich deine Erfolge \nund du wirst schon bald das nächste \nLevel erreicht haben!",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
      ],
    );
  }
}

class PercentageWidget extends StatelessWidget {
  final double percentage;
  const PercentageWidget({
    Key key,
    this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        child: CustomPaint(
          painter: PercentageArc(
              Theme.of(context).scaffoldBackgroundColor, percentage),
          child: Center(
            child: Text(
              "${(percentage * 100).toInt()} %",
              style: TextStyle(
                fontSize: 45,
                fontFamily: 'Abadi',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PercentageArc extends CustomPainter {
  final Color backgroundColor;
  final double percentage;

  PercentageArc(this.backgroundColor, this.percentage);
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawArc(
      rect,
      pi * 3 / 4,
      pi * 3 / 2,
      true,
      Paint()..color = Colors.grey.withAlpha(100),
    );
    canvas.drawArc(
      rect,
      pi * 3 / 4,
      (pi * 3 / 2) * percentage,
      true,
      Paint()..color = Colors.indigo,
    );
    canvas.drawCircle(
        rect.center, size.height / 2 - 10, Paint()..color = backgroundColor);
  }

  @override
  bool shouldRepaint(PercentageArc oldDelegate) {
    return oldDelegate.percentage != percentage;
  }
}

Tuple2<int, double> calculateLevels(int entries, {int previousLevel = 0}) {
  var neededEntries = 10 * previousLevel;

  if (entries < neededEntries) {
    final percentage = entries / neededEntries;
    return Tuple2(previousLevel, percentage);
  } else {
    entries -= neededEntries;
    return calculateLevels(entries, previousLevel: previousLevel + 1);
  }
}
