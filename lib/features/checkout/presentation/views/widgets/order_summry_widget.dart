import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/utils/app_text_styles.dart';
import 'package:myapp/features/checkout/domain/entities/order_entity.dart';
import 'package:myapp/features/checkout/presentation/views/widgets/payment_item.dart';

class OrderSummryWidget extends StatelessWidget {
  const OrderSummryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PaymentItem(
      title: 'ملخص الطلب:',
      child: Column(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Text(
                    'المجموع الفرعي:',
                    style: TextStyles.regular13.copyWith(
                      color: const Color(0xff4e5556),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'ريال ${context.read<OrderEntity>().cartEntity.calculateTotalPrice()}',
                    style: TextStyles.semibold16.copyWith(),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'التوصيل :',
                    style: TextStyles.regular13.copyWith(
                      color: const Color(0xff4e5556),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'ريال 40',
                    style: TextStyles.regular13.copyWith(
                      color: const Color(0xff4e5556),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 9),
              const Divider(thickness: .5, color: Color(0xffcacece)),
              SizedBox(height: 9),
              Row(
                children: [
                  Text('الكلي', style: TextStyles.bold16),
                  const Spacer(),
                  Text('ريال 2000', style: TextStyles.bold16),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
