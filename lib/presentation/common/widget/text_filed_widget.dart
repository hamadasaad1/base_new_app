import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:attendance/presentation/resources/color_manager.dart';
import 'package:attendance/presentation/resources/font_manager.dart';
import 'package:attendance/presentation/resources/manager_values.dart';
import 'package:attendance/presentation/resources/styles_manager.dart';
import 'package:attendance/presentation/resources/border_manager.dart';

import '../../resources/assets_manager.dart';
import 'custom_image_widget.dart';

class CustomTextFiled extends StatelessWidget {
  String hintText;
  Function? callback;
  bool isPassword;
  bool isDense;
  bool isSkipValidate;
  Function? showPassword;
  bool isPhoneKeyboard;
  bool? isClickable;
  bool isNumberKeyboard;
  TextEditingController? controller;
  Widget? suffixIcon;
  Color? color;
  TextInputType? textInputType;
  double fontSize;
  Widget? prefixIcon;
  bool isEmailKeyboard;
  int maxLines;
  int? charNumber;
  bool? isPIN;
  List<TextInputFormatter>? inputFormatters;
  bool isCardNumberField;
  AutovalidateMode? autovalidateMode;
  String? Function(String?)? validate;
  Function(String)? onChangedCallback;
  Function(String)? onSubmittedCallback;
  final TextStyle? textStyle;
   FocusNode? focusNode;
  CustomTextFiled({
    super.key,
    required this.hintText,
    this.callback,
    this.isPassword = false,
    this.isDense = true,
    this.isSkipValidate = false,
    this.showPassword,
    this.isPhoneKeyboard = false,
    this.isClickable,
    this.isNumberKeyboard = false,
    this.controller,
    this.suffixIcon,
    this.textStyle,
    this.inputFormatters,
    this.color,
    this.fontSize = 16,
    this.isEmailKeyboard = false,
    this.prefixIcon,
    this.maxLines = 1,
    this.autovalidateMode,
    this.validate,
    this.onChangedCallback,
    this.onSubmittedCallback,
    this.textInputType,
    this.charNumber,
    this.isCardNumberField = false,
    this.isPIN,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return textField();
  }

  TextFormField textField() {
    return TextFormField(
      enabled: isClickable,
      style:textStyle?? getRegularStyle(color: ColorManager.black),
      controller: controller,
      // autofocus: false,
      autovalidateMode: autovalidateMode,
      maxLines: maxLines,

      focusNode: focusNode,
      textAlignVertical: TextAlignVertical.center,
      maxLength: charNumber,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        counterText: "",
        disabledBorder: getRegularBorderStyle(),
        focusedBorder: getFocusedBorderStyle(),
        enabledBorder: getRegularBorderStyle(),
        errorBorder: getErroredBorderStyle(),
        focusedErrorBorder: getFocusedErroredBorderStyle(),
        errorStyle: getErrorTextStyle(fontSize: FontSize.s14),
        errorMaxLines: 3,
        hintStyle: getHintStyle(),
        hintText: hintText,
        fillColor: color ?? Colors.white,
        filled: true,
        suffixIcon: isPassword
            ? IconButton(
                icon: CustomSvgImage(
                    imageName: isDense
                        ? Assets.assetsSvgArrowBack
                        : Assets.assetsSvgArrowBack),
                onPressed: showPassword as void Function()?)
            : suffixIcon,
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppPadding.p14, horizontal: AppPadding.p8),
                child: prefixIcon,
              )
            : null,
      ),
      textInputAction: TextInputAction.done,
      keyboardType: textInputType ??
          (isEmailKeyboard
              ? TextInputType.emailAddress
              : isNumberKeyboard
                  ? const TextInputType.numberWithOptions(decimal: true)
                  : isPhoneKeyboard
                      ? TextInputType.phone
                      : TextInputType.text),
      obscureText: isPassword ? isDense : false,
      onSaved: (value) {
        if (callback != null) callback!(value);
      },
      onChanged: onChangedCallback,
      onFieldSubmitted: (value) {
        if (onSubmittedCallback != null) onSubmittedCallback!(value);
      },
      validator: validate ??
          (String? arg) {
            if (isSkipValidate) return null;

            if (isEmailKeyboard ||
                textInputType == TextInputType.emailAddress) {
              String p =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

              RegExp regExp = RegExp(p);
              if (!regExp.hasMatch(arg!)) {
                return 'Invalid Mail Format';
              }
            }

            if (arg!.trim().isEmpty || arg.trim().length < 3) {
              return hintText;
            } else {
              return null;
            }
          },
    );
  }
}
