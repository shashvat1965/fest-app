import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oasis_2022/widgets/app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EpcBlog extends StatefulWidget {
  const EpcBlog({Key? key}) : super(key: key);

  @override
  State<EpcBlog> createState() => _EpcBlogState();
}

class _EpcBlogState extends State<EpcBlog> {
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
            title: "EPC BLOG",
            isactionButtonRequired: false,
            isBackButtonRequired: true),
      ),
      body: const WebView(
        initialUrl: "https://epcbits.com/",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
