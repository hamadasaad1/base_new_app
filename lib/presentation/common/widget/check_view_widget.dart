import 'package:flutter/material.dart';
import 'package:attendance/app/singlton.dart';

class OrientationDetectorWidget extends StatefulWidget {
  final Widget mobileWidget;
  final Widget? tabletWidget;
  final Function? onChangeView;

  const OrientationDetectorWidget(
      {Key? key,
      required this.mobileWidget,
      this.tabletWidget,
      this.onChangeView})
      : super(key: key);

  @override
  _OrientationDetectorWidgetState createState() =>
      _OrientationDetectorWidgetState();
}

class _OrientationDetectorWidgetState extends State<OrientationDetectorWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  SizeConfig().init(context);
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.landscape &&
            widget.onChangeView != null) {
          widget.onChangeView!(true);
        }
        if (orientation == Orientation.landscape ||
            Singleton().getDeviceTabletMobile()) {
          return widget.tabletWidget ?? widget.mobileWidget;
        } else {
          return widget.mobileWidget;
        }
      },
    );
  }
}

enum DeviceScreenType { Mobile, Tablet, Desktop }

class ResponsiveWidget extends StatefulWidget {
  final Widget? largeScreen;
  final Widget? mediumScreen;
  final Widget smallScreen;

  final Function(DeviceScreenType)? onChangeView;

  const ResponsiveWidget(
      {this.largeScreen,
      this.mediumScreen,
      required this.smallScreen,
      this.onChangeView});

  static DeviceScreenType getDeviceType(Size size,Orientation orientation) {
    

    double deviceWidth = 0;

    if (orientation == Orientation.landscape) {
      deviceWidth = size.height;
    } else {
      deviceWidth = size.width;
    }
    deviceWidth = size.width;

    if (deviceWidth > 950) {
      return DeviceScreenType.Desktop;
    }

    if (deviceWidth >= 600) {
      return DeviceScreenType.Tablet;
    }

    return DeviceScreenType.Mobile;
  }

  @override
  State<ResponsiveWidget> createState() => _ResponsiveWidgetState();
}

class _ResponsiveWidgetState extends State<ResponsiveWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var orientation = MediaQuery.orientationOf(context);
      var size = MediaQuery.sizeOf(context);
      var deviceType = ResponsiveWidget.getDeviceType(size,orientation);

      if (widget.onChangeView != null) {
        if (orientation == Orientation.landscape) {
          widget.onChangeView!(deviceType);
        } else {
          widget.onChangeView!(deviceType);
        }
      }

      if (deviceType == DeviceScreenType.Desktop) {
        return widget.largeScreen ?? widget.mediumScreen ?? widget.smallScreen;
      } else if (deviceType == DeviceScreenType.Tablet) {
        if (orientation == Orientation.landscape) {
          return widget.mediumScreen ??
              widget.largeScreen ??
              widget.smallScreen;
        } else {
          return widget.mediumScreen ?? widget.smallScreen;
        }
      } else {
        if (orientation == Orientation.landscape) {
          return widget.mediumScreen ?? widget.smallScreen;
        } else {
          return widget.smallScreen;
        }
      }
    });
  }
}
