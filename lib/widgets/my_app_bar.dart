import 'package:flutter/material.dart';
import '../providers/active_theme_provider.dart';
import 'theme_switch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(
        'AskMe AI',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary, 
        ),
      ),
      centerTitle: true,
      elevation: 0,
      actions: [
        Row(
          children: [
            Consumer(
              builder: (context, ref, child) => Icon(
                ref.watch(activeThemeProvider) == Themes.dark
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
            ),
            
            const SizedBox(width: 8),
            const ThemeSwitch(),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
