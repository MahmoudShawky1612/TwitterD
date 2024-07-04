import 'dart:async';
import 'package:appwrite/models.dart' as model;
import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitterclone/constants/appwrite_constants.dart';
import 'package:twitterclone/core/core.dart';
import 'package:twitterclone/core/providers.dart';
import 'package:twitterclone/user_model.dart';


final userApiProvider= Provider((ref) {
  return UserApi(db:ref.watch(appwriteDatabaseProvider) );
});


abstract class IUserApi {
  FutureEitherVoid saveUserData( UserModel userModel);
  Future<model.Document> getUserData(String uid);
}

class UserApi implements IUserApi {
  final Databases _db;

  UserApi({required Databases db}) : _db = db;

  @override
  FutureEitherVoid saveUserData( UserModel userModel) async {
    try {
      await _db.createDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.collectionId,
        documentId: userModel.uid,
        data: userModel.toMap(), // Assuming toMap is meant to be toJson
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(e.message ?? "Unexpected Error occurred", st),
      );
    } catch (e, st) {
      return left(
        Failure(e.toString(), st),
      );
    }
  }

  @override
  Future<model.Document> getUserData(String uid) {
    return _db.getDocument(
          databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.collectionId,
        documentId: uid);
  }
}



