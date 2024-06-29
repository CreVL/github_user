import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../application/repository/user/user_repository.dart';
import '../domain/repository/backend_user_repository.dart';

class GetItInitializer {
  static final _getIt = GetIt.instance;

  static void setupRepositories() {
    _getIt.registerLazySingleton<Dio>(
      () => Dio(),
    );

    _getIt.registerLazySingleton<UserRepository>(
      () => BackendUserRepository(
        dio: _getIt<Dio>(),
      ),
    );
  }
}
