import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitterclone/common/common.dart';
import 'package:twitterclone/common/loading_page.dart';
import 'package:twitterclone/features/auth/controller/auth_controller.dart';
import 'package:twitterclone/features/auth/view/signup_view.dart';
import 'package:twitterclone/features/home/view/home_view.dart';
import 'package:twitterclone/theme/theme.dart';

import 'features/auth/view/login_view.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,ref) {
    return MaterialApp(
      theme:AppTheme.theme,
      home: ref.watch(currentUserAccountProvider).when(
          data: (user){
        //     if(user!=null){
        //        return const HomeView();
        // }
            return SignUpView();
      },
          error: (error,st)=>ErrorPage(error: error.toString()),
          loading: ()=>LoadingPage()),
    );
  }
}

