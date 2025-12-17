import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:myapp/core/entities/product_entity.dart';
import 'package:myapp/features/home/presentation/cubits/cart_cubit/cart_cubit.dart';

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
  InAppWebViewController? webViewController;
  bool isProductPage = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        final controller = webViewController;
        if (controller != null) {
          if (await controller.canGoBack()) {
            controller.goBack();
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(widget.initialUrl)),

                onWebViewCreated: (controller) {
                  webViewController = controller;
                  widget.onWebViewCreated(controller);
                },

                onLoadStart: (controller, url) async {},

                onLoadStop: (controller, url) async {
                  final hasDetail = await controller?.evaluateJavascript(
                    source:
                        "document.getElementById('detail-view') != null || document.querySelector('.goods-detail-top') != null;",
                  );
                  final newIsProduct =
                      (hasDetail == true) ||
                      hasDetail.toString().toLowerCase().contains("true");

                  if (newIsProduct != isProductPage) {
                    setState(() {
                      isProductPage = newIsProduct;
                    });
                    widget.onProductPageChanged(newIsProduct);
                  }

                  await controller?.evaluateJavascript(
                    source: '''
                    (function(){
                      if (!document.getElementById('fast-hide-style')) {
                        var s = document.createElement('style');
                        s.id = 'fast-hide-style';
                        s.type = 'text/css';
                        s.appendChild(document.createTextNode(`
                          .product-intro__add-cart,
                          .product-intro__add-cart *,
                          .bsc-common-header__left,
                          .bsc-common-header__right,
                          .journey-content,
                          .journey-content_ar,
                          .index-footer,
                          .j-index-footer,
                          .bsc-header-cart,
                          .bsc-wish-icon-wrap,
                          .add-cart__animation-normal {
                            display: none !important;
                            visibility: hidden !important;
                            opacity: 0 !important;
                            pointer-events: none !important;
                          }
                        `));
                        (document.head || document.documentElement).appendChild(s);
                      }
                    })();
                  ''',
                  );
                },

                onUpdateVisitedHistory: (
                  controller,
                  url,
                  androidIsReload,
                ) async {
                  final hasDetail = await controller?.evaluateJavascript(
                    source:
                        "document.getElementById('detail-view') != null || document.querySelector('.goods-detail-top') != null;",
                  );
                  final newIsProduct =
                      (hasDetail == true) ||
                      hasDetail.toString().toLowerCase().contains("true");
                  if (newIsProduct != isProductPage) {
                    setState(() {
                      isProductPage = newIsProduct;
                    });
                    widget.onProductPageChanged(newIsProduct);
                  }
                },

                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  final uri = navigationAction.request.url?.toString() ?? '';
                  final maybeProduct =
                      uri.contains('/p/') ||
                      uri.toLowerCase().contains('goodsdetail') ||
                      uri.contains('/product/');
                  if (maybeProduct != isProductPage) {
                    setState(() {
                      isProductPage = maybeProduct;
                    });
                    widget.onProductPageChanged(isProductPage);
                  }
                  return NavigationActionPolicy.ALLOW;
                },

                initialSettings: InAppWebViewSettings(
                  useShouldOverrideUrlLoading: true,
                  mediaPlaybackRequiresUserGesture: false,
                ),
              ),
              if (isProductPage)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 6,
                          ),
                          onPressed: () async {
                            final hasClickToBuy = await webViewController
                                ?.evaluateJavascript(
                                  source: """
                       document.querySelector('ul.choose-size li.goods-size__click-to-buy') !== null;
                       """,
                                );

                            if (hasClickToBuy == true) {
                              await webViewController?.evaluateJavascript(
                                source: """
                           document.querySelector('ul.choose-size li.goods-size__click-to-buy').click();
                              """,
                              );
                              await Future.delayed(const Duration(seconds: 2));
                            }

                            final selectedColor = await webViewController
                                ?.evaluateJavascript(
                                  source: """
                      (function() {
                        var el = document.querySelector('li.color-active a');
                        return el ? el.getAttribute('aria-label') : null;
                      })();
                    """,
                                );

                            final selectedSize = await webViewController
                                ?.evaluateJavascript(
                                  source: """
                     (function() {
                       var el = document.querySelector('ul.goods-size__sizes[data-attr_id="87"] li.size-active');
                        return el ? el.getAttribute('data-attr_value') : null;
                         })();
                             """,
                                );

                            final colorCount = await webViewController
                                ?.evaluateJavascript(
                                  source: """
                       document.querySelectorAll('ul.goods-size__sizes[data-attr_id="27"] li').length;
                      """,
                                );

                            final sizeCount = await webViewController
                                ?.evaluateJavascript(
                                  source: """
                      document.querySelectorAll('ul.goods-size__sizes[data-attr_id="87"] li').length;
                     """,
                                );

                            if ((colorCount > 0 &&
                                    (selectedColor == null ||
                                        selectedColor
                                            .toString()
                                            .trim()
                                            .isEmpty)) ||
                                (sizeCount > 0 &&
                                    (selectedSize == null ||
                                        selectedSize
                                            .toString()
                                            .trim()
                                            .isEmpty))) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "⚠️ يرجى اختيار السمات قبل الإضافة إلى السلة",
                                    ),
                                  ),
                                );
                              }
                              return;
                            }

                            final name = await webViewController
                                ?.evaluateJavascript(
                                  source:
                                      "document.getElementById('detail-view')?.getAttribute('data-goods_name');",
                                );
                            final price = await webViewController
                                ?.evaluateJavascript(
                                  source:
                                      "document.getElementById('detail-view')?.getAttribute('data-goods_ga_price');",
                                );
                            final productId = await webViewController
                                ?.evaluateJavascript(
                                  source:
                                      "document.getElementById('detail-view')?.getAttribute('data-goods_id');",
                                );
                            final imageUrl = await webViewController
                                ?.evaluateJavascript(
                                  source: """
                   (function() {
                     var img = document.querySelector('.crop-image-container__img');
                     return img ? (img.getAttribute('data-src') || img.getAttribute('src')) : null;
                           })();
                             """,
                                );
                            if (price == null ||
                                price.toString().trim().isEmpty) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "⚠️ لا يمكن إضافة المنتج — السعر غير متوفر.",
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                              return;
                            }

                            int quantity = 1;
                            double total =
                                double.tryParse(price.toString()) ?? 0;

                            if (context.mounted) {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setSheetState) {
                                      return Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              if (imageUrl != null &&
                                                  imageUrl
                                                      .toString()
                                                      .isNotEmpty)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        bottom: 10,
                                                      ),
                                                  child: SizedBox(
                                                    height: 120,
                                                    width: double.infinity,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            imageUrl
                                                                    .toString()
                                                                    .startsWith(
                                                                      "http",
                                                                    )
                                                                ? imageUrl
                                                                : "https:${imageUrl.toString()}",
                                                        fit: BoxFit.cover,
                                                        placeholder:
                                                            (
                                                              context,
                                                              url,
                                                            ) => Container(
                                                              color:
                                                                  Colors
                                                                      .grey[200],
                                                              child: const Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              ),
                                                            ),
                                                        errorWidget:
                                                            (
                                                              context,
                                                              url,
                                                              error,
                                                            ) => Container(
                                                              color:
                                                                  Colors
                                                                      .grey[300],
                                                              child: const Icon(
                                                                Icons.error,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              Text(
                                                "📦 الاسم: $name",
                                                textAlign: TextAlign.right,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                "💰 السعر: \$${price}",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              if (selectedColor != null &&
                                                  selectedColor
                                                      .toString()
                                                      .trim()
                                                      .isNotEmpty)
                                                Text(
                                                  "🎨 اللون: $selectedColor",
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              if (selectedSize != null &&
                                                  selectedSize
                                                      .toString()
                                                      .trim()
                                                      .isNotEmpty)
                                                Text(
                                                  " $selectedSize :المقاس",
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      if (quantity > 1) {
                                                        setSheetState(
                                                          () => quantity--,
                                                        );
                                                      }
                                                    },
                                                    icon: const Icon(
                                                      Icons.remove,
                                                    ),
                                                  ),
                                                  Text(quantity.toString()),
                                                  IconButton(
                                                    onPressed:
                                                        () => setSheetState(
                                                          () => quantity++,
                                                        ),
                                                    icon: const Icon(Icons.add),
                                                  ),
                                                  const Text("🔢 الكمية:"),
                                                ],
                                              ),
                                              Text(
                                                "💵 السعر الكلي: \$${(quantity * total).toStringAsFixed(2)}",
                                              ),
                                              const SizedBox(height: 30),
                                              ElevatedButton(
                                                onPressed: () {
                                                  // ✅ إضافة المنتج للسلة فعلياً
                                                  final product = ProductEntity(
                                                    id:
                                                        int.tryParse(
                                                          productId.toString(),
                                                        ) ??
                                                        DateTime.now()
                                                            .millisecondsSinceEpoch,
                                                    name: name.toString(),
                                                    price: total,
                                                    finalPrice: total,
                                                    quantity:
                                                        100, // Stock placeholder

                                                    status: 'shein',
                                                    isAvailable: true,
                                                    img:
                                                        imageUrl
                                                                .toString()
                                                                .startsWith(
                                                                  "http",
                                                                )
                                                            ? imageUrl
                                                            : "https:$imageUrl",
                                                    description:
                                                        'Shein Product',
                                                    isSheinProduct: true,
                                                    selectedColor:
                                                        selectedColor
                                                            ?.toString(),
                                                    selectedSize:
                                                        selectedSize
                                                            ?.toString(),
                                                    sheinUrl:
                                                        webViewController
                                                            ?.getUrl()
                                                            .toString(),
                                                  );

                                                  // Add logic (Loop for quantity if needed, or update cart item)
                                                  // Since CartCubit.addProduct adds 1 or increments, we might need to loop
                                                  for (
                                                    int i = 0;
                                                    i < quantity;
                                                    i++
                                                  ) {
                                                    context
                                                        .read<CartCubit>()
                                                        .addProduct(product);
                                                  }

                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        "✅ تم إضافة $quantity منتج للسلة",
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  "تأكيد الإضافة",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.add_shopping_cart,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'أضف إلى السلة',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
