// lib/features/favorites/presentation/views/widgets/favorite_item.dart
import 'package:flutter/material.dart';
import 'package:myapp/core/entities/favorite_entity.dart';
import 'package:myapp/core/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/utils/app_text_styles.dart';
import 'package:myapp/features/home/presentation/cubits/home_cubit/home_cubit.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({
    super.key,
    required this.favorite,
    required this.onRemove,
  });

  final FavoriteEntity favorite;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (favorite.productLink.isNotEmpty) {
          context.read<HomeCubit>().changeTab(2, url: favorite.productLink);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // صورة المنتج
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F5F7),
                borderRadius: BorderRadius.circular(8),
              ),
              child:
                  favorite.img != null
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          favorite.img!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 30,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      )
                      : const Center(
                        child: Icon(Icons.image, size: 30, color: Colors.grey),
                      ),
            ),
            const SizedBox(width: 12),

            // معلومات المنتج
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // اسم المنتج
                  Text(
                    favorite.productName,
                    style: TextStyles.bold16,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // الوصف
                  if (favorite.productDescription != null)
                    Text(
                      favorite.productDescription!,
                      style: TextStyles.regular13.copyWith(
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 8),

                  // السعر
                  Row(
                    children: [
                      if (favorite.finalPrice != null)
                        Text(
                          '${favorite.finalPrice!.toStringAsFixed(2)} ر.س',
                          style: TextStyles.bold16.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      const SizedBox(width: 8),
                      if (favorite.hasDiscount)
                        Text(
                          '${favorite.price!.toStringAsFixed(2)}',
                          style: TextStyles.regular13.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // زر الحذف
            IconButton(
              onPressed: onRemove,
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
