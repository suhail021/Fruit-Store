part of 'home_cubit.dart';

class HomeState {
  final int currentIndex;
  final String? sheinUrl;

  const HomeState({
    this.currentIndex = 2, // Default to Home
    this.sheinUrl,
  });

  HomeState copyWith({int? currentIndex, String? sheinUrl}) {
    return HomeState(
      currentIndex: currentIndex ?? this.currentIndex,
      sheinUrl:
          sheinUrl, // URL is transient, overwrite it (or keep existing if desired logic)
      // For this use case, if we change tab without url, we might want to clear it or keep it?
      // Let's assume passed url overwrites. If null passed, we might want to keep existing OR clear.
      // Better: if we switch tabs manually, we probably don't have a new URL.
    );
  }
}
