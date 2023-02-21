import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/button.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/helperfunctions/screen_nav.dart';
import '../../common/painter.dart';
import 'register.dart';

class ProviderOrUser extends StatelessWidget {
  const ProviderOrUser(
      {Key? key,
      this.loginType = '',
      this.socialId = '',
      this.name = '',
      this.email = ''})
      : super(key: key);
  final String loginType;
  final String socialId;
  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      "assets/icons/logo.png",
                      height: 90.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  30.verticalSpace,
                  CustomButton(
                    buttontext: 'Register as Provider',
                    isLoading: false,
                    onPressed: () {
                      changeScreen(
                          context: context,
                          screen: SignUp(
                            isprovider: true,
                            loginType: loginType,
                            name: name,
                            socialId: socialId,
                            email: email,
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
                          screen: SignUp(
                            isprovider: false,
                            loginType: loginType,
                            name: name,
                            socialId: socialId,
                            email: email,
                          ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
