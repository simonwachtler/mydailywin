import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class AnimatedListView extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets padding;

  const AnimatedListView({Key key, this.children, this.padding})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: padding,
      children: [
        for (var i = 0; i < children.length; i++)
          FadeIn(i, children[i], children[i].key)
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
        for (var i = 0; i < children.length; i++)
          FadeIn(i, children[i], children[i].key)
      ],
    );
  }
}

enum _AniProps { opacity, translateX }

class FadeIn extends StatelessWidget {
  final int delay;
  final Widget child;
  final Key key;

  FadeIn(this.delay, this.child, this.key);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_AniProps>()
      ..add(_AniProps.opacity, 0.0.tweenTo(1.0))
      ..add(_AniProps.translateX, 30.0.tweenTo(0.0));

    return PlayAnimation<MultiTweenValues<_AniProps>>(
      key: key,
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
