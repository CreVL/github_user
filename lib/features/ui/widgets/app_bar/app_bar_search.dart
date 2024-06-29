import 'package:flutter/material.dart';

class AppBarSearch extends StatelessWidget {
  final Function(String text)? searchChanged;

  const AppBarSearch({super.key, required this.searchChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: searchChanged,
            decoration: const InputDecoration(
              hintText: 'Search by login...',
              contentPadding: EdgeInsets.all(10.0),
              suffixIcon: SizedBox(
                child: Icon(
                  Icons.search,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
