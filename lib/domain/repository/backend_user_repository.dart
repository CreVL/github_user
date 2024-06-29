import 'package:dio/dio.dart';
import 'package:github_users/application/repository/repository_error.dart';
import 'package:github_users/application/repository/user/user_repository.dart';
import 'package:github_users/features/model/user/user.dart';
import 'package:github_users/internal/entities/either.dart';

import '../../data/values/url_address.dart';

class BackendUserRepository implements UserRepository {
  final Dio _dio;

  BackendUserRepository({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<Either<RepositoryError, List<User>>> getUsers() async {
    try {
      final response = await _dio.get(
        UrlAddress.users,
        options: Options(
          headers: {
            'Authorization': 'Bearer $githubToken',
          },
        ),
      );
      final data = response.data;
      if (data == null || response.statusCode != 200 || data is! List) {
        return Either.left(BadHttpResponseRepositoryError());
      }

      List<User> users = [];
      for (var userJson in data) {
        var user = User.fromJson(userJson);
        user = await _fetchAdditionalUserData(user);
        users.add(user);
      }

      return Either.right(users);
    } catch (e) {
      return Either.left(UnknownRepositoryError());
    }
  }

  Future<User> _fetchAdditionalUserData(User user) async {
    try {
      final followersResponse = await _dio.get(
        user.followersUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $githubToken',
          },
        ),
      );
      final followingResponse = await _dio.get(
        user.followingUrl.replaceAll("{/other_user}", ""),
        options: Options(
          headers: {
            'Authorization': 'Bearer $githubToken',
          },
        ),
      );

      int followers = (followersResponse.data as List).length;
      int following = (followingResponse.data as List).length;

      return user.copyWith(followers: followers, following: following);
    } catch (e) {
      return user;
    }
  }
}
