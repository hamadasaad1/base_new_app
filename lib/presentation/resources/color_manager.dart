import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ColorManager {
  static const Color primary = Color(0xffD14663);
  static const Color primaryLinear = Color(0xffA7384F);
  static const Color primarySold = Color(0xffF1C6CF);
  static const Color primaryLight = Color(0xffFAEDEF);
  static const Color background = Color(0xffF5F6FA);
  static const Color editColor = Color(0xff006FDE);
  static const Color blueColor = Color(0xff007BC2);
  static const Color redColor = Color(0xffFF0000);
  static const Color redLight = Color(0xffFFE6E6);
  static Color lightPrimary = const Color(0xcc332c6a); //this change opcity with 80% look this link https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4
  static Color darkGrey = const Color(0xffdddbdd);
  static Color purpleColor = const Color(0xffAC4BC2);
  static const Color grey = Color(0xff737477);
  static const Color greyLightHover = Color(0xffEFF1F3);
  static const Color greySold = Color(0xffDEE2E7);
  static const Color greenLight = Color(0xffE6FAEE);
  static Color green = const Color(0xff00C853);
  static const Color lightGrey = Color(0xffd6d6d6);
  static const Color coolGray = Color(0xff93A3B0);
   static const Color appBarIconBackGroundColor = Color(0x3D93A3B0);
  static Color pinCodeColor = const Color(0xffefeff3);
  static const Color gray80 = Color.fromRGBO(147, 163, 176, 0.8);
  static const Color gray16 = Color.fromRGBO(147, 163, 176, 0.16);
  static const Color error = Color(0xffff0000);
  static const Color forgetBtColor = Color(0xffFF3748);
  //Button status colors
  static const Color warning = Color(0xffEF314E);
  static const Color missing = Color(0xffFFC559);
  static const Color yellow = Color(0xffFFCC00);
  static const Color blueButton = Color(0xff007BC2);
  static const Color success = Color(0xff41C19F);
  static const Color white = Color(0xffFFFFFF);
  static Color dimWhite = const Color(0xffF5F6FA);
  static const Color black =  Color(0xff000000);
  static const Color blackCool =  Color(0xff33393E);
  //App Bar titles and screen main titles
  static const Color textHeaderColor = Color(0xff1E1E1E);
  //Regular text color
  static const Color textColor = Color(0xff3F4440);
  static const Color textSubTitleColor = Color(0xffa3a3a3);
  //temp gradient color
  static LinearGradient cardGradient1 = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      ColorManager.gray80,
      ColorManager.textHeaderColor,
      ColorManager.textSubTitleColor,
    ],
  );
}
