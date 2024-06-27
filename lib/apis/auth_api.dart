import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitterclone/core/core.dart';
import 'package:twitterclone/core/providers.dart';


//WANT TO SIGN UP, GET DATA ----> _account
//ACCESS USER DATA DATA ----> model.User

final authApiProvider = Provider((ref) {
  final account = ref.watch(appwriteAccountProvider);
  return AuthApi(account:account);
});

abstract class IAuthApi{
  FutureEither<model.User> signUp ({
    required String email,
    required String password,
  });
  FutureEither<model.Session> login ({
    required String email,
    required String password,
  });
}

class AuthApi implements IAuthApi{
  final Account _account;
  AuthApi({required Account account}) :_account=account;
  @override
  FutureEither<model.User> signUp({required String email, required String password})async {
   try{
    final account = await _account.create(userId: ID.unique(),
         email: email,
         password: password
     );
         return right(account);
   }on AppwriteException catch(e,stackTrace){
     return left(Failure(e.message ?? 'Unexpected error occured', stackTrace));
   }


   catch(e, stackTrace){
     return left(Failure(e.toString(), stackTrace));
   }

  }

  @override
  FutureEither<model.Session> login({required String email, required String password}) async {
    try{
      final session = await _account.createEmailPasswordSession(
          email: email,
          password: password
      );
      return right(session);
    }on AppwriteException catch(e,stackTrace){
      return left(Failure(e.message ?? 'Unexpected error occured', stackTrace));
    }


    catch(e, stackTrace){
      return left(Failure(e.toString(), stackTrace));
    }

  }

}