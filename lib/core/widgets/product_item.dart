// lib/core/widgets/product_item.dart
import 'package:flutter/material.dart';
import 'package:myapp/core/entities/product_entity.dart';
import 'package:myapp/core/utils/app_colors.dart';
import 'package:myapp/core/utils/app_text_styles.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.productEntity});
  
  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة المنتج
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F5F7),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
              ),
              child: productEntity.img != null
                  ? ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                      child: Image.network(
                        productEntity.img!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
            ),
          ),
          
          // معلومات المنتج
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // اسم المنتج
                  Text(
                    productEntity.name,
                    style: TextStyles.semibold13,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  // السعر
                  Row(
                    children: [
                      // السعر النهائي
                      Text(
                        '${productEntity.finalPrice.toStringAsFixed(2)} ر.س',
                        style: TextStyles.bold13.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      
                      const SizedBox(width: 4),
                      
                      // السعر القديم إذا كان هناك خصم
                      if (productEntity.hasDiscount)
                        Text(
                          '${productEntity.price.toStringAsFixed(2)}',
                          style: TextStyles.regular11.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                  
                  // حالة التوفر
                  if (!productEntity.inStock)
                    Text(
                      'غير متوفر',
                      style: TextStyles.regular11.copyWith(
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}