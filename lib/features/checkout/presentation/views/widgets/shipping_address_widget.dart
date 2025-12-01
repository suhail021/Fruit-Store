import 'package:flutter/material.dart';
import 'package:myapp/core/utils/app_text_styles.dart';
import 'package:myapp/features/checkout/domain/entities/order_entity.dart';
import 'package:myapp/features/checkout/presentation/views/widgets/payment_item.dart';
import 'package:provider/provider.dart';

class ShippingAddressWidget extends StatelessWidget {
  const ShippingAddressWidget({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return PaymentItem(
      title: ' عنوان التوصيل',
      child: Column(
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  pageController.animateToPage(
                    pageController.page!.toInt() - 1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                child: Row( 
                  children: [
                    Icon(
                      Icons.location_on,
                      color: const Color(0xff4e5556),
                      size: 24,
                    ),
                    Text(
                      ' ${context.read<OrderEntity>().shippingAddressEntity}',
                      style: TextStyles.regular13.copyWith(
                        color: const Color(0xff4e5556),
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.edit, color: const Color(0xff4e5556), size: 20),
                    Text(
                      ' تعديل  ',
                      style: TextStyles.regular13.copyWith(
                        color: const Color(0xff4e5556),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ],
      ),
    );
  }
}
