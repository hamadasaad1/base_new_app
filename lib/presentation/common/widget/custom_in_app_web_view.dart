import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:attendance/presentation/resources/color_manager.dart';
import 'package:attendance/presentation/resources/size_config.dart';

import '../../../app/singlton.dart';
import '../state_renderer/state_renderer.dart';
import 'component.dart';
import 'custom_app_bar.dart';

class CustomInAppWebView extends StatefulWidget {
  final String url;

  const CustomInAppWebView({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<CustomInAppWebView> createState() => _CustomInAppWebViewState();
}

class _CustomInAppWebViewState extends State<CustomInAppWebView> {
  InAppWebViewController? _webViewController;

  Uri? url;

  Map<String, String> headers = {
    "Authorization": "Bearer ${Singleton().token}"
  };
  initWebView() async {
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

      var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
          AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
      var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
          AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

      if (swAvailable && swInterceptAvailable) {
        AndroidServiceWorkerController serviceWorkerController =
            AndroidServiceWorkerController.instance();

        await serviceWorkerController
            .setServiceWorkerClient(AndroidServiceWorkerClient(
          shouldInterceptRequest: (request) async {
            return null;
          },
        ));
      }
    }
  }

/* https://dev.reservation.stagingserver.io/dashboard/floor/areaDetails/11/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FwaS5yZXNlcnZhdGlvbi5zdGFnaW5nc2VydmVyLmlvL2FwaS9hZG1pbi9hdXRoL2xvZ2luIiwiaWF0IjoxNjg0NzUwNTIwLCJleHAiOjE2ODQ3NTQxMjAsIm5iZiI6MTY4NDc1MDUyMCwianRpIjoiWnhkTHdHdkdsYW4xakE0eCIsInN1YiI6IjIzMiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.SgU257EnZ_z1Qxmq7Wt_E-fAXo9gUNZDds9idAmJ3bo */
  @override
  void initState() {
    url = Uri.parse(widget.url);

    // url = Uri.parse(
    //     'https://dev.reservation.stagingserver.io/floor/${Singleton().defaultRestaurant?.id??0}/11/${Singleton().token}');

    log(url.toString());

    initWebView();
    showLoading();
    super.initState();
  }

  void showLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showPopupDialog(
          context: context,
          stateRendererType: StateRendererType.popupLoadingState);
    });
  }

  Future<bool> _willPopCallback() async {
    bool canNavigate = await _webViewController!.canGoBack();
    if (canNavigate) {
      _webViewController!.goBack();
      return false;
    } else {
      return true;
    }
  }

  bool isChanged = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _willPopCallback,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: ColorManager.background,
          appBar: CustomAppBar(
              title: 'Floor',
              onBackPress: () {
                Navigator.pop(context, isChanged);
              }),
          body: SafeArea(
            top: false,
            child: Padding(
              padding: getPadding(isContent: false, all: 0),
              child: InAppWebView(
                onUpdateVisitedHistory: (controller, url, androidIsReload) {},
                initialUrlRequest: URLRequest(url: url),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                      javaScriptEnabled: true,
                      javaScriptCanOpenWindowsAutomatically: true,
                      useOnDownloadStart: true,
                      verticalScrollBarEnabled: true),
                  android: AndroidInAppWebViewOptions(
                      domStorageEnabled: true,
                      databaseEnabled: true,
                      useHybridComposition: true,
                      clearSessionCache: true,
                      geolocationEnabled: true,
                      thirdPartyCookiesEnabled: true,
                      allowFileAccess: true,
                      allowContentAccess: true),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                },
                onLoadStart: (controller, url) {},
                onLoadStop: (controller, url) {
                  dismissDialog(context);
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    isChanged = true;
                  });
                },
                androidOnPermissionRequest: (InAppWebViewController controller,
                    String origin, List<String> resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
                androidOnGeolocationPermissionsShowPrompt:
                    (InAppWebViewController controller, String origin) async {
                  bool? result = await showDialog<bool>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Allow access location '),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Allow access location $origin'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Allow'),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                          ),
                          TextButton(
                            child: const Text('Denied'),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                        ],
                      );
                    },
                  );
                  if (result!) {
                    return Future.value(GeolocationPermissionShowPromptResponse(
                        origin: origin, allow: true, retain: true));
                  } else {
                    return Future.value(GeolocationPermissionShowPromptResponse(
                        origin: origin, allow: false, retain: false));
                  }
                },
              ),
            ),
          ),
        ));
  }
}
