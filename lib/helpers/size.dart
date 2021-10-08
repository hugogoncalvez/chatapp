import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;
  String? get route => ModalRoute.of(this)!.settings.name;
}

// SE DEBE IMPORTAR EN LOS ARCHIVOS DONDE SE QUIERA UTILIZAR
//  import 'package: NOMBRE DE LA APP/helpers/size.dart';

// UTILIZACION

//  height: context.height * 0.95, COMO EJEMPLO