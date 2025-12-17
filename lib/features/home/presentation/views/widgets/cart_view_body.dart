import 'package:flutter/material.dart';


class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // CustomScrollView(
        //   slivers: [
        //     SliverToBoxAdapter(
        //       child: Column(
        //         children: [
        //           SizedBox(height: kTopPadding),
        //           Padding(
        //             padding: const EdgeInsets.symmetric(
        //               horizontal: kHorizintalPadding,
        //             ),
        //             child: buildAppBar(
        //               context,
        //               title: "السلة",
        //               showBackIcon: false,
        //             ),
        //           ),
        //           SizedBox(height: 10),
        //           CartHeader(),
        //           SizedBox(height: 12),
        //         ],
        //       ),
        //     ),
        //     SliverToBoxAdapter(
        //       child:
        //           context.read<CartCubit>().cartEntity.cartItems.isNotEmpty
        //               ? CustomDivider()
        //               : SizedBox(),
        //     ),
        //     CarItemsList(
        //       carItems: context.watch<CartCubit>().cartEntity.cartItems,
        //     ),
        //     SliverToBoxAdapter(
        //       child:
        //           context.read<CartCubit>().cartEntity.cartItems.isNotEmpty
        //               ? CustomDivider()
        //               : SizedBox(),
        //     ),
        //    ],
        //   ),
        //    Positioned(
        //   right: 16,
        //   left: 16,
        //   bottom: MediaQuery.sizeOf(context).height * .07,
        //   child: CustomCartButton(),
        // ),
      ],
    );
  }
}
