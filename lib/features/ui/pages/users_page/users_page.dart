import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users/features/theme/theme_cubit.dart';
import 'package:github_users/features/ui/widgets/button/theme_toggle_button/theme_toggle_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../bloc/github_bloc.dart';
import '../../widgets/app_bar/app_bar_search.dart';
import '../../widgets/list_view/user_list_view.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final githubBloc = BlocProvider.of<GithubBloc>(context);
    final isDarkTheme = context.watch<ThemeCubit>().state.isDark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Users'),
        actions: [
          ThemeToggleButton(isTheme: isDarkTheme),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            BlocBuilder<GithubBloc, GithubState>(
              builder: (context, state) {
                return state is GithubLoaded
                    ? AppBarSearch(
                        searchChanged: (query) {
                          githubBloc.add(SearchGithubUsers(query));
                        },
                      )
                    : Container();
              },
            ),
            const TabBar(
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 4.0, color: Colors.cyan),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              tabs: [
                Tab(text: 'A-H'),
                Tab(text: 'I-P'),
                Tab(text: 'Q-Z'),
              ],
            ),
            Expanded(
              child: BlocBuilder<GithubBloc, GithubState>(
                builder: (context, state) {
                  if (state is GithubLoading) {
                    return Center(
                      child: Skeletonizer(
                        enabled: true,
                        child: UserListView(users: state.mockedUsers),
                      ),
                    );
                  } else if (state is GithubLoaded) {
                    return TabBarView(
                      children: [
                        UserListView(
                          users: state.users
                              .where((user) =>
                                  user.login[0].toUpperCase().compareTo('I') <
                                  0)
                              .toList(),
                        ),
                        UserListView(
                          users: state.users
                              .where((user) =>
                                  user.login[0].toUpperCase().compareTo('I') >=
                                      0 &&
                                  user.login[0].toUpperCase().compareTo('Q') <
                                      0)
                              .toList(),
                        ),
                        UserListView(
                          users: state.users
                              .where((user) =>
                                  user.login[0].toUpperCase().compareTo('Q') >=
                                  0)
                              .toList(),
                        ),
                      ],
                    );
                  } else if (state is GithubError) {
                    return Center(child: Text(state.error));
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
