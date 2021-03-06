import 'package:flutter/material.dart';

class ScreenSize {
  final BuildContext context;
  final int _smallScreenW = 1500;
  final int _smallScreenH = 900;
  bool get smallSize => _small();

  ScreenSize(this.context);

  bool _small() {
    return (MediaQuery.of(context).size.width < _smallScreenW &&
        MediaQuery.of(context).size.height < _smallScreenH);
  }
}
