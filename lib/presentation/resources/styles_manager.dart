import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:attendance/presentation/resources/color_manager.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontFamily: FontConstants.fontFamily,
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}

//regular style
TextStyle getRegularStyle({double ?fontSize , Color color = ColorManager.textColor}) {
  return _getTextStyle(fontSize?? FontSize.s16, FontWeightManager.regular, color);
}

//medium style
TextStyle getMediumStyle({double ?fontSize , Color color = ColorManager.textColor}) {
  return _getTextStyle(fontSize?? FontSize.s16, FontWeightManager.medium, color);
}

//light style
TextStyle getLightStyle({double ?fontSize, Color color = ColorManager.textColor}) {
  return _getTextStyle(fontSize?? FontSize.s16, FontWeightManager.light, color);
}

//bold style
TextStyle getBoldStyle({double ?fontSize, Color color = ColorManager.black}) {
  return _getTextStyle(fontSize?? FontSize.s16, FontWeightManager.bold, color);
}

//semiBold style
TextStyle getSemiBoldStyle({double ?fontSize, Color color = ColorManager.textColor}) {
  return _getTextStyle(fontSize?? FontSize.s16, FontWeightManager.semiBold, color);
}

//textField hint style
TextStyle getHintStyle({double ?fontSize, Color color = ColorManager.coolGray}) {
  return _getTextStyle(fontSize?? FontSize.s14, FontWeightManager.regular, color);
}

//textField error style
TextStyle getErrorTextStyle({double ?fontSize , Color color = ColorManager.error}) {
  return _getTextStyle(fontSize??FontSize.s15, FontWeightManager.regular, color);
}

//app bar text title style
TextStyle getAppBarTitleStyle({double? fontSize , Color color = ColorManager.black}) {
  return _getTextStyle(fontSize??FontSize.s20, FontWeightManager.bold, color);
}
