// lib/features/checkout/presentation/views/widgets/add_order_cubit_bloc_builder.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/helper_functions/build_error_bar.dart';
import 'package:myapp/core/widgets/custom_progress_hud.dart';
import 'package:myapp/features/checkout/presentation/manager/add_order_cubit/add_order_cubit.dart';
import 'package:myapp/features/checkout/presentation/views/checkout_success.dart';

class AddOrderCubitBlocBuilder extends StatelessWidget {
  const AddOrderCubitBlocBuilder({super.key, required this.child});
  
  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddOrderCubit, AddOrderState>(
      listener: (context, state) {
        if (state is AddOrderFailure) {
          showErrorBar(context, state.message); // ✅ تصحيح
        }
        if (state is AddOrderSuccess) {
          Navigator.of(context).pushReplacementNamed(
            CheckoutSuccess.routeName,
            arguments: state.invoiceId, // ✅ تمرير invoiceId
          );
        }
      },
      builder: (context, state) {
        return CustomProgressHUD(
          isLoading: state is AddOrderLoading,
          child: child,
        );
      },
    );
  }
}