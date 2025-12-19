import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void changeTab(int index, {String? url}) {
    // If URL is provided, we update state with it AND the new index.
    // If no URL (normal tap), we just update index.
    // NOTE: When switching away from Shein, should we clear URL?
    // Maybe not necessary if SheinWebView handles "new" URLs only.

    emit(HomeState(currentIndex: index, sheinUrl: url));
  }
}
