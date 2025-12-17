// product_fab.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ProductFAB extends StatelessWidget {
  final InAppWebViewController webViewController;

  const ProductFAB({Key? key, required this.webViewController})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      right: 20,
      child: FloatingActionButton.extended(
        onPressed: () => _onAddPressed(context),
        label: Text('إضافة إلى السلة'),
        icon: Icon(Icons.shopping_cart),
      ),
    );
  }

  Future<void> _onAddPressed(BuildContext context) async {
    // تحققات نابضة — نفس المنطق الموجود أصلا، لكن معزول هنا
    try {
      final hasClickToBuy = await webViewController.evaluateJavascript(
        source:
            "document.querySelector('ul.choose-size li.goods-size__click-to-buy') !== null;",
      );

      if (hasClickToBuy == true) {
        await webViewController.evaluateJavascript(
          source:
              "document.querySelector('ul.choose-size li.goods-size__click-to-buy').click();",
        );
        await Future.delayed(Duration(seconds: 2));
      }

      final selectedColor = await webViewController.evaluateJavascript(
        source: """
        (function() {
          var el = document.querySelector('ul.goods-size__sizes[data-attr_id="27"] li.size-active');
          return el ? el.getAttribute('data-attr_value') : null;
        })();
        """,
      );

      final selectedSize = await webViewController.evaluateJavascript(
        source: """
        (function() {
          var el = document.querySelector('ul.goods-size__sizes[data-attr_id="87"] li.size-active');
          return el ? el.getAttribute('data-attr_value') : null;
        })();
        """,
      );

      final colorCount = await webViewController.evaluateJavascript(
        source:
            "document.querySelectorAll('ul.goods-size__sizes[data-attr_id=\"27\"] li').length;",
      );

      final sizeCount = await webViewController.evaluateJavascript(
        source:
            "document.querySelectorAll('ul.goods-size__sizes[data-attr_id=\"87\"] li').length;",
      );

      // التأكد من اختيار اللون/المقاس إن كانت موجودة
      bool needsColor = (colorCount is num && colorCount > 0);
      bool needsSize = (sizeCount is num && sizeCount > 0);

      if ((needsColor &&
              (selectedColor == null ||
                  selectedColor.toString().trim().isEmpty)) ||
          (needsSize &&
              (selectedSize == null ||
                  selectedSize.toString().trim().isEmpty))) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "⚠️ يرجى اختيار اللون والمقاس قبل الإضافة إلى السلة",
              ),
            ),
          );
        }
        return;
      }

      // جلب بيانات المنتج
      final name = await webViewController.evaluateJavascript(
        source:
            "document.getElementById('detail-view')?.getAttribute('data-goods_name');",
      );
      final price = await webViewController.evaluateJavascript(
        source:
            "document.getElementById('detail-view')?.getAttribute('data-goods_ga_price');",
      );
      final productId = await webViewController.evaluateJavascript(
        source:
            "document.getElementById('detail-view')?.getAttribute('data-goods_id');",
      );
      final imageUrl = await webViewController.evaluateJavascript(
        source: """
          (function() {
            var img = document.querySelector('.crop-image-container__img');
            return img ? (img.getAttribute('data-src') || img.getAttribute('src')) : null;
          })();
        """,
      );

      double total = double.tryParse(price.toString()) ?? 0;
      int quantity = 1;

      if (!context.mounted) return;

      // عرض الـ bottom sheet مع StatefulBuilder لإدارة الكمية محلياً
      showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
            builder: (ctx, setSheetState) {
              return Padding(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (imageUrl != null && imageUrl.toString().isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: SizedBox(
                            height: 120,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                imageUrl:
                                    imageUrl.toString().startsWith("http")
                                        ? imageUrl.toString()
                                        : "https:${imageUrl.toString()}",
                                fit: BoxFit.cover,
                                placeholder:
                                    (c, u) => Container(
                                      color: Colors.grey[200],
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                errorWidget:
                                    (c, u, e) => Container(
                                      color: Colors.grey[300],
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                        ),
                      Text("📦 الاسم: $name", style: TextStyle(fontSize: 18)),
                      Text(
                        "💰 السعر: \$${price}",
                        style: TextStyle(fontSize: 16),
                      ),
                      if (selectedColor != null &&
                          selectedColor.toString().trim().isNotEmpty)
                        Text(
                          "🎨 اللون: $selectedColor",
                          style: TextStyle(fontSize: 16),
                        ),
                      if (selectedSize != null &&
                          selectedSize.toString().trim().isNotEmpty)
                        Text(
                          "📏 المقاس: $selectedSize",
                          style: TextStyle(fontSize: 16),
                        ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text("🔢 الكمية:"),
                          IconButton(
                            onPressed: () {
                              if (quantity > 1) setSheetState(() => quantity--);
                            },
                            icon: Icon(Icons.remove),
                          ),
                          Text(quantity.toString()),
                          IconButton(
                            onPressed: () => setSheetState(() => quantity++),
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                      Text(
                        "💵 السعر الكلي: \$${(quantity * total).toStringAsFixed(2)}",
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          // هنا يمكنك استبدال ال AlertDialog بإرسال بيانات للسيرفر أو حفظها داخل التطبيق
                          showDialog(
                            context: context,
                            builder:
                                (_) => AlertDialog(
                                  title: Text("✅ تم الإضافة"),
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("🆔 المعرف: $productId"),
                                      Text("📦 الاسم: $name"),
                                      Text("💰 السعر: \$${price}"),
                                      if (selectedColor != null)
                                        Text("🎨 اللون: $selectedColor"),
                                      if (selectedSize != null)
                                        Text("📏 المقاس: $selectedSize"),
                                      Text("🔢 الكمية: $quantity"),
                                      Text(
                                        "💵 السعر الكلي: \$${(total * quantity).toStringAsFixed(2)}",
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("موافق"),
                                    ),
                                  ],
                                ),
                          );
                        },
                        child: Text("تأكيد الإضافة"),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("حدث خطأ: $e")));
      }
    }
  }
}
