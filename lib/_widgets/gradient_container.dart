import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer(this.colors, this.stops,
      {required Key key,
      required this.child,
      this.width = 0,
      this.height = 0,
      this.alignment = Alignment.topLeft,
      this.begin = Alignment.topRight,
      this.end = Alignment.bottomLeft})
      : super(key: key);

  final double width;
  final double height;
  final Widget child;
  final List<Color> colors;
  final List<double> stops;
  final Alignment begin;
  final Alignment end;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) => Container(
        child: child,
        width: width,
        height: height,
        alignment: alignment ?? null,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin ?? Alignment.centerLeft,
            end: end ?? Alignment.centerRight,
            colors: colors,
            stops: stops,
          ),
        ),
      );
}

class HzGradient extends StatelessWidget {
  const HzGradient(
    this.colors,
    this.stops, {
    required Key key,
    required this.child,
    this.width = 0,
    this.height = 0,
    this.alignment = Alignment.topLeft,
  }) : super(key: key);

  final List<Color> colors;
  final List<double> stops;
  final double width;
  final double height;
  final Alignment alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) => GradientContainer(
        colors,
        stops,
        key: GlobalKey(),
        width: width,
        height: height,
        alignment: alignment,
        child: child,
      );
}

class VtGradient extends StatelessWidget {
  const VtGradient(
    this.colors,
    this.stops, {
    required Key key,
    required this.child,
    this.width = 0,
    this.height = 0,
    this.alignment = Alignment.topLeft,
  }) : super(key: key);
  final List<Color> colors;
  final List<double> stops;
  final double width;
  final double height;
  final Alignment alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) => GradientContainer(
        colors,
        stops,
        key: GlobalKey(),
        width: width,
        height: height,
        alignment: alignment,
        child: child,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
}
