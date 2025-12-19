import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myapp/core/utils/app_colors.dart';
import 'package:myapp/core/utils/app_images.dart';
import 'package:myapp/core/widgets/custom_network_image.dart';
import 'package:myapp/features/home/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:myapp/features/home/presentation/cubits/cart_item_cubit/cart_item_cubit.dart';
import 'package:myapp/features/home/presentation/views/domain/entites/cart_item_entity.dart';
import 'package:myapp/features/home/presentation/views/widgets/cart_item_action_buttons.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../../core/utils/app_text_styles.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.carItemEntity});

  final CartItemEntity carItemEntity;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<CartItemCubit, CartItemState>(
      buildWhen: (prev, current) {
        if (current is CartItemUpdated) {
          return current.cartItemEntity == carItemEntity;
        }
        return false;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Product Image
              Container(
                width: size.width * 0.2, // responsive width
                height: size.width * 0.28,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F5F7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomNetworkImage(
                  imageUrl: carItemEntity.productEntity.imageUrl!,
                ),
              ),

              const SizedBox(width: 12),

              /// Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name + Delete
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            carItemEntity.productEntity.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.bold13,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<CartCubit>().deleteCarItem(
                              carItemEntity,
                            );
                          },
                          child: SvgPicture.asset(
                            Assets.imagesTrash,
                            width: 18,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    /// Size & Color (for clothes)
                    Text(
                      'التفاصيل : ${carItemEntity.productEntity.description} ',
                      style: TextStyles.regular13.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 6),

                    /// Quantity & Price
                    Row(
                      children: [
                        CartItemActionButtons(cartItemEntity: carItemEntity),
                        const Spacer(),
                        Text(
                          '${carItemEntity.totalPriceFormatted} ريال',
                          style: TextStyles.bold16.copyWith(
                            color: AppColors.secondaryColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
