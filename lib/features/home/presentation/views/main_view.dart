import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/home/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:myapp/core/cubits/favorites_cubit/favorites_cubit.dart';
import 'package:myapp/features/home/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:myapp/core/repos/favorites_repo/favorites_repo.dart';
import 'package:myapp/core/services/get_it_service.dart';
import 'package:myapp/features/home/presentation/views/widgets/MainViewBodyBlocConsumer.dart';
import 'package:myapp/features/home/presentation/views/widgets/custom_bottom_navigation_bar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});
  static const String routeName = 'MainView';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentViewIndex = 2;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(
          create:
              (context) =>
                  FavoritesCubit(getIt<FavoritesRepo>())..getFavorites(),
        ),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            extendBody: state.currentIndex == 2,
            bottomNavigationBar: CustomBottomNavigationBar(
              onItemTapped: (index) {
                context.read<HomeCubit>().changeTab(index);
              },
            ),
            body: SafeArea(
              bottom: state.currentIndex != 2,
              child: Mainviewbodyblocconsumer(
                currentViewIndex: state.currentIndex,
              ),
            ),
          );
        },
      ),
    );
  }
}
