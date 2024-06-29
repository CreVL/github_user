import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users/domain/repository/backend_user_repository.dart';
import 'package:github_users/features/model/user/user.dart';
import 'package:meta/meta.dart';

part 'github_event.dart';

part 'github_state.dart';

class GithubBloc extends Bloc<GithubEvent, GithubState> {
  final BackendUserRepository backendUserRepository;
  List<User> loadedUsers = [];
  List<User> filteredUsers = [];

  GithubBloc(this.backendUserRepository) : super(GithubInitial()) {
    on<FetchGithubUsers>(_onFetchGithubUsers);
    on<SearchGithubUsers>(_onSearchGithubUsers);
  }

  Future<void> _onFetchGithubUsers(
    FetchGithubUsers event,
    Emitter<GithubState> emit,
  ) async {
    List<User> mockedUsers = List.generate(
      10,
      (index) => User(
        login: 'fake_user_$index',
        avatarUrl: 'https://avatars.githubusercontent.com/u/1?v=4',
        id: 1,
        followersUrl: 'https://api.github.com/users/mojombo/followers',
        followingUrl:
            'https://api.github.com/users/mojombo/following{/other_user}',
      ),
    );

    emit(GithubLoading(mockedUsers: mockedUsers));

    try {
      final eitherResult = await backendUserRepository.getUsers();

      eitherResult.resolve(
        (error) {
          emit(GithubError(error: error.toString()));
        },
        (users) {
          loadedUsers = users;
          filteredUsers = loadedUsers;
          emit(GithubLoaded(users: filteredUsers));
        },
      );
    } catch (e) {
      emit(GithubError(error: e.toString()));
    }
  }

  Future<void> _onSearchGithubUsers(
    SearchGithubUsers event,
    Emitter<GithubState> emit,
  ) async {
    if (state is GithubLoaded) {
      try {
        if (event.searchLogin.isEmpty) {
          filteredUsers = loadedUsers;
        } else {
          filteredUsers = loadedUsers
              .where((user) => user.login
                  .toLowerCase()
                  .contains(event.searchLogin.toLowerCase()))
              .toList();
        }
        emit(GithubLoaded(users: filteredUsers));
      } catch (e) {
        emit(GithubError(error: e.toString()));
      }
    }
  }
}
