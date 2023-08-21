import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';



class Singleton {
  static final Singleton _singleton = Singleton._internal();

  Singleton._privateConstructor();

  static final Singleton _instance = Singleton._privateConstructor();

  static Singleton get instance => _instance;

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();

  bool isTablet = false;

  String token = '';
 late PusherChannelsFlutter pusher;
  void handleCallApiForListenPusher({required String key}) async {
    switch (key) {}
  }

  bool getDeviceTabletMobile() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);

    return data.size.shortestSide >= 600;
  }


}
