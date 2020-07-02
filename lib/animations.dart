import 'dart:math';

import 'package:flutter/material.dart';

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
          FadeIn(min(i, 15), children[i], children[i].key)
      ],
    );
  }
}

class AnimatedColumn extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;

  const AnimatedColumn(
      {Key key, this.children, this.mainAxisAlignment, this.crossAxisAlignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        for (var i = 0; i < children.length; i++)
          FadeIn(i, children[i], children[i].key)
      ],
    );
  }
}

class FadeIn extends StatefulWidget {
  final int delay;
  final Widget child;
  final Key key;
  final bool alwaysKeepAlive;

  FadeIn(this.delay, this.child, this.key, {this.alwaysKeepAlive = true});

  @override
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController _controller;
  Animation _opacity, _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );
    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    _offset = Tween<double>(begin: 30, end: 0).animate(curvedAnimation);
    Future.delayed(
      Duration(milliseconds: 30 * widget.delay),
    ).then(
      (_) => _controller.forward(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FadeTransition(
      opacity: _opacity,
      child: AnimatedBuilder(
        animation: _controller,
        child: widget.child,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              _offset.value,
              0,
            ),
            child: child,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.alwaysKeepAlive;
}
