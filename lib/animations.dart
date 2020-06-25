import 'package:flutter/material.dart';
import 'package:my_daily_success/greeting.dart';

class AnimatedListView extends StatelessWidget {
  final List<Widget> children;

  const AnimatedListView({Key key, this.children}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var i = 0; i < children.length; i++) FadeIn(i, children[i])
      ],
    );
  }
}

class AnimatedColumn extends StatelessWidget {
  final List<Widget> children;

  const AnimatedColumn({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < children.length; i++) FadeIn(i, children[i])
      ],
    );
  }
}
