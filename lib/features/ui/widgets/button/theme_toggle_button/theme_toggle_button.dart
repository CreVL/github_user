import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users/features/theme/theme_cubit.dart';

class ThemeToggleButton extends StatelessWidget {
  final bool isTheme;

  const ThemeToggleButton({super.key, required this.isTheme});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isTheme ? Icons.brightness_7 : Icons.brightness_4),
      onPressed: () {
        final currentBrightness = Theme.of(context).brightness;
        context.read<ThemeCubit>().toggleTheme(
            currentBrightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark);
      },
    );
  }
}
