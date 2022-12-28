import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/helperfunctions/screen_nav.dart';
import 'package:kappu/screens/login/widgets/google_login_button.dart';
import 'register.dart';

class SocailSignUpScreen extends StatelessWidget {
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
                        "assets/images/first-screen-logo.png",
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
                      action: false, text: 'Connect with Facebook'),
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
                        onTap: () {},
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
                        "Skip",
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
}
