import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class GoogleSignInApi {
  static final _googlesignin = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googlesignin.signIn();
}

class AppleAuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<User> signInWithApple(List<Scope> list,
      {List<Scope> scopes = const []}) async {
    // 1. perform the sign-in request
    final result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential!;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken!),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode!),
        );
        final userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        final firebaseUser = userCredential.user!;
        if (scopes.contains(Scope.fullName)) {
          final fullName = appleIdCredential.fullName;
          if (fullName != null &&
              fullName.givenName != null &&
              fullName.familyName != null) {
            final displayName = '${fullName.givenName} ${fullName.familyName}';
            await firebaseUser.updateDisplayName(displayName);
          }
        }
        return firebaseUser;
      case AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      default:
        throw UnimplementedError();
    }
  }
}

class FacebookAuthService {
  static final FacebookLogin facebookSignIn = FacebookLogin();

  Future<FacebookAccessToken?> fblogin() async {
    final FacebookLoginResult result =
        await facebookSignIn.logIn(customPermissions: ['email']);

    switch (result.status) {
      case FacebookLoginStatus.success:
        final FacebookAccessToken? accessToken = result.accessToken;
        // _showMessage('''
        //  Logged in!

        //  Token: ${accessToken.token}
        //  User id: ${accessToken.userId}
        //  Expires: ${accessToken.expires}
        //  Permissions: ${accessToken.permissions}
        //  Declined permissions: ${accessToken.declinedPermissions}
        //  ''');
        return accessToken;
      case FacebookLoginStatus.cancel:
        // _showMessage('Login cancelled by the user.');
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      case FacebookLoginStatus.error:
        // _showMessage('Something went wrong with the login process.\n'
        // 'Here\'s the error Facebook gave us: ${result.errorMessage}');
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: FacebookLoginStatus.error.toString(),
        );
      default:
        throw UnimplementedError();
    }
  }
}
