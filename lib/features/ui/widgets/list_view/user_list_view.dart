import 'package:flutter/material.dart';
import '../../../model/user/user.dart';

class UserListView extends StatelessWidget {
  final List<User> users;
  UserListView({required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          leading: Image.network(user.avatarUrl),
          title: Text(user.login),
          subtitle: Text('${user.followers} / ${user.following}'),
        );
      },
    );
  }
}
