import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/helper_functions/build_error_bar.dart';
import 'package:myapp/core/widgets/custom_button.dart';
import 'package:myapp/features/checkout/presentation/views/checkout_view.dart';
import 'package:myapp/features/home/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:myapp/features/home/presentation/cubits/cart_item_cubit/cart_item_cubit.dart';

class CustomCartButton extends StatelessWidget {
  const CustomCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartItemCubit, CartItemState>(
      builder: (context, state) {
        return CustomButton(
          onPressed: () {
            if (context.read<CartCubit>().cartEntity.cartItems.isNotEmpty) {
              Navigator.pushNamed(
                context,
                CheckoutView.routeName,
                arguments: context.read<CartCubit>().cartEntity,
              );
            } else {
              showErrorBar(context, 'لايوجد منتجات با السلة');
            }
          },
          text:
              'الدفع  ${context.watch<CartCubit>().cartEntity.calculateTotalPrice()} ريال ',
        );
      },
    );
  }
}
