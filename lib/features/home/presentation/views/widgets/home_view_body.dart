import 'package:flutter/material.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/core/widgets/product_item.dart';
import 'package:myapp/core/widgets/search_text_field.dart';
import 'package:myapp/features/home/presentation/views/widgets/best_selling_grid_view.dart';
import 'package:myapp/features/home/presentation/views/widgets/best_selling_header.dart';
import 'package:myapp/features/home/presentation/views/widgets/custom_home_appbar.dart';
import 'package:myapp/features/home/presentation/views/widgets/featured_item.dart';
import 'package:myapp/features/home/presentation/views/widgets/featured_list.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: kTopPadding),
              CustomHomeAppbar(),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kHorizintalPadding,
                ),
                child: SearchTextField(),
              ),
              SizedBox(height: 12),

              FeaturedList(),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kHorizintalPadding,
                ),
                child: BestSellingHeader(),
              ),
              SizedBox(height: 8,)

            ],
          ),

        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: kHorizintalPadding,
          ),
          sliver: BestSellingGridView())
      ],
    );
  }
}
