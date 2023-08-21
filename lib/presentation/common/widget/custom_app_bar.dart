import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:attendance/presentation/resources/assets_manager.dart';

import '../../resources/color_manager.dart';
import '../../resources/manager_values.dart';
import '../../resources/size_config.dart';
import '../../resources/styles_manager.dart';
import 'check_view_widget.dart';
import 'custom_image_widget.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool? canGoBack;
  final bool? isCenterTitle;
  final Function? onBackPress;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final Widget? leadingWidget;
  final double? height;
  CustomAppBar({
    Key? key,
    required this.title,
    this.canGoBack = true,
    this.isCenterTitle,
    this.onBackPress,
    this.backgroundColor,
    this.actions,
    this.leadingWidget,
    this.height,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size(
        size.width,
        height != null ? height!.h : 65,
      );
}

class _CustomAppBarState extends State<CustomAppBar> {
  DeviceScreenType deviceScreenType = DeviceScreenType.Mobile;
  void onChangeView(DeviceScreenType value) {
    deviceScreenType = value;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        onChangeView: onChangeView,
        smallScreen: AppBar(
          centerTitle: widget.isCenterTitle ?? false,
          automaticallyImplyLeading: widget.canGoBack ?? true,
          toolbarHeight: widget.height,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: ColorManager.white,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark),
          title: Text(
            widget.title,
            style: getAppBarTitleStyle(),
          ),
          leading: widget.canGoBack ?? true
              ? InkWell(
                  onTap: widget.onBackPress != null
                      ? widget.onBackPress as void Function()?
                      : () {
                          Navigator.pop(context);
                        },
                  child: widget.leadingWidget ??
                      Container(
                        width: 50,
                        height: 48,
                        margin: getMargin(
                            vertical: 10,
                            horizontal:
                                deviceScreenType == DeviceScreenType.Mobile
                                    ? AppPadding.p16.w
                                    : AppPadding.p16),
                        padding: getPadding(all: AppPadding.p8),
                        decoration: BoxDecoration(
                            color: ColorManager.appBarIconBackGroundColor,
                            borderRadius: BorderRadius.circular(AppSize.s8)),
                        child: CustomSvgImage(
                          // height: 50,
                          // width: 90,
                          imageName: Assets.assetsSvgArrowBack,
                        ),
                      ))
              : Container(
                  width: 20,
                ),
          elevation: 0,
          backgroundColor: ColorManager.white,
          leadingWidth: (widget.canGoBack ?? true)
              ? deviceScreenType == DeviceScreenType.Mobile
                  ? 75
                  : deviceScreenType == DeviceScreenType.Tablet
                      ? 80
                      : 80
              : 16,
          titleSpacing: 0,
          actions: widget.actions ?? [],
        ));
  }
}
