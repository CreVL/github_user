part of 'github_bloc.dart';

@immutable
abstract class GithubEvent {}

class FetchGithubUsers extends GithubEvent {}

class SearchGithubUsers extends GithubEvent {
  final String searchLogin;

  SearchGithubUsers(this.searchLogin);
}
