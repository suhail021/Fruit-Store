// lib/features/favorites/presentation/cubits/favorites_state.dart
import 'package:myapp/core/entities/favorite_entity.dart';

sealed class FavoritesState {}

// الحالات الأساسية
final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesSuccess extends FavoritesState {
  final List<FavoriteEntity> favorites;

  FavoritesSuccess({required this.favorites});
}

final class FavoritesFailure extends FavoritesState {
  final String errMessage;

  FavoritesFailure({required this.errMessage});
}

// حالات Toggle
final class FavoriteToggleSuccess extends FavoritesState {
  final String message;

  FavoriteToggleSuccess({required this.message});
}

final class FavoriteToggleFailure extends FavoritesState {
  final String errMessage;

  FavoriteToggleFailure({required this.errMessage});
}

// حالات Remove
final class FavoriteRemoveSuccess extends FavoritesState {
  final String message;

  FavoriteRemoveSuccess({required this.message});
}

final class FavoriteRemoveFailure extends FavoritesState {
  final String errMessage;

  FavoriteRemoveFailure({required this.errMessage});
}