// lib/features/home/presentation/views/orders_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/cubits/orders_cubit/orders_cubit.dart';
import 'package:myapp/core/services/get_it_service.dart';
import 'package:myapp/features/home/presentation/views/widgets/orders_view_body.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});
  static const String routeName = 'orders_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OrdersCubit>()..fetchOrders(),
      child: const OrdersViewBody(),
    );
  }
}
