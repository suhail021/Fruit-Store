import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/features/checkout/presentation/views/widgets/address_input_section.dart';
import 'package:myapp/features/checkout/presentation/views/widgets/payment_section.dart';
import 'package:myapp/features/checkout/presentation/views/widgets/shipping_section.dart';

class CheckoutStepsPageView extends StatelessWidget {
  const CheckoutStepsPageView({
    super.key,
    required this.pageController,
    required this.formkey,
    required this.valueListenable,
  });

  final PageController pageController;
  final GlobalKey<FormState> formkey;
  final ValueListenable<AutovalidateMode> valueListenable;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: getPages().length,
      itemBuilder: (context, index) {
        return getPages()[index];
      },
    );
  }

  List<Widget> getPages() {
    return [
      ShippingSection(),
      AddressInputSection(formkey: formkey, valueListenable: valueListenable),
      PaymentSection(pageController: pageController),
    ];
  }
}
