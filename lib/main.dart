import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitterclone/features/auth/view/signup_view.dart';
import 'package:twitterclone/theme/theme.dart';

import 'features/auth/view/login_view.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:AppTheme.theme,
      home: const SignUpView(),
    );
  }
}

