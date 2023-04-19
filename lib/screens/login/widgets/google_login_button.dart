import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../common/bottom_nav_bar.dart';
import '../google_signin.dart';

class GoogleLoginButton extends StatefulWidget {
  final bool action;
  final String text;
  final Function(GoogleSignInAccount) onTap;
  const GoogleLoginButton({Key? key, required this.action, required this.text,required this.onTap})
      : super(key: key);

  @override
  State<GoogleLoginButton> createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  Future signinusinggoogle() async {
    final user = await GoogleSignInApi.login();
    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Error signing in')));
    } else {
      print(user.id);
      print(user.displayName);
      print(user.email);
      widget.onTap(user);
      await GoogleSignInApi.logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight * 0.05,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(ScreenUtil().screenHeight * 0.025)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Opacity(
              opacity: 0,
              child: Icon(Icons.apple),
            ),
            Text(
              widget.text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 14.sp,
                fontFamily: 'Montserrat-Medium',
              ),
            ),
            Image.asset('assets/icons/g.png', scale: 1.0),
          ],
        ),
        onPressed: () async {
          signinusinggoogle();
        },
      ),
    );
  }
}

class FacebookLoginButton extends StatefulWidget {
  Function()? onTap;
  final String text;
  FacebookLoginButton(
      {Key? key, this.onTap, required this.text})
      : super(key: key);

  @override
  State<FacebookLoginButton> createState() => _FacebookLoginButtonState();
}

class _FacebookLoginButtonState extends State<FacebookLoginButton> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight * 0.05,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xfa3B5999)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(ScreenUtil().screenHeight * 0.025)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Opacity(
              opacity: 0,
              child: Icon(Icons.apple),
            ),
            Text(
              widget.text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 14.sp,
                fontFamily: 'Montserrat-Medium',
              ),
            ),
            Image.asset('assets/icons/f.png', scale: 1.0),
          ],
        ),
        onPressed: widget.onTap,
      ),
    );
  }
}
