import 'package:flutter/material.dart';

Widget _build(Alignment value, Widget child) => Align(alignment: value, child: child);

/// TOPS
class TopLeft extends StatelessWidget {
  const TopLeft({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => _build(Alignment.topLeft, child);
}

class TopRight extends StatelessWidget {
  const TopRight({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => _build(Alignment.topRight, child);
}

class TopCenter extends StatelessWidget {
  const TopCenter({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => _build(Alignment.topCenter, child);
}

/// CENTERS
class CenterLeft extends StatelessWidget {
  const CenterLeft({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => _build(Alignment.centerLeft, child);
}

class CenterRight extends StatelessWidget {
  const CenterRight({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => _build(Alignment.centerRight, child);
}

/// BOTTOMS
class BottomLeft extends StatelessWidget {
  const BottomLeft({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => _build(Alignment.bottomLeft, child);
}

class BottomRight extends StatelessWidget {
  const BottomRight({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => _build(Alignment.bottomRight, child);
}

class BottomCenter extends StatelessWidget {
  const BottomCenter({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => _build(Alignment.bottomCenter, child);
}
