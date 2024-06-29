part of 'github_bloc.dart';

@immutable
abstract class GithubState {}

class GithubInitial extends GithubState {}

class GithubSearchLoading extends GithubState {}

class GithubLoading extends GithubState {
  final List<User> mockedUsers;

  GithubLoading({required this.mockedUsers});
}

class GithubLoaded extends GithubState {
  final List<User> users;

  GithubLoaded({required this.users});
}

class GithubError extends GithubState {
  final String error;

  GithubError({required this.error});
}
