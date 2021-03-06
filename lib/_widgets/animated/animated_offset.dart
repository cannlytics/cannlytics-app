import 'package:flutter/material.dart';
import 'package:cannlytics_app/_widgets/alignments.dart';

class AnimatedOffset extends StatelessWidget {
  AnimatedOffset({
    @required this.child,
    @required this.duration,
    this.begin,
    @required this.end,
    this.curve = Curves.easeOut,
  });
  final Widget child;
  final Duration duration;
  final Offset begin;
  final Offset end;
  final Curve curve;

  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      duration: duration,
      curve: curve,
      tween: Tween(begin: begin ?? end, end: end),
      builder: (context, offset, _) => Transform.translate(
        offset: offset,
        child: TopLeft(child: child),
      ),
    );
  }
}
