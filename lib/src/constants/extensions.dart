import 'package:flutter/material.dart';

extension Extensions on BuildContext {
  double responsiveHeight(double designHeight) {
    return (designHeight / 892) * MediaQuery.of(this).size.height;
  }

  double responsiveWidth(double designWidth) {
    return (designWidth / 412) * MediaQuery.of(this).size.width;
  }
}

extension ListSummation on List<num> {
  num listSummation() {
    num result = 0;
    for (int i = 0; i < length; i++) {
      result += this[i];
    }
    return result;
  }
}
