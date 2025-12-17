// lib/features/favorites/presentation/views/widgets/favorites_view_body.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/core/cubits/favorites_cubit/favorites_cubit.dart';
import 'package:myapp/core/cubits/favorites_cubit/favorites_state.dart';

import 'package:myapp/features/home/presentation/views/widgets/empty_favorites_widget.dart';
import 'package:myapp/features/home/presentation/views/widgets/favorite_item.dart';

class FavoritesViewBody extends StatelessWidget {
  const FavoritesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        // ✅ حالة النجاح - عرض المفضلات
        if (state is FavoritesSuccess) {
          if (state.favorites.isEmpty) {
            return const EmptyFavoritesWidget();
          }

          return RefreshIndicator(
            onRefresh: () async {
              await context.read<FavoritesCubit>().getFavorites();
            },
            child: Column(
              children: [
                // ✅ مؤشر المزامنة
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: kHorizintalPadding,
                    vertical: 8,
                  ),
                  color: Colors.green.shade50,
                  child: Row(
                    children: [
                      Icon(
                        Icons.cloud_done,
                        size: 16,
                        color: Colors.green.shade700,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'تم المزامنة مع السيرفر',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                ),

                // قائمة المفضلات
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(kHorizintalPadding),
                    itemCount: state.favorites.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final favorite = state.favorites[index];
                      
                      return FavoriteItem(
                        favorite: favorite,
                        onRemove: () {
                          _showDeleteConfirmation(
                            context,
                            favoriteId: favorite.idFavorites,
                            productName: favorite.productName,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        // ❌ حالة الفشل
        if (state is FavoritesFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.cloud_off,
                  size: 80,
                  color: Colors.orange,
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'لا يمكن الاتصال بالسيرفر\nسيتم عرض المفضلات المحلية',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<FavoritesCubit>().getFavorites();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('إعادة المحاولة'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // ⏳ حالة التحميل
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('جاري المزامنة مع السيرفر...'),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(
    BuildContext context, {
    required int favoriteId,
    required String productName,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: Text('هل تريد حذف "$productName" من المفضلة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<FavoritesCubit>().removeFavorite(favoriteId);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }
}