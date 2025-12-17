// lib/features/checkout/presentation/views/checkout_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/helper_functions/get_user.dart';
import 'package:myapp/core/repos/orders_repo/orders_repo.dart';
import 'package:myapp/core/services/get_it_service.dart';
import 'package:myapp/core/widgets/custom_app_bar.dart';
import 'package:myapp/features/checkout/domain/entities/order_entity.dart';
import 'package:myapp/features/checkout/domain/entities/shipping_address_entity.dart';
import 'package:myapp/features/checkout/presentation/manager/add_order_cubit/add_order_cubit.dart';
import 'package:myapp/features/checkout/presentation/views/widgets/add_order_cubit_bloc_builder.dart';
import 'package:myapp/features/checkout/presentation/views/widgets/checkout_view_body.dart';
import 'package:myapp/features/home/presentation/views/domain/entites/cart_entity.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key, required this.cartEntity});
  
  static const routeName = 'CheckoutView';
  final CartEntity cartEntity;
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddOrderCubit>(), // ✅ استخدام getIt
      child: Scaffold(
        appBar: buildAppBar(context, title: 'الشحن'),
        body: Provider.value(
          value: OrderEntity(
            cartEntity,
            shippingAddressEntity: ShippingAddressEntity(),
            uID: getuser().uId, // ✅ الآن موجود
          ),
          child: const AddOrderCubitBlocBuilder(
            child: CheckoutViewBody(),
          ),
        ),
      ),
    );
  }
}