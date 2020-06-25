import 'package:flutter/material.dart';
import 'package:my_daily_success/hall_of_fame.dart';
import 'package:my_daily_success/main.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:tuple/tuple.dart';
import 'package:supercharged/supercharged.dart';

import 'animations.dart';
import 'data.dart';
import 'new_success.dart';
import 'util.dart';

class Greeting extends StatelessWidget {
  const Greeting({
    Key key,
    this.switchToMutmacher,
  }) : super(key: key);

  final VoidCallback switchToMutmacher;

  @override
  Widget build(BuildContext context) {
    final lastEntries = _filterEntries(entries);
    return AnimatedListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(55.0),
          child: Text(
            name?.isNotEmpty == true ? 'Guten Tag, $name!' : 'Guten Tag!',
            style: TextStyle(
              fontSize: 38.0,
              fontFamily: 'Abadi',
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        GreetingBox(
          color: Colors.green,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "MORGEN-ROUTINE: ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text("Perfekt in den Tag starten!"),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => NewSuccess(
                      type: EntryType.Success,
                      morningRoutine: true,
                    )));
          },
        ),
        GreetingBox(
          color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "TÄGLICHE REFLEXION:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text("Positive Stimmung!"),
            ],
          ),
        ),
        GreetingBox(
          color: Colors.pink,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "SELBSTVERTRAUEN-BOOST:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text("Ja, ich schaffe es!"),
            ],
          ),
          onTap: switchToMutmacher,
        ),
        if (lastEntries != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: DayWidget(
              entries: lastEntries.item2,
              date: lastEntries.item1,
            ),
          ),
        SizedBox(
          height: 100,
        )
      ],
    );
  }

  Tuple2<DateTime, List<Entry>> _filterEntries(List<Entry> entries) {
    Tuple2<DateTime, List<Entry>> tuple;
    if (entries == null) return null;
    for (var entry in entries) {
      final date = toDate(entry.date);
      if (tuple?.item1?.isBefore(date) != false) {
        tuple = Tuple2(date, [entry]);
      } else if (tuple.item1.isAtSameMomentAs(date)) {
        tuple.item2.add(entry);
      }
    }
    return tuple;
  }
}

class GreetingBox extends StatelessWidget {
  const GreetingBox({
    Key key,
    @required this.color,
    @required this.child,
    this.onTap,
    this.delay,
  }) : super(key: key);

  final Color color;
  final Widget child;
  final VoidCallback onTap;
  final int delay;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 65.0, bottom: 8.0),
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 1000),
        opacity: 1,
        child: Material(
          elevation: 4,
          color: color.withAlpha(150),
          borderRadius: BorderRadius.horizontal(left: Radius.circular(8.0)),
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: child,
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}

enum _AniProps { opacity, translateX }

class FadeIn extends StatelessWidget {
  final int delay;
  final Widget child;

  FadeIn(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_AniProps>()
      ..add(_AniProps.opacity, 0.0.tweenTo(1.0))
      ..add(_AniProps.translateX, 30.0.tweenTo(0.0));

    return PlayAnimation<MultiTweenValues<_AniProps>>(
      delay: (25 * delay).milliseconds,
      duration: 350.milliseconds,
      tween: tween,
      child: child,
      curve: Curves.ease,
      builder: (context, child, value) => Opacity(
        opacity: value.get(_AniProps.opacity),
        child: Transform.translate(
          offset: Offset(value.get(_AniProps.translateX), 0),
          child: child,
        ),
      ),
    );
  }
}
