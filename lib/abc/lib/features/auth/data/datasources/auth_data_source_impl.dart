
import 'dart:convert';
import 'dart:math';


import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../base/error/failures.dart';
import '../../../../core/hive_helper.dart';
import 'auth_data_source.dart';

class AuthDataSourceImpl extends AuthDataSource {

 // final TheAppleSignIn theAppleSignIn;
  final _firebaseAuth = FirebaseAuth.instance;
    String? verificationId;
   Box? box;

  @override
  Future<Either<Failure,String>> authGetUid() async {
    if(_firebaseAuth.currentUser != null){
      return Right(_firebaseAuth.currentUser!.uid);
    }else{
      return const Left(ServerFailure());
    }

  }

  @override
  Future<Either<Failure,bool>> authIsSIgnIn() async {
    try{
        return Right(_firebaseAuth.currentUser != null);
    }catch(e){
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure,void>> authSignOut() async {
    try{
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
   //   final facebookLogin = FacebookLogin();
     // await facebookLogin.logOut();
     return Right(await _firebaseAuth.signOut());
    } catch(e){
      debugPrint(e.toString());
      return Left(ServerFailure());
    }

  }


/*@override
Future<User?> authWithFacebook() async {
  final facebookLogin = FacebookLogin();
  final response = await facebookLogin.logIn(permissions: [
    FacebookPermission.publicProfile,
    FacebookPermission.email,
  ]);
  switch (response.status) {
    case FacebookLoginStatus.success :
      final accessToken = response.accessToken;
      final userCredential = await _firebaseAuth.signInWithCredential(
        FacebookAuthProvider.credential(accessToken!.token),
      );
      return userCredential.user;
    case FacebookLoginStatus.cancel :
      throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign In Aborted By User');
    case FacebookLoginStatus.error :
      throw FirebaseAuthException(code: 'ERROR_FACEBOOK+LOGIN_FAILED',
          message: response.error!.developerMessage);
    default:
      throw UnimplementedError();
  }
}*/

@override
Future<Either<Failure,User>> authWithGoogle() async {
  try{
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        return userCredential.user != null ? Right(userCredential.user!) :
        const Left(ServerFailure());
      } else {
        return const Left(ServerFailure(code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
            message: 'Missing Google ID Token'));
      }
    } else {
      return const Left(ServerFailure(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign In Aborted By User'));
    }
  } on FirebaseAuthException catch(e){
    debugPrint(e.toString());
  return const Left(ServerFailure());
  }
}



  @override
  Future<Either<Failure,User>> verifyOtp(String otp) async {
    try {
      if(verificationId != null){
        final AuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId!, smsCode: otp);
        final userCredential =  await _firebaseAuth.signInWithCredential( credential);
        return userCredential.user != null? Right(userCredential.user!) :
        Left(ServerFailure()) ;
      }else{
        return  Left(ServerFailure());
      }

    } on Exception catch (exception) {
      debugPrint(e.toString());
    return  Left(ServerFailure()) ;
    }

  }

  @override
  Future<Either<Failure,void>> authWithMobile(String mobile, {Function? callback}) async {

    try {
   return Right(await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: mobile.trim(),
        verificationCompleted:
            (AuthCredential phoneAuthCredential) async {
          await _firebaseAuth
              .signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (FirebaseAuthException authException) {
          Left(ServerFailure());
        },
        codeSent: (String verId, [int? forceResendingToken]) {
          verificationId = verId;
          debugPrint("verification code sent");
        },
        // forceResendingToken: 1,
        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
        },
      ));

    } on Exception catch (exception) {
      debugPrint(exception.toString());
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure,User>> authWithFacebook() {
    // TODO: implement authWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure,User>> authWithApple() async {
  try{
    List<AppleIDAuthorizationScopes> scope= [ AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName] ;
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: scope,
      webAuthenticationOptions: WebAuthenticationOptions(
        // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
        clientId:
        'de.lunaone.flutter.signinwithappleexample.service',

        redirectUri:
        // For web your redirect URI needs to be the host of the "current page",
        // while for Android you will be using the API server that redirects back into your app via a deep link
        Uri.parse(
          'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
        ),
      ),
      state: 'example-state',
    );
    final appleIdCredential = appleCredential;
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    final oAuthProvider = OAuthProvider('apple.com');
    final credential = oAuthProvider.credential(
        idToken: appleIdCredential.identityToken,
        accessToken:
        appleIdCredential.authorizationCode,
        rawNonce: nonce
    );
    final userCredential =
    await _firebaseAuth.signInWithCredential(credential);
    final firebaseUser = userCredential.user!;
    if (scope.contains(AppleIDAuthorizationScopes.fullName)) {
      final fullName = appleIdCredential.givenName;
      if (fullName != null &&
          appleIdCredential.givenName != null &&
          appleIdCredential.familyName != null) {
        final displayName = '${appleIdCredential.givenName} ${appleIdCredential.familyName}';
        await firebaseUser.updateDisplayName(displayName);
      }
    }
    return  Right(firebaseUser);
  }catch(e){
    debugPrint(e.toString());
    return  Left(ServerFailure());
  }
  }

  /*@override
  Future<User?> authWithApple() {
    // TODO: implement authWithApple
    throw UnimplementedError();
  }*/
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<Either<Failure,void>> firstUser(bool isFirst) async {
    try{
      if (!HiveHelper().isBoxOpen()) {
        await HiveHelper().open();
      }
      Box myBox = await HiveHelper().myBox();
      return Right(myBox.put('isFirst', isFirst));
    }on Exception catch(e){
      debugPrint(e.toString());
      return Left(CacheFailure());
    }

  }

  @override
  Future<Either<Failure,bool>> isFirstUser() async {
    try{
      if (!HiveHelper().isBoxOpen()) {
        await HiveHelper().open();
      }
      Box myBox = await HiveHelper().myBox();
      return Right(myBox.get('isFirst', defaultValue: true));
    }catch(e){
      debugPrint(e.toString());
      return Left(CacheFailure());
    }

  }
}
