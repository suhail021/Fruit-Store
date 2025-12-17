import 'package:flutter/material.dart';
import 'package:myapp/core/utils/app_text_styles.dart';
import 'package:myapp/features/checkout/presentation/views/widgets/order_summry_widget.dart';
import 'package:myapp/features/checkout/presentation/views/widgets/payment_item.dart';
import 'package:myapp/features/checkout/presentation/views/widgets/shipping_address_widget.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({super.key, required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24),
        OrderSummryWidget(),
        SizedBox(height: 16),
        ShippingAddressWidget(pageController: pageController),
      ],
    );
  }
}
