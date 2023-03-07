import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kappu/common/custom_progress_bar.dart';
import 'package:kappu/common/customtexts.dart';
import 'package:kappu/common/dialogues.dart';
import 'package:kappu/common/painter.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/helperfunctions/screen_nav.dart';
import 'package:kappu/models/serializable_model/signedinprovider.dart';
import 'package:kappu/provider/provider_provider.dart';
import 'package:kappu/provider/userprovider.dart';
import 'package:kappu/screens/login/widgets/google_login_button.dart';
import 'package:kappu/screens/reset_password/enter_email_screen.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';
import '../../common/bottom_nav_bar.dart';
import '../../constants/icons.dart';
import '../../models/serializable_model/signed_in_user.dart';
import '../../net/base_dio.dart';
import '../../net/http_client.dart';
import '../register/widgets/text_field.dart';
import '../register/provider_or_user.dart';
import 'google_signin.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart' hide ButtonStyle;

class LoginScreen extends StatefulWidget {
  bool isFromOtherScreen;

  LoginScreen({this.isFromOtherScreen = false});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  bool _showPassword = true;
  bool signin = false;
  bool isLoading = false;
  final _formState = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVaildEmail = true;
  bool isValidPassword = true;

  @override
  initState() {}


  Future<void> signInWithApple(BuildContext context) async {
    try {
      final authService = AppleAuthService();
      final user =
          await authService.signInWithApple([Scope.email, Scope.fullName]);
      print('uid: ${user.uid}');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const BottomNavBar(isprovider: false)));
    } catch (e) {
      // TODO: Show alert here
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var children2 = [
      120.verticalSpace,
      returnLogo(context),
      15.verticalSpace,
      customtext(
        buttontext: 'Welcome to Urban Malta',
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      15.verticalSpace,
      CustomTextFormField(
        controller: emailController,
        validator: (value) =>
        isEmail(value!) ? null : "Check your email",
        keyboardType: TextInputType.emailAddress,
        prefixIcon:  ImageIcon(AssetImage('assets/icons/ft-4.png'), color: AppColors.app_color,),
        suffixIcon: isEmail(email) ? checkIcon : null,
        hintText: 'Enter Email',
        isValid: isVaildEmail,
        onChanged: (value) {
          if (value.isNotEmpty && isEmail(value)) {
            isVaildEmail = true;
          } else {
            isVaildEmail = false;
          }
          setState(() {});
        },
      ),

      // ElevatedTextFormField(
      //   controller: emailController,
      //   isValid: isVaildEmail,
      //   keyboardType: TextInputType.emailAddress,
      //   prefixIcon: emailIcon,
      //   suffixIcon: isEmail(email) ? checkIcon : null,
      //   showPassword: false,
      //   hintText: 'Enter Email',
      //   onChanged: (value) {
      //     if (isEmail(value)) {
      //       isVaildEmail = true;
      //     } else {
      //       isVaildEmail = false;
      //     }
      //     email = value;
      //     setState(() {});
      //   },
      // ),
      15.verticalSpace,
      CustomTextFormField(
        showPassword: _showPassword,
        controller: passwordController,
        keyboardType: TextInputType.visiblePassword,
        isValid: isValidPassword,
        onChanged: (value) {
          if (value.isNotEmpty) {
            isValidPassword = true;
          } else {
            isValidPassword = false;
          }
          setState(() {});
        },
        validator: (value) {
          if (value.isNullOrEmpty) {
            return "Enter Your password";
          }
        },
        prefixIcon: passwordIcon,
        suffixIcon: GestureDetector(
            onTap: () {
              _showPassword = !_showPassword;
              setState(() {});
            },
            child: _showPassword
                ? passwordEyeIcon
                : passwordGreenEyeIcon),
        hintText: "Enter Password",
      ),

      // Material(
      //     borderRadius: BorderRadius.circular(25),
      //     elevation: 3,
      //     shadowColor: Colors.black.withOpacity(0.14),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         TextFormField(
      //           controller: passwordController,
      //           textAlignVertical: TextAlignVertical.center,
      //           onChanged: (value) {
      //             if (value.isNotEmpty) {
      //               isValidPassword = true;
      //             } else {
      //               isValidPassword = false;
      //             }
      //             setState(() {});
      //           },
      //           decoration: InputDecoration(
      //             prefixIcon: Padding(
      //               padding:
      //                   const EdgeInsetsDirectional.only(start: 20, end: 15),
      //               child: passwordIcon,
      //             ),
      //             // prefixIconConstraints:
      //             //     BoxConstraints(maxHeight: ScreenUtil().setWidth(20)),
      //             suffixIcon: Padding(
      //               padding: const EdgeInsets.only(right: 12.0),
      //               child: GestureDetector(
      //                   onTap: () {
      //                     _showPassword = !_showPassword;
      //                     setState(() {});
      //                   },
      //                   child: _showPassword
      //                       ? passwordEyeIcon
      //                       : passwordGreenEyeIcon),
      //             ),
      //             suffixIconConstraints: const BoxConstraints(maxHeight: 25),
      //             suffixIconColor: Colors.green,
      //             hintText: 'Enter Password',
      //             hintStyle: const TextStyle(
      //               fontWeight: FontWeight.w500,
      //             ),
      //             border: InputBorder.none,
      //           ),
      //           obscureText: _showPassword,
      //           obscuringCharacter: '*',
      //         ),
      //         if (!isValidPassword)
      //           const Text(
      //             'Please enter your password',
      //             style: TextStyle(color: AppColors.red),
      //           )
      //       ],
      //     )),
      10.verticalSpace,
      Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {
            changeScreen(context: context, screen: const EnterEmailScreen());
          },
          child: customtext(
            buttontext: 'Forgot Your Password?',
            fontWeight: FontWeight.w500,
            color: AppColors.app_color,
            fontSize: 10,
          ),
        ),
      ),
      15.verticalSpace,
      SizedBox(
        height: ScreenUtil().screenHeight * 0.05,
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.app_color),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(ScreenUtil().screenHeight * 0.025),
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
                "Sign In",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat-Light',
                ),
              ),
              Image.asset('assets/icons/arw.png', scale: 1.0),
            ],
          ),
          onPressed: () async {
            if (passwordController.text.isEmpty ||
                emailController.text.isEmpty || !isEmail(emailController.text)) {
              return;
            }
            if (!signin) {
              signin = true;
              isLoading = true;
              setState(() {});
              Map<String, dynamic> body = {
                'email': emailController.text.trim(),
                'password': passwordController.text,
                'fcm_token': StorageManager().fcmToken,
                'os': Platform.isAndroid ? 'android' : 'ios',
              };
              await HttpClient().signin(body).then((loginresponse) async {
                if (loginresponse.data['isSuccess'] == true) {
                  StorageManager().accessToken =
                      "" + loginresponse.data['data']['token'];
                  StorageManager().userId =
                      loginresponse.data['data']['user']['id'];
                  StorageManager().name = "" +
                      loginresponse.data['data']['user']['first_name'] ;
                  StorageManager().email =
                      "" + loginresponse.data['data']['user']['email'];
                  StorageManager().isProvider = loginresponse.data['data']
                          ['user']['is_provider']
                      ? true
                      : false;
                  StorageManager().nationality =
                      "" + loginresponse.data['data']['user']['nationality'];
                  StorageManager().language =
                      "" + loginresponse.data['data']['user']['languages'];
                  StorageManager().stripeId =
                      "" + loginresponse.data['data']['user']['customer_stripe_id'];
                  StorageManager().userImage =
                      "" + loginresponse.data['data']['user']['profile_pic']!=null?"" + loginresponse.data['data']['user']['profile_pic'] : "";
                  // StorageManager().phone = ""+loginresponse.data['data']['user']['phone_number'];
                }
                signin = false;
                isLoading = false;
                print('aaaaa');
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                  return BottomNavBar(
                    isprovider: loginresponse.data['data']['user']['is_provider'],
                  );
                }), (r){
                  return false;
                });

                // widget.isFromOtherScreen
                //     ? Navigator.pop(context, "1")
                //     : changeScreenReplacement(
                //         context,
                //         BottomNavBar(
                //           isprovider: loginresponse.data['data']['user']['is_provider'],
                //         ));
                // Navigator.pop(context);
              }).catchError((error) {
                BaseDio.getDioError(error);
                signin = false;
                isLoading = false;
                setState(() {});
                showAlertDialog(
                    error: "Please check the credentials", errorType: "Alert");
              });
            }
          },
        ),
      ),
      Visibility(visible: Platform.isIOS, child: 10.verticalSpace),
      Visibility(
        visible: Platform.isIOS,
        child: SizedBox(
          height: ScreenUtil().screenHeight * 0.05,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().screenHeight * 0.025),
                  side: const BorderSide(width: 1, color: Colors.black),
                ),
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
                  "Sign In With Apple",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat-Light',
                  ),
                ),
                Image.asset('assets/icons/app.png', scale: 1.0),
              ],
            ),
            onPressed: () async {
              signInWithApple(context);
            },
          ),
        ),
      ),
      10.verticalSpace,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Expanded(
          //     child: FacebookLoginButton(
          //   text: 'Facebook',
          //   onTap: () {
          //     facebookSignin();
          //   },
          // )),
          // 15.horizontalSpace,
          Expanded(
              child: GoogleLoginButton(
            action: false,
            text: 'Google',
            onTap: (user) {
              socialLogin('google', user.id, user.email, user.displayName!);
            },
          )),
        ],
      ),
      20.verticalSpace,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Don\'t have an account? ',
            style: TextStyle(
                color: const Color(0xFF767F94),
                fontSize: ScreenUtil().setWidth(13)),
          ),
          GestureDetector(
            onTap: () {
              changeScreen(context: context, screen: const ProviderOrUser());
            },
            child: const Text(
              'Signup',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: AppColors.app_color),
            ),
          )
        ],
      ),
    ];
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Form(
                  key: _formState,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: children2,
                    ),
                  )),
              if (isLoading) const CustomProgressBar()
            ],
          ),
        ),
      ),
    );
  }

  Future checkaddusertoken(int id) async {
    var token = await FirebaseMessaging.instance.getToken();
    await HttpClient().checktoken(id.toString()).then((value) {
      print("!!!!!!@@@@@@@@@#########");
      print(value.data['registration_id']);
      if (value.data['registration_id'] != token) {
        Map<String, dynamic> updatebody = {
          'registration_id': token,
          'type': Platform.isAndroid ? 'android' : 'ios'
        };
        HttpClient()
            .updatetoken(id.toString(), updatebody)
            .then((value) => {print(value)})
            .catchError((e) {
          print(e);
        });
      }
    }).catchError((e) async {
      print('token not set');

      print(token);
      Map<String, dynamic> body = {
        'user': id,
        'registration_id': token,
        'type': Platform.isAndroid ? 'android' : 'ios'
      };
      HttpClient()
          .addtoken(body)
          .then((value) => {print(value)})
          .catchError((e) {
        print(e);
      });
    });
  }

  Image returnLogo(BuildContext context) {
    return Image.asset(
      'assets/images/colorfulLogo.png',
      width: MediaQuery.of(context).size.width * 0.23,
      height: MediaQuery.of(context).size.height * 0.1,
      fit: BoxFit.fill,
    );
  }

  Future<void> socialLogin(
      String type, String id, String email, String displayName) async {
    isLoading = true;
    setState(() {});
    Map<String, dynamic> body = {
      'login_src': type,
      'social_login_id': id,
      'fcm_token': StorageManager().fcmToken,
      'os': Platform.isAndroid ? 'android' : 'ios',
    };
    await HttpClient().signinSocial(body).then((loginresponse) async {
      if (loginresponse.data['isSuccess'] == true) {
        StorageManager().accessToken = "" + loginresponse.data['data']['token'];
        StorageManager().userId = loginresponse.data['data']['user']['id'];
        StorageManager().name = "" +
            loginresponse.data['data']['user']['first_name'];
        StorageManager().email =
            "" + loginresponse.data['data']['user']['email'];
        StorageManager().stripeId =
            "" + loginresponse.data['data']['user']['customer_stripe_id'];
        StorageManager().isProvider =
            loginresponse.data['data']['user']['is_provider'] ? true : false;
        StorageManager().nationality =
            "" + loginresponse.data['data']['user']['nationality'];
        StorageManager().language =
            "" + loginresponse.data['data']['user']['languages'];
        // StorageManager().phone = ""+loginresponse.data['data']['user']['phone_number'];
      }
      signin = false;
      isLoading = false;
      print('aaaaa');
      widget.isFromOtherScreen
          ? Navigator.pop(context, "1")
          : changeScreenReplacement(
              context,
              BottomNavBar(
                isprovider: loginresponse.data['data']['user']['is_provider'],
              ));
      // Navigator.pop(context);
    }).catchError((error) {
      signin = false;
      isLoading = false;
      setState(() {});
      changeScreen(
          context: context,
          screen: ProviderOrUser(
            loginType: type,
            name: displayName,
            socialId: id,
            email: email,
          ));
    });
  }
}
