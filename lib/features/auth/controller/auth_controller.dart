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
          followers: [],
          following: [],
          profilePic: '',
          bannerPic: '',
          uid: '',
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

}








