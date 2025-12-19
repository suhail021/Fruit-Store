// lib/features/favorites/presentation/views/favorites_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/cubits/favorites_cubit/favorites_cubit.dart';
import 'package:myapp/core/repos/favorites_repo/favorites_repo.dart';
import 'package:myapp/core/services/get_it_service.dart';
import 'package:myapp/core/widgets/custom_app_bar.dart';
import 'package:myapp/features/home/presentation/views/widgets/favorites_view_body.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  static const String routeName = 'FavoritesView';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => FavoritesCubit(getIt<FavoritesRepo>())..getFavorites(),
        child: Scaffold(
          appBar: buildAppBar(
            context,
            title: 'المفضلة',
            showBackIcon: true,
          ),
          body: const FavoritesViewBody(),
        ),
      ),
    );
  }
}