import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/helperfunctions/screen_nav.dart';
import 'package:kappu/screens/login/widgets/google_login_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'register.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class SocailSignUpScreen extends StatelessWidget {
  final plugin = FacebookLogin(debug: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/images/colorfulLogo.png",
                        height: 80.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "URBAN MALTA",
                    style: TextStyle(
                      color: Color(0xFF4995EB),
                      fontSize: 18,
                      fontFamily: 'Montserrat-Bold',
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Create an account and discover thousands of relevant services, connet with freelancers, and check out easily on Urban Malta trusted platform.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Montserrat-Regular',
                      color: Color(0xFF7B7D83),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: ScreenUtil().screenHeight * 0.05,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            side: new BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().screenHeight * 0.025),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Opacity(
                            opacity: 0,
                            child: Icon(Icons.arrow_forward_ios),
                          ),
                          Text(
                            "Connect with Apple",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontFamily: 'Montserrat-Medium',
                            ),
                          ),
                          Image.asset('assets/icons/app.png', scale: 1.0),
                        ],
                      ),
                      onPressed: () {
                        changeScreen(
                            context: context,
                            screen: const SignUp(
                              isprovider: true,
                            ));
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  FacebookLoginButton(
                      text: 'Connect with Facebook', onTap: (){
                        print('fb click');
                        doFbLogin(context);
                  },),
                  const SizedBox(height: 10),
                  GoogleLoginButton(action: false, text: 'Connect with Google'),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: ScreenUtil().screenHeight * 0.05,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().screenHeight * 0.025)),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Opacity(
                            opacity: 0,
                            child: Icon(Icons.arrow_forward_ios),
                          ),
                          Text(
                            "Sign in with Email",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontFamily: 'Montserrat-Medium',
                            ),
                          ),
                          Image.asset('assets/icons/arw.png', scale: 1.0),
                        ],
                      ),
                      onPressed: () {
                        print('aaaa');
                        changeScreen(
                            context: context,
                            screen: const SignUp(
                              isprovider: true,
                            ));
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You agree to Urban Malta ',
                        style: TextStyle(
                            color: const Color(0xFF7b7d83),
                            fontSize: ScreenUtil().setWidth(13),
                            fontFamily: 'Montserrat-Medium'),
                      ),
                      GestureDetector(
                        onTap: () async {
                          String url = "https://urbanmalta.com/privacy-policy";
                          var urllaunchable = await canLaunchUrlString(url); //canLaunch is from url_launcher package
                          if(urllaunchable){
                            await launchUrlString(url); //launch is ffrom url_launcher package to launch URL
                          }else{
                            print("URL can't be launched.");
                          }
                        },
                        child: const Text(
                          'Terms of Service',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: Color(0xFF4995EB)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sign up",
                        style: TextStyle(
                          color: Color(0xFF4995EB),
                          fontSize: 14,
                          fontFamily: 'Montserrat-Bold',
                        ),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                          color: Color(0xFF4995EB),
                          fontSize: 14,
                          fontFamily: 'Montserrat-Bold',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  doFbLogin(context) async{
    final result = await this.plugin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    if (result.status == FacebookLoginStatus.success) {
      // final OAuthCredential credential =
      // FacebookAuthProvider.credential(result.accessToken!.token);
      // final a = await _auth.signInWithCredential(credential);
      // await _instance.getUserData().then((userData) async {
      //   await _auth.currentUser!.updateEmail(userData['email']);
      // });
      return null;
    } else if (result.status == FacebookLoginStatus.cancel) {
      return 'Login cancelled';
    } else {
      return 'Error';
    }
    await _updateLoginInfo();
  }

  Future<void> _updateLoginInfo() async {
    print('_updateLoginInfo');
    final token = await plugin.accessToken;
    FacebookUserProfile? profile;
    String? email;
    String? imageUrl;

    if (token != null) {
      profile = await plugin.getUserProfile();
      if (token.permissions.contains(FacebookPermission.email.name)) {
        email = await plugin.getUserEmail();
      }
      imageUrl = await plugin.getProfileImageUrl(width: 100);
    print('token -->'+token.userId);

    }


}

}
