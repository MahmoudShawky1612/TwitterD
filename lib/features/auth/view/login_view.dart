import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitterclone/common/loading_page.dart';
import 'package:twitterclone/common/rounded_small_button.dart';
import 'package:twitterclone/features/auth/view/signup_view.dart';
import 'package:twitterclone/features/auth/widgets/auth_field.dart';
import 'package:twitterclone/theme/pallete.dart';

import '../../../constants/UIConstants.dart';
import '../controller/auth_controller.dart';

class LoginView extends ConsumerStatefulWidget {
  static route()=>
    MaterialPageRoute(builder: (context) => const LoginView());

  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final appBar=UIConstants.appBar();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onLogin(){
    ref.watch(authControllerProvider.notifier).login(email: emailController.text,
        password: passwordController.text,
        context: context);
  }
  @override
  Widget build(BuildContext context) {
    final isLoading= ref.watch(authControllerProvider);
    return Scaffold(
      appBar:appBar,

      body: isLoading ? Loader(): Center(
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 20,),
          child: Column(
            children: [
              //textfield1
              AuthField(controller: emailController, hintText: "Email"),
              SizedBox(height: 20,),

              //textfield2
              AuthField(controller: passwordController, hintText: "Password"),
              SizedBox(height: 40,),
              //button
              Align(
                alignment: Alignment.topRight,
                child: RoundedSmallButton(onTap: onLogin,
                    label: "Done",
                ),
              ),
              SizedBox(height: 40,),
              //textspan
              RichText(text: TextSpan(text: "Don't have an account?",
              style: TextStyle(fontSize: 16),
                children: [
                  TextSpan(
                    text: " Sign Up",
                    style: TextStyle(
                      fontSize: 16,
                      color: Pallete.blueColor,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = (){
                      Navigator.push(context, SignUpView.route());
                    },
                  ),
                ],
              ),
              )
            ],
          ),
          ),
        ),
      ),
    );
  }
}

