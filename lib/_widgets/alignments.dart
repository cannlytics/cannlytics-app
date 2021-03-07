import 'package:flutter/material.dart';

Widget _build(Alignment value, Widget child) =>
    Align(alignment: value, child: child);

/// TOPS
class TopLeft extends StatelessWidget {
  const TopLeft({required Key key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => _build(Alignment.topLeft, child);
}

class TopRight extends StatelessWidget {
  const TopRight({required Key key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => _build(Alignment.topRight, child);
}

class TopCenter extends StatelessWidget {
  const TopCenter({required Key key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => _build(Alignment.topCenter, child);
}

/// CENTERS
class CenterLeft extends StatelessWidget {
  const CenterLeft({required Key key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => _build(Alignment.centerLeft, child);
}

class CenterRight extends StatelessWidget {
  const CenterRight({required Key key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => _build(Alignment.centerRight, child);
}

/// BOTTOMS
class BottomLeft extends StatelessWidget {
  const BottomLeft({required Key key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => _build(Alignment.bottomLeft, child);
}

class BottomRight extends StatelessWidget {
  const BottomRight({required Key key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => _build(Alignment.bottomRight, child);
}

class BottomCenter extends StatelessWidget {
  const BottomCenter({required Key key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => _build(Alignment.bottomCenter, child);
}
