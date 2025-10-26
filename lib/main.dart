import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google/constants.dart';
import 'package:google/core/utils/app_router.dart';
import 'package:google/core/utils/service_locator.dart';
import 'package:google/features/home/data/repos/home_repo_impl.dart';
import 'package:google/features/home/presentation/manger/featured_books_cubit/featured_books_cubit.dart';
import 'package:google/features/home/presentation/manger/newset_books_cubit/newset_books_cubit.dart';

void main() {
  setupServiceLocator();
  runApp(const BooksApp());
}

class BooksApp extends StatelessWidget {
  const BooksApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeaturedBooksCubit(getIt.get<HomeRepoImpl>())..fetchFeaturedBooks(),
        ),
        BlocProvider(
          create: (context) => NewsetBooksCubit(getIt.get<HomeRepoImpl>())..fetchNewsetBooks(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kPrimaryColor,
        ),
      ),
    );
  }
}
