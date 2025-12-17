import 'package:flutter/material.dart';
import 'package:myapp/features/checkout/domain/entities/order_entity.dart';
import 'package:myapp/features/checkout/presentation/views/widgets/shipping_item.dart';
import 'package:provider/provider.dart';

class ShippingSection extends StatefulWidget {
  const ShippingSection({super.key});

  @override
  State<ShippingSection> createState() => _ShippingSectionState();
}

class _ShippingSectionState extends State<ShippingSection>
    with AutomaticKeepAliveClientMixin {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var orderEntity = context.read<OrderEntity>();

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 24),

          ShippingItem(
            title: 'الدفع عن طريق محفظة جيب',
            subtitle: 'رقم الحساب 011000',
            price:
                (orderEntity.cartEntity.calculateTotalPrice() + 40).toString(),
            isSelected: selectedIndex == 0,
            onTap: () {
              selectedIndex = 0;
              setState(() {});
              // orderEntity.payWithCash = true;
            },
          ),
          SizedBox(height: 16),
          ShippingItem(
            title: 'الدفع عن طريق محفظة جوالي',
            subtitle: 'رقم الحساب 011000',
            price: orderEntity.cartEntity.calculateTotalPrice().toString(),
            isSelected: selectedIndex == 1,
            onTap: () {
              selectedIndex = 1;
              setState(() {});
              // orderEntity.payWithCash = false;
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
