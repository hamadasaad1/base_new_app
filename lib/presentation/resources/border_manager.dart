import 'package:flutter/material.dart';

import 'package:attendance/presentation/resources/color_manager.dart';
import 'package:attendance/presentation/resources/manager_values.dart';

OutlineInputBorder _getInputBorderStyle(double weight, Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppSize.s8),
    borderSide: BorderSide(
      color: color,
      width: weight,
    ),
  );
}

//regular style for text fields
OutlineInputBorder getRegularBorderStyle({double weight = 0.5, Color color = ColorManager.lightGrey}) {
  return _getInputBorderStyle(weight, color);
}

//regular style [For containers]
Border getRegularBorderContainerStyle({double weight = 0.5, Color color = ColorManager.lightGrey}) {
  return Border.all(width: weight, color: color);
}

//Focused style
OutlineInputBorder getFocusedBorderStyle({double weight = 0.5, Color color = ColorManager.coolGray}) {
  return _getInputBorderStyle(weight, color);
}

//error style
OutlineInputBorder getErroredBorderStyle({double weight = 1, Color color = Colors.red}) {
  return _getInputBorderStyle(weight, color);
}

//fouced error style
OutlineInputBorder getFocusedErroredBorderStyle({double weight = 1, Color color = Colors.red}) {
  return _getInputBorderStyle(weight, color);
}
