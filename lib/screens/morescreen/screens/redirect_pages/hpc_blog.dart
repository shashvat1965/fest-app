import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oasis_2022/widgets/app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HpcBlog extends StatefulWidget {
  const HpcBlog({Key? key}) : super(key: key);

  @override
  State<HpcBlog> createState() => _HpcBlogState();
}

class _HpcBlogState extends State<HpcBlog> {
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
            title: "HPC BLOG",
            isactionButtonRequired: false,
            isBackButtonRequired: true),
      ),
      body: const WebView(
        initialUrl: "https://hindipressclub.wordpress.com",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
