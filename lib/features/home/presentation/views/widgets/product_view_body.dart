import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/core/cubits/products_cubit/products_cubit.dart';
import 'package:myapp/core/widgets/custom_app_bar.dart';
import 'package:myapp/core/widgets/search_text_field.dart';
import 'package:myapp/features/home/presentation/views/widgets/products_grid_view_block_builder.dart';
import 'package:myapp/features/home/presentation/views/widgets/products_view_header.dart';

class ProductViewBody extends StatefulWidget {
  const ProductViewBody({super.key});

  @override
  State<ProductViewBody> createState() => _ProductViewBodyState();
}

class _ProductViewBodyState extends State<ProductViewBody> {
  @override
  void initState() {
    context.read<ProductsCubit>().getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: kTopPadding),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kHorizintalPadding,
                ),
                child: buildAppBar(
                  context,
                  title: "المنتجات",
                  showBackIcon: false,
                  showactionsIcon: true,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kHorizintalPadding,
                ),
                child: SearchTextField(),
              ),
              SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kHorizintalPadding,
                ),
                child: ProductsViewHeader(
                  productsLength: context.watch<ProductsCubit>().productsLength,
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
          sliver: ProductsGridViewBlockBuilder(),
        ),
      ],
    );
  }
}
