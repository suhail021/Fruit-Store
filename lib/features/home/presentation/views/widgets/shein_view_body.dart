// shein_view_body.dart
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/home/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:myapp/features/home/presentation/views/widgets/custom_home_appbar.dart';
import 'shein_top_bar.dart';
import 'shein_webview.dart';
import 'product_fab.dart';

class SheinViewBody extends StatefulWidget {
  final String? initialUrl;
  const SheinViewBody({Key? key, this.initialUrl}) : super(key: key);

  @override
  State<SheinViewBody> createState() => _SheinViewBodyState();
}

class _SheinViewBodyState extends State<SheinViewBody> {
  late InAppWebViewController webViewController;
  bool isProductPage = false;
  bool isControllerReady = false;
  String? _pendingUrl;

  // Setter helper to avoid setState duplication
  void _setIsProductPage(bool v) {
    if (mounted) setState(() => isProductPage = v);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.currentIndex == 2 && state.sheinUrl != null) {
          if (isControllerReady) {
            webViewController.loadUrl(
              urlRequest: URLRequest(url: WebUri(state.sheinUrl!)),
            );
          } else {
            _pendingUrl = state.sheinUrl;
          }
        }
      },
      child: Column(
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
                  initialUrl: widget.initialUrl ?? "https://m.shein.com/ar/",
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                    isControllerReady = true;
                    if (_pendingUrl != null) {
                      webViewController.loadUrl(
                        urlRequest: URLRequest(url: WebUri(_pendingUrl!)),
                      );
                      _pendingUrl = null;
                    }
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
      ),
    );
  }
}
