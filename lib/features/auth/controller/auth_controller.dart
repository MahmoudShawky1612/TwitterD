import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitterclone/apis/auth_api.dart';
import 'package:twitterclone/core/utils.dart';
import 'package:twitterclone/features/auth/view/login_view.dart';
import 'package:twitterclone/features/home/view/home_view.dart';

final authControllerProvider = StateNotifierProvider<AuthController,bool>((ref) {
  return AuthController(authApi: ref.watch(authApiProvider));
});
class AuthController extends StateNotifier<bool>{
  final AuthApi _authApi;
  AuthController({required AuthApi authApi}): _authApi=authApi ,super(false);

  void signUp ({
    required String email,
    required String password,
    required BuildContext context,
})async{
    state=true;
    final res= await _authApi.signUp(email: email, password: password);
    res.fold((l) =>showSnackBar(context, l.message) , 
    (r) => {
      showSnackBar(context, "Account created ! please log in"),
      Navigator.push(context, LoginView.route()),
            });
    state=false;

  }void login ({
    required String email,
    required String password,
    required BuildContext context,
})async{
    state=true;
    final res= await _authApi.login(email: email, password: password);
    res.fold((l) =>showSnackBar(context, l.message) , (r) => {
      Navigator.push(context, HomeView.route()),
    });
    state=false;

  }

}








