import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/core/widgets/custom_app_bar.dart';
import 'package:myapp/features/home/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:myapp/features/home/presentation/views/widgets/car_items_list.dart';
import 'package:myapp/features/home/presentation/views/widgets/cart_header.dart';
import 'package:myapp/features/home/presentation/views/widgets/custom_cart_button.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kHorizintalPadding,
                    ),
                    child: buildAppBar(
                      context,
                      title: "السلة",
                      showBackIcon: false,
                    ),
                  ),
                  SizedBox(height: 10),
                  CartHeader(),
                  SizedBox(height: 12),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child:
                  context.read<CartCubit>().cartEntity.cartItems.isNotEmpty
                      ? CustomDivider()
                      : SizedBox(),
            ),
            CarItemsList(
              carItems: context.watch<CartCubit>().cartEntity.cartItems,
            ),
            SliverToBoxAdapter(
              child:
                  context.read<CartCubit>().cartEntity.cartItems.isNotEmpty
                      ? CustomDivider()
                      : SizedBox(),
            ),
          ],
        ),
        Positioned(
          right: 16,
          left: 16,
          bottom: MediaQuery.sizeOf(context).height * .07,
          child: CustomCartButton(),
        ),
      ],
    );
  }
}
