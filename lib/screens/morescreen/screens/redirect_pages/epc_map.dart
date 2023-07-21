import 'dart:io';
import '/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EpcMap extends StatefulWidget {
  const EpcMap({Key? key}) : super(key: key);

  @override
  State<EpcMap> createState() => _EpcMapState();
}

class _EpcMapState extends State<EpcMap> {
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
            title: "Map",
            isactionButtonRequired: false,
            isBackButtonRequired: true),
      ),
      body: const WebView(
        initialUrl: "https://map.epcbits.com/",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
