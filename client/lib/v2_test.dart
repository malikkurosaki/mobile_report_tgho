import 'package:easy_web_view2/easy_web_view2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';


class V2Test extends StatelessWidget {
  const V2Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fwfh_webview',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WebViewFactory Demo'),
        ),
        body: EasyWebView(
  src: "http://172.16.40.2/loginWaiter",
  isHtml: false, // Use Html syntax
  isMarkdown: false, // Use markdown syntax
  convertToWidgets: false, onLoaded: () {  }, // Try to convert to flutter widgets
  // width: 100,
  // height: 100,
),
      ),
    );
  }
}

class MyWidgetFactory extends WidgetFactory with WebViewFactory {}