import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oasis_2022/widgets/app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SponsorsScreen extends StatefulWidget {
  const SponsorsScreen({Key? key}) : super(key: key);

  @override
  State<SponsorsScreen> createState() => _SponsorsScreenState();
}

class _SponsorsScreenState extends State<SponsorsScreen> {
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
            title: "Sponsors",
            isactionButtonRequired: false,
            isBackButtonRequired: true),
      ),
      body: const WebView(
        initialUrl: "https://www.bits-oasis.org/sponsors",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
