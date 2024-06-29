import 'package:flutter/material.dart';
import 'package:twitterclone/theme/pallete.dart';

class AppTheme {
  static ThemeData theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.backgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: Pallete.whiteColor),
      titleTextStyle: TextStyle(color: Pallete.whiteColor, fontSize: 20),
      toolbarTextStyle: TextStyle(color: Pallete.whiteColor, fontSize: 18),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Pallete.blueColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(90),
      )
    ),
  );
}
