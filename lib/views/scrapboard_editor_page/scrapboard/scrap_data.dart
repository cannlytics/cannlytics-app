import 'package:flutter/material.dart';
import 'package:cannlytics_app/_utils/easy_notifier.dart';

class ScrapData<T> extends EasyNotifier {
  ScrapData(this.data, {required this.aspect});

  Offset _offset = Offset.zero;
  Offset get offset => _offset;
  set offset(Offset value) => notify(() => _offset = value);

  Size _size = Size(100, 100);
  Size get size => _size;
  set size(Size value) => notify(() => _size = value);

  // double _scale = 1;
  // double get scale => _scale;
  // set scale(double value) => notify(() => _scale = value);

  double _rot = 1;
  double get rot => _rot;
  set rot(double value) => notify(() => _rot = value);

  double aspect;
  T data;
}
