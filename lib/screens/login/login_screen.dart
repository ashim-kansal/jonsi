import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/customtexts.dart';
import 'package:kappu/common/painter.dart';
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
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  bool _showPassword = true;
  bool signin = false;
  final _formState = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
    final provider = Provider.of<ProviderProvider>(context);
    final user = Provider.of<UserProvider>(context);
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
      ElevatedTextFormField(
        controller: emailController,
        validator: (value) =>
            isEmail(value!) ? null : "       Check your email",
        keyboardType: TextInputType.emailAddress,
        prefixIcon: emailIcon,
        suffixIcon: isEmail(email) ? checkIcon : null,
        showPassword: false,
        hintText: 'Enter Email',
        onChanged: (value) {
          email = value;
          setState(() {});
        },
      ),
      15.verticalSpace,
      Material(
        borderRadius: BorderRadius.circular(ScreenUtil().screenHeight * 0.03),
        elevation: 20,
        child: TextFormField(
          validator: (value) =>
              value!.isEmpty ? "       Enter Your Password" : null,
          controller: passwordController,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsetsDirectional.only(start: 20, end: 15),
              child: passwordIcon,
            ),
            // prefixIconConstraints:
            //     BoxConstraints(maxHeight: ScreenUtil().setWidth(20)),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: GestureDetector(
                  onTap: () {
                    _showPassword = !_showPassword;
                    setState(() {});
                  },
                  child:
                      _showPassword ? passwordEyeIcon : passwordGreenEyeIcon),
            ),
            suffixIconConstraints: const BoxConstraints(maxHeight: 25),
            suffixIconColor: Colors.green,
            hintText: 'Enter Password',
            hintStyle: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
            border: InputBorder.none,
          ),
          obscureText: _showPassword,
          obscuringCharacter: '*',
        ),
      ),
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
            color: Colors.blue,
            fontSize: 10,
          ),
        ),
      ),
      15.verticalSpace,
      SizedBox(
        height: ScreenUtil().screenHeight * 0.05,
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
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
            if (_formState.currentState!.validate()) {
              if (!signin) {
                signin = true;
                setState(() {});
                Map<String, dynamic> body = {
                  'email': emailController.text.trim(),
                  'password': passwordController.text,
                };
                await HttpClient().signin(body).then((loginresponse) async {
                  if (loginresponse.data['data']['is_provider']) {
                    provider.token = loginresponse.data['data']['token'];
                    provider.provider =
                        SignedInProvider.fromJson(loginresponse.data);
                    checkaddusertoken(provider.provider.id);
                    HttpClient()
                        .getuserprofilepic(provider.provider.id.toString())
                        .then((getprofilepicresponse) {
                      provider.providerprofilepicurl =
                          getprofilepicresponse.data['profile_picture'];
                    }).catchError((e) {});
                  } else {
                    user.token = loginresponse.data['data']['token'];
                    user.user = SignedInuser.fromJson(loginresponse.data);
                    checkaddusertoken(user.user.id);
                    await HttpClient()
                        .getuserprofilepic(user.user.id.toString())
                        .then((getprofilepicresponse) {
                      user.userprofilepicurl =
                          getprofilepicresponse.data['profile_picture'];
                    }).catchError((e) {});
                  }
                  signin = false;
                  changeScreenReplacement(
                      context,
                      BottomNavBar(
                        isprovider: loginresponse.data['data']['is_provider'],
                      ));
                }).catchError((error) {
                  signin = false;
                  setState(() {});
                  BaseDio.getDioError(error);
                });
              }
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
          const Expanded(
              child: FacebookLoginButton(action: false, text: 'Facebook')),
          15.horizontalSpace,
          const Expanded(
              child: GoogleLoginButton(action: false, text: 'Google')),
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
                  color: Colors.blue),
            ),
          )
        ],
      ),
    ];
    return Scaffold(
      body: CustomPaint(
        painter: SignUpPainter(),
        child: SingleChildScrollView(
          child: Form(
              key: _formState,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: children2,
                ),
              )),
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
}
