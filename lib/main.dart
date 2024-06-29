import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users/features/ui/theme/theme.dart';
import 'data/get_it_initializer.dart';
import 'domain/repository/backend_user_repository.dart';
import 'features/bloc/github_bloc.dart';
import 'features/theme/theme_cubit.dart';
import 'features/ui/pages/users_page/users_page.dart';

void main() {
  GetItInitializer.setupRepositories();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GithubBloc(BackendUserRepository(dio: Dio()))
            ..add(FetchGithubUsers()),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            theme: themeState.brightness == Brightness.dark
                ? darkTheme
                : lightTheme,
            title: 'GitHub Users',
            home: const UsersPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
