import 'package:flutter/material.dart';
import 'package:google/core/utils/styles.dart';
import 'package:google/features/home/presentation/views/widgets/best_seller_list_view.dart';
import 'package:google/features/home/presentation/views/widgets/custome_app_bar.dart';
import 'package:google/features/home/presentation/views/widgets/featured_books_list_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomeAppBar(),
                const FeaturedBooksListView(),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Best Seller", style: Styles.textStyle20),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          BestSellerListView(),
        ],
      ),
    );
  }
}
