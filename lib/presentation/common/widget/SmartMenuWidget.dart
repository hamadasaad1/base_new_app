import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:attendance/presentation/common/widget/check_view_widget.dart';

import 'IconWithContainer.dart';

void buildSmartMenuWidget({
  Alignment? alignment,
  required Widget menuContent,
  required double widthRatio,
  DeviceScreenType deviceScreenType = DeviceScreenType.Mobile,
}) {
  SmartDialog.show(
    alignment: alignment ?? Alignment.centerRight,
    backDismiss: true,
    builder: (_) => SizedBox(
      width: deviceScreenType == DeviceScreenType.Mobile
          ? ScreenUtil().screenWidth * .9
          : deviceScreenType == DeviceScreenType.Tablet
              ? ScreenUtil().screenWidth * .5
              : ScreenUtil().screenWidth * .35,
      child: Scaffold(
        
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconWithContainer(
               
                icon: Icons.close,
                btnFunc: () => SmartDialog.dismiss(),
              ),
              Expanded(child: menuContent),
            ],
          ),
        ),
      ),
    ),
  );
}
