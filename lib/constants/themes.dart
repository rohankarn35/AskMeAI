import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: Colors.white,
        onPrimary: Colors.deepPurple,
        secondary: Colors.purple,
        onSecondary: Colors.black,
        
      ),
);

final darkTheme = ThemeData.dark().copyWith(
  colorScheme: ThemeData.dark().colorScheme.copyWith(
       primary: Colors.black,
        onPrimary: Colors.white,
        secondary: Colors.teal.shade400,
        onSecondary: Colors.white,
      ),
);
