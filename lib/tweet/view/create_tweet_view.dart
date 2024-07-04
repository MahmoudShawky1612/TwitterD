import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitterclone/common/common.dart';
import 'package:twitterclone/features/auth/controller/auth_controller.dart';
import 'package:twitterclone/theme/pallete.dart';

import '../../common/rounded_small_button.dart';

class CreateTweetScreen extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const CreateTweetScreen());
  const CreateTweetScreen({super.key});

  @override
  ConsumerState<CreateTweetScreen> createState() => _CreateTweetScreenState();
}

class _CreateTweetScreenState extends ConsumerState<CreateTweetScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    return Scaffold(
      appBar:AppBar(
        leading:IconButton(
          onPressed:(){},
          icon:Icon(Icons.close,size:30) ,
        ),
        actions: [
          RoundedSmallButton(onTap:(){},label:"Tweet",backgroundColor: Pallete.blueColor,textColor: Pallete.whiteColor,),
        ],
      ),
      body:currentUser == null ? const Loader() : SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                   CircleAvatar(
                     backgroundImage: NetworkImage(currentUser.profilePic ),
                     radius: 20,
                ),
              ],
            ),
                    ],
                  ),
          )),
    );
  }
}
