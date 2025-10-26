import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google/core/utils/service_locator.dart';
import 'package:google/core/models/book_model/book_model.dart';
import 'package:google/features/home/data/repos/home_repo_impl.dart';
import 'package:google/features/home/presentation/manger/similar_books_cubit/similar_books_cubit.dart';
import 'package:google/features/home/presentation/views/book_details_view.dart';
import 'package:google/features/home/presentation/views/home_view.dart';
import 'package:google/features/search/data/repos/search_repo_impl.dart';
import 'package:google/features/search/presentation/manger/search_books_cubit/search_books_cubit.dart';
import 'package:google/features/search/presentation/views/search_view.dart';
import 'package:google/features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kBookDetailsView = '/bookdetailsview';
  static const kSearchView = '/SearchView';
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashView()),
      GoRoute(path: kHomeView, builder: (context, state) => HomeView()),
      GoRoute(
        path: kBookDetailsView,
        builder:
            (context, state) => BlocProvider(
              create: (context) => SimilarBooksCubit(getIt.get<HomeRepoImpl>()),
              child: BookDetailsView(bookModel: state.extra as BookModel),
            ),
      ),
      GoRoute(
        path: kSearchView,
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) => SearchBooksCubit(getIt.get<SearchRepoImpl>()),
              child: SearchView(),
            ),
      ),
    ],
  );
}
