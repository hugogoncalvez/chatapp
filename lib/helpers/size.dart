import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;
  String? get route => ModalRoute.of(this)!.settings.name;
}


//  import 'package:chatapp/helpers/size.dart';