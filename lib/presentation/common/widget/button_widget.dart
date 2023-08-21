import 'package:flutter/material.dart';
import 'package:attendance/presentation/resources/color_manager.dart';
import 'package:attendance/presentation/resources/font_manager.dart';
import 'package:attendance/presentation/resources/manager_values.dart';
import 'package:attendance/presentation/resources/styles_manager.dart';

class CustomButton extends StatelessWidget {
  final Function? onPress;
  final String labelText;
  final bool isFilledColor;
  final double? fontSize;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final Widget? rightIcon;
  final Widget? liftIcon;
  final double? radiusValue;

  CustomButton({
    Key? key,
    required this.onPress,
    required this.labelText,
    this.isFilledColor = true,
    this.fontSize,
    this.color,
    this.textColor,
    this.borderColor,
    this.rightIcon,
    this.liftIcon,
    this.radiusValue = AppSize.s8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return button();
  }

  Widget button() {
    return SizedBox(
      height: AppSize.s48,
      child: MaterialButton(
        disabledColor:isFilledColor? ColorManager.primarySold:null,
        onPressed: onPress as void Function()?,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusValue!),
          side: BorderSide(
            color: borderColor ??
                (isFilledColor
                    ? Colors.transparent
                    : ColorManager.textHeaderColor),
          ),
        ),
        color: isFilledColor
            ? color ?? (ColorManager.primary)
            : ColorManager.white,
        elevation: 0,
        //button size is between 50 to 65 according to the human ergonomics
        height: AppSize.s44,

        child: Center(
          child: rightIcon != null || liftIcon != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (liftIcon != null) ...[
                      liftIcon!,
                      const SizedBox(width: AppSize.s8),
                    ],
                    Text(labelText,
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                            color: textColor ??
                                (isFilledColor
                                    ? ColorManager.white
                                    : ColorManager.primary),
                            fontSize: fontSize ?? FontSize.s16)),
                    if (rightIcon != null) ...[
                      const SizedBox(width: AppSize.s8),
                      rightIcon!,
                    ],
                  ],
                )
              : Text(labelText,
                  textAlign: TextAlign.center,
                  style: getMediumStyle(
                      color: textColor ??
                          (isFilledColor
                              ? ColorManager.white
                              : ColorManager.textHeaderColor),
                      fontSize: fontSize ?? FontSize.s16)),
        ),
      ),
    );
  }
}
