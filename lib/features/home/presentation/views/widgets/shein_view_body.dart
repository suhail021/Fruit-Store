// shein_view_body.dart
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:myapp/core/utils/app_colors.dart';
import 'package:myapp/features/home/presentation/views/widgets/custom_home_appbar.dart';
import 'shein_top_bar.dart';
import 'shein_webview.dart';
import 'product_fab.dart';

class SheinViewBody extends StatefulWidget {
  const SheinViewBody({Key? key}) : super(key: key);

  @override
  State<SheinViewBody> createState() => _SheinViewBodyState();
}

class _SheinViewBodyState extends State<SheinViewBody> {
  late InAppWebViewController webViewController;
  bool isProductPage = false;

  // Setter helper to avoid setState duplication
  void _setIsProductPage(bool v) {
    if (mounted) setState(() => isProductPage = v);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // أعلى الصفحة: شريط ملوّن يحتوي على عنوان + أزرار تحكم (refresh / back / forward)
        SheinTopBar(
          onRefresh: () => webViewController.reload(),
          onBack: () => webViewController.goBack(),
          onForward: () => webViewController.goForward(),
        ),

        // محتوى الصفحة: WebView مع الـ CustomHomeAppbar كـ overlay
        Expanded(
          child: Stack(
            children: [
              CustomHomeAppbar(),
              SheinWebView(
                initialUrl: "https://m.shein.com/ar/",
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onProductPageChanged: _setIsProductPage,
              ),
              // زر الإضافة يظهر فقط على صفحة المنتج
              if (isProductPage)
                ProductFAB(webViewController: webViewController),
            ],
          ),
        ),
      ],
    );
  }
}
