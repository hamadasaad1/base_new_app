import 'package:attendance/data/network/bloc_observe.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'app/dit.dart';
import 'app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  if (kDebugMode) {
    // Disable app time stats in debug mode
    debugPrintGestureArenaDiagnostics = false;
  }
  await initAppModule();
  runApp(MyApp());

}
