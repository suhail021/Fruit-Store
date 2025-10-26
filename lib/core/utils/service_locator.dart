import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:google/core/utils/api_serves.dart';
import 'package:google/features/home/data/repos/home_repo_impl.dart';
import 'package:google/features/search/data/repos/search_repo_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiServes>(ApiServes(Dio()));

  getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(getIt.get<ApiServes>()));
  getIt.registerSingleton<SearchRepoImpl>(SearchRepoImpl(getIt.get<ApiServes>()));
}
