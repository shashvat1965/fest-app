import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oasis_2022/widgets/app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GeneralInformation extends StatefulWidget {
  const GeneralInformation({Key? key}) : super(key: key);

  @override
  State<GeneralInformation> createState() => _GeneralInformationState();
}

class _GeneralInformationState extends State<GeneralInformation> {
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
            title: "General Information",
            isactionButtonRequired: false,
            isBackButtonRequired: true),
      ),
      body: const WebView(
        initialUrl:
            "https://docs.google.com/document/d/1v9IAO-CeLMbZNK6w38ySMgDxBJB3FoiQP7xiglJt434/edit?usp=sharing",
        javascriptMode: JavascriptMode.disabled,
      ),
    );
  }
}
