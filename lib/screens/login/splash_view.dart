import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/helperfunctions/screen_nav.dart';
import 'package:kappu/screens/register/provider_signup_first.dart';
import 'package:video_player/video_player.dart';
import '../../common/bottom_nav_bar.dart';
import 'login_screen.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset('assets/videos/splash_gif.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          controller.play();
          controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomPaint(
        child: Stack(
          //alignment:new Alignment(x, y)
          children: <Widget>[
            Positioned(
              width: MediaQuery.of(context).size.width,
                child: controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: VideoPlayer(controller),
                      )
                    : Container()),
            Positioned(
              child: signInView(context),
            )
          ],
        ),
      ),
    );
  }

  Column signInView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (ScreenUtil().screenHeight * 0.37).verticalSpace,
        Row(
          children: [
            const SizedBox(width: 20),
            returnLogo(context),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            const SizedBox(width: 25),
            returnMarketPlaceText(),
          ],
        ),
        SizedBox(
          height: 25.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 20.h,
            ),
            Expanded(
              child: ElevatedButton(
                  onPressed: () {},
                  child: returnButtonWithTextImage(context,
                      'assets/images/find_icon.png', "Find a service\n"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
            ),
            SizedBox(
              width: 20.h,
            ),
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ProviderSignupFirstScreen()));
                  },
                  child: returnButtonWithTextImage(
                      context,
                      'assets/images/seller_icon.png',
                      "Become a Service\n Provider"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
            ),
            SizedBox(
              width: 20.h,
            ),
          ],
        ),
        SizedBox(
          height: 22.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 12.h,
            ),
            Expanded(
                child: OutlinedButton(
                    onPressed: () {
                      changeScreen(
                          context: context, screen: const LoginScreen());
                    },
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        primary: Colors.blue,
                        side: const BorderSide(color: Colors.blue, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          fontFamily: 'Montserrat-Bold',
                          color: Colors.blue),
                      textAlign: TextAlign.center,
                    ))),
            SizedBox(
              width: 15.h,
            ),
            Expanded(
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BottomNavBar(isprovider: false)));
                    },
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        primary: Colors.blue,
                        side: const BorderSide(color: Colors.blue, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )),
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          fontFamily: 'Montserrat-Bold',
                          color: Colors.blue),
                      textAlign: TextAlign.center,
                    ))),
            SizedBox(
              width: 12.h,
            ),
          ],
        ),
      ],
    );
  }

  Column returnButtonWithTextImage(
      BuildContext context, String imageName, String titleStr) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 15.h,
        ),
        Image.asset(
          imageName,
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.width * 0.1,
          fit: BoxFit.fill,
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          titleStr,
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              fontFamily: 'Montserrat-Bold',
              color: Colors.black),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }

  Text returnMarketPlaceText() {
    return const Text(
      "One Marketplace\nFor all Local Services.",
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 28.0,
          fontFamily: 'Montserrat-Bold',
          color: Colors.white),
      textAlign: TextAlign.start,
    );
  }

  Image returnLogo(BuildContext context) {
    return Image.asset(
      'assets/images/first-screen-logo.png',
      width: MediaQuery.of(context).size.width * 0.23,
      height: MediaQuery.of(context).size.height * 0.1,
      fit: BoxFit.fill,
    );
  }
}
