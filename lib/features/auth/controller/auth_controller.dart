import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitterclone/apis/auth_api.dart';
import 'package:twitterclone/core/utils.dart';
import 'package:twitterclone/features/auth/view/login_view.dart';
import 'package:twitterclone/features/home/view/home_view.dart';
import 'package:appwrite/models.dart' as model;
import 'package:twitterclone/user_model.dart';

import '../../../apis/user_api.dart';


final authControllerProvider = StateNotifierProvider<AuthController,bool>((ref) {
  return AuthController(authApi: ref.watch(authApiProvider), userApi: ref.watch(userApiProvider));
});

final currentUserDetailsProvider = FutureProvider((ref){
  final currentUserId= ref.watch(currentUserAccountProvider).value!.$id;
  final userDetails=ref.watch(userDetailsProvider(currentUserId));
  return userDetails.value;
});

final userDetailsProvider = FutureProvider.family((ref,String uid){
  final authController= ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final currentUserAccountProvider =FutureProvider((ref)  {
  final authController= ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool>{
  final AuthApi _authApi;
  final UserApi _userApi;
  AuthController({required AuthApi authApi,required UserApi userApi}): _authApi=authApi,_userApi=userApi ,super(false);



  void signUp ({
    required String email,
    required String password,
    required BuildContext context,
})async{
    state=true;
    final res= await _authApi.signUp(email: email, password: password);
    res.fold((l) =>showSnackBar(context, l.message) ,

    (r) async{
      UserModel userModel =UserModel(email: email, name: getNameFromEMail(email),
          followers:  [],
          following: [],
          profilePic: '',
          bannerPic: '',
          uid: r.$id,
          bio: '',
          isTwitterBlue: false);
      final res2 = await _userApi.saveUserData(userModel);
      return res2.fold((l) => showSnackBar(context, l.message), (r) {
        showSnackBar(context, "Account created ! please log in");
        Navigator.push(context, LoginView.route());
      });

            });
    state=false;

  }
  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authApi.login(
      email: email,
      password: password,
    );
    state = false;
    res.fold(
          (l) => showSnackBar(context, l.message),
          (r) {
        Navigator.push(context, HomeView.route());
      },
    );
  }

  Future<model.User?> currentUser() => _authApi.currentUserAccount();

  Future<UserModel> getUserData(String uid)async{
    final document = await _userApi.getUserData(uid);
    final updatedUser =  UserModel.fromMap(document.data);
    return updatedUser;
  }

}








