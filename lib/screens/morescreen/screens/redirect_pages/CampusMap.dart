import 'dart:io';
import '/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CampusMap extends StatefulWidget {
  const CampusMap({Key? key}) : super(key: key);

  @override
  State<CampusMap> createState() => _CampusMapState();
}

class _CampusMapState extends State<CampusMap> {
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
            title: "Campus Map",
            isactionButtonRequired: false,
            isBackButtonRequired: true),
      ),
      body: const WebView(
        initialUrl: "https://docs.google.com/document/d/1UPBPLZYtHjFYnYyPxFV-jLQv5wBAAL4HS84cYpngjkg/edit?usp=sharing",
        javascriptMode: JavascriptMode.disabled,
      ),
    );
  }
}