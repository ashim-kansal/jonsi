import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/button.dart';
import 'package:kappu/helperfunctions/screen_nav.dart';
import '../../common/painter.dart';
import 'register.dart';

class ProviderOrUser extends StatelessWidget {
  const ProviderOrUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: SignUpPainter(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.verticalSpace,
            Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: const BackButton(
                color: Colors.blue,
              ),
            ),
            Spacer(),
            Image.asset(
              'assets/images/MainHandyman.png',
              fit: BoxFit.fill,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w),
              child: Column(
                children: [
                  10.verticalSpace,
                  CustomButton(
                    buttontext: 'Register as Provider',
                    isLoading: false,
                    onPressed: () {
                      changeScreen(
                          context: context,
                          screen: const SignUp(
                            isprovider: true,
                          ));
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(0.02.sh)),
                  CustomButton(
                    buttontext: 'Register as User',
                    isLoading: false,
                    onPressed: () {
                      changeScreen(
                          context: context,
                          screen: const SignUp(
                            isprovider: false,
                          ));
                    },
                  ),
                ],
              ),
            ),
            10.verticalSpace
          ],
        ),
      ),
    );
  }
}
