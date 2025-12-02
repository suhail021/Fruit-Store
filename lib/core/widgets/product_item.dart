// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:myapp/core/entities/product_entity.dart';
// import 'package:myapp/core/utils/app_colors.dart';
// import 'package:myapp/core/utils/app_text_styles.dart';
// import 'package:myapp/core/widgets/custom_network_image.dart';
// import 'package:myapp/features/home/presentation/cubits/cart_cubit/cart_cubit.dart';

// class ProductItem extends StatelessWidget {
//   const ProductItem({super.key, required this.productEntity});
//   final ProductEntity productEntity;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: ShapeDecoration(
//         color: Color(0xfff3f5f7),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
//       ),
//       child: Stack(
//         children: [
//           Positioned.fill(
//             right: 0,
//             child: Column(
//               children: [
//                 productEntity.imageUrl != null
//                     ? Flexible(
//                       child: CustomNetworkImage(
//                         imageUrl: productEntity.imageUrl!,
//                       ),
//                     )
//                     : Container(
//                       color: Colors.grey,
//                       height: 130,
//                       width: double.infinity,
//                     ),
//                 ListTile(
//                   title: Text(productEntity.name, style: TextStyles.bold16),
//                   subtitle: Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: '${productEntity.price} ريال ',
//                           style: TextStyles.bold13.copyWith(
//                             color: AppColors.lightsecondaryColor,
//                           ),
//                         ),
//                         TextSpan(
//                           text: ' / ',
//                           style: TextStyles.semibold13.copyWith(
//                             color: AppColors.secondaryColor,
//                           ),
//                         ),
//                         TextSpan(
//                           text: 'كيلو',
//                           style: TextStyles.semibold13.copyWith(
//                             color: AppColors.lightsecondaryColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   trailing: GestureDetector(
//                     onTap: () {
//                       context.read<CartCubit>().addProduct(productEntity);
//                     },
//                     child: CircleAvatar(
//                       backgroundColor: AppColors.primaryColor,
//                       child: Icon(Icons.add, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             top: 0,
//             right: 0,
//             child: IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.favorite_border),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
