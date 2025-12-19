import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/services/get_it_service.dart';
import 'package:myapp/features/home/domain/repos/home_repo.dart';
import 'package:myapp/features/home/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:myapp/features/home/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => ProfileCubit(getIt.get<HomeRepo>())..fetchProfileData(),
      child: const Scaffold(body: ProfileViewBody()),
    );
  }
}
