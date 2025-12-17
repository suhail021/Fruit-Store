import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/cubits/products_cubit/products_cubit.dart';
import 'package:myapp/core/repos/products_repo/products_repo.dart';
import 'package:myapp/core/services/get_it_service.dart';
import 'package:myapp/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
static const String routeName = 'home';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit(getIt.get<ProductsRepo>()),
      child: const HomeViewBody(),
    );
  }
}
