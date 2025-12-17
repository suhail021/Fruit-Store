// shein_webview.dart
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SheinWebView extends StatefulWidget {
  final String initialUrl;
  final void Function(InAppWebViewController) onWebViewCreated;
  final void Function(bool) onProductPageChanged;

  const SheinWebView({
    Key? key,
    required this.initialUrl,
    required this.onWebViewCreated,
    required this.onProductPageChanged,
  }) : super(key: key);

  @override
  State<SheinWebView> createState() => _SheinWebViewState();
}

class _SheinWebViewState extends State<SheinWebView> {
  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(widget.initialUrl)),
      onWebViewCreated: (controller) => widget.onWebViewCreated(controller),
      onLoadStop: (controller, url) async {
        // المهلة القصيرة حتى ينتهي تحميل أجزاء الـ DOM الديناميكية
        await Future.delayed(Duration(milliseconds: 500));

        // نتحقق إذا كان عنصر detail-view موجود — دلالة أن هذه صفحة منتج
        final hasDetail = await controller.evaluateJavascript(
          source: "document.getElementById('detail-view') != null;",
        );

        // بعض الحذف/إخفاء لعناصر الواجهة الأصلية لتوفير مساحة
        await controller.evaluateJavascript(
          source: """
            const hideByClass = (className) => {
              const el = document.querySelector('.' + className);
              if (el) el.style.display = 'none';
            };
            hideByClass('bsc-common-header__left');
            hideByClass('bsc-common-header__right');
            hideByClass('index-footer');
            hideByClass('j-index-footer');
          """,
        );

        final isProduct =
            hasDetail == true || hasDetail.toString().contains("true");
        widget.onProductPageChanged(isProduct);
      },
    );
  }
}
