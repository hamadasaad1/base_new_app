import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:attendance/presentation/common/widget/custom_image_widget.dart';
import 'package:attendance/presentation/resources/assets_manager.dart';
import 'package:attendance/presentation/resources/color_manager.dart';
import 'package:attendance/presentation/resources/manager_values.dart';
import 'package:attendance/presentation/resources/styles_manager.dart';

class CustomEmptyWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final String? imageName;
  final Widget? widget;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  const CustomEmptyWidget({
    Key? key,
    this.title,
    this.message,
    this.imageName,
    this.titleStyle,
    this.messageStyle,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity),
        widget ??
            CustomSvgImage(
              imageName: imageName ?? Assets.assetsSvgArrowBack,
              color: ColorManager.editColor,
              width: AppSize.s60.w,
            ),
        if (title != null) ...[
          const SizedBox(
            height: AppSize.s8,
          ),
          Text(
            title ?? '',
            style: titleStyle ?? getBoldStyle(),
          ),
        ],
        if (message != null) ...[
          const SizedBox(
            height: AppSize.s8,
          ),
          Text(
            message ?? '',
            textAlign: TextAlign.center,
            style: messageStyle ?? getRegularStyle(),
          ),
        ],
      ],
    );
  }
}
