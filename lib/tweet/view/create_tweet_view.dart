import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitterclone/common/common.dart';
import 'package:twitterclone/constants/assets_constants.dart';
import 'package:twitterclone/core/utils.dart';
import 'package:twitterclone/features/auth/controller/auth_controller.dart';
import 'package:twitterclone/theme/pallete.dart';
import 'dart:io';

import '../../common/rounded_small_button.dart';

class CreateTweetScreen extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const CreateTweetScreen());
  const CreateTweetScreen({super.key});

  @override
  ConsumerState<CreateTweetScreen> createState() => _CreateTweetScreenState();
}

class _CreateTweetScreenState extends ConsumerState<CreateTweetScreen> {
  final tweetTextController=TextEditingController();
   List<File> images=[];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tweetTextController.dispose();
  }

  void onPickImages()async{
    images=await pickImages();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    return Scaffold(
      appBar:AppBar(
        leading:IconButton(
          onPressed:(){
            Navigator.pop(context);
          },
          icon:Icon(Icons.close,size:30 ) ,
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
                    SizedBox(width: 15,),
                    Expanded(
                      child: TextField(
                        controller: tweetTextController,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          hintText: "What's happening ?",
                          hintStyle: TextStyle(
                            color: Pallete.greyColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                          ),
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                      ),
                    )
              ],
            ),
                if (images.isNotEmpty)
                  CarouselSlider(
                    items: images.map((file) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Image.file(file),
                      );
                    }).toList(),
                    options: CarouselOptions(
                     height: 400,
                      enableInfiniteScroll: false
                    ),
                  ),
              ],
                  ),
          )
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top:BorderSide(
              width: .3,
              color:Pallete.greyColor,
            ),
          ),
        ),
        child: Row(
          children: [
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(bottom: 10,left: 10,right: 10),
            child: GestureDetector(
                onTap:onPickImages,
                child: SvgPicture.asset(AssetsConstants.galleryIcon)),
          ),Padding(
            padding: const EdgeInsets.all(8.0).copyWith(bottom: 10,left: 10,right: 10),
            child: SvgPicture.asset(AssetsConstants.gifIcon),
          ),Padding(
            padding: const EdgeInsets.all(8.0).copyWith(bottom: 10,left: 10,right: 10),
            child: SvgPicture.asset(AssetsConstants.emojiIcon),
          ),
        ],),
      ),
    );
  }
}
