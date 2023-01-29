import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kappu/common/custom_progress_bar.dart';
import 'package:kappu/common/dialogues.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/net/base_dio.dart';
import 'package:kappu/screens/submitdocument/add_photo.dart';
import '../../common/bottom_nav_bar.dart';
import '../../net/http_client.dart';
import '../../common/CircleButton.dart';

class AddGig extends StatefulWidget {
  final Map<String, dynamic> bodyprovider;
  // final File doc;
  // final File licence;

  const AddGig(
      {Key? key,
      required this.bodyprovider
      // ,required this.doc,
      // required this.licence
      })
      : super(key: key);

  @override
  State<AddGig> createState() => _AddGigState();
}

class _AddGigState extends State<AddGig> {
  bool isUploading = false;
  bool isLoading = false;
  double progress = 0;
  List<File> images = [];

  Future getImage(ImageSource imageSource, context, bool isVideo) async {
    XFile? image;

    image = await ImagePicker().pickImage(source: imageSource);
    ImageCropper imageCropper = ImageCropper();
    if (image != null && !isVideo) {
      File? croppedFile = await imageCropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2
          ],
          androidUiSettings: const AndroidUiSettings(
              toolbarTitle: 'Crop',
              toolbarColor: Colors.blue,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true),
          iosUiSettings: const IOSUiSettings(
            minimumAspectRatio: 1,
          ));
      if (croppedFile != null) {
        setState(() {
          images.add(croppedFile);
        });
      }
    }
    Navigator.pop(context);
  }

  Future source(BuildContext context, bool isVideo) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
              title: const Text("Choose Option"),
              content: const Text(
                'Select Source',
              ),
              insetAnimationCurve: Curves.decelerate,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(
                          Icons.photo_camera,
                          size: 28,
                        ),
                        Text(
                          "Camera",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                      ],
                    ),
                    onTap: () {
                      //   Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) {
                            getImage(ImageSource.camera, context, isVideo);
                            return const Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ));
                          });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(
                          Icons.photo_library,
                          size: 28,
                        ),
                        Text(
                          "Gallery",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            getImage(ImageSource.gallery, context, isVideo);
                            return const Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ));
                          });
                    },
                  ),
                ),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: ScreenUtil().setHeight(40)),
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
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      Center(
                        child: Text(
                          "Add GIG Profile",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(28),
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      15.verticalSpace,
                      Text(
                        "Upload Multiple Images",
                        style: TextStyle(
                            color: AppColors.text_desc,
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w500),
                      ),
                      10.verticalSpace,
                      AddPhotoWidget(
                        isUploading: false,
                        onTap: () {
                          source(context, false);
                        },
                        icon: Icons.upload,
                        progress: progress,
                        isImage: false,
                        onTapCancel: () {
                          setState(() {
                            // uploadTask.cancel();
                            isUploading = false;
                          });
                        },
                      ),
                      15.verticalSpace,
                      Row(
                        children: [
                          Checkbox(
                            value: true,
                            onChanged: (b) {},
                          ),
                          Text(
                            "For licenced work",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      20.verticalSpace,
                      images != null && images.length > 0
                          ? Container(
                        height: 100,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: images.length,
                            itemBuilder: (_, index) {
                              return Container(
                                  margin: EdgeInsets.only(left: 5),
                                  width: 100,
                                  height: 100,
                                  child: AddPhotoWidget(
                                    isUploading: isUploading,
                                    filePath: images[index],
                                    onTap: () {
                                      source(context, false);
                                    },
                                    icon: Icons.upload,
                                    progress: progress,
                                    isImage: false,
                                    onTapCancel: () {
                                      setState(() {
                                        // uploadTask.cancel();
                                        isUploading = false;
                                      });
                                    },
                                  ));
                            }),
                      )
                          : SizedBox(),
                      20.verticalSpace,
                      SizedBox(
                        height: ScreenUtil().screenHeight * 0.07,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.blue),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      ScreenUtil().screenHeight * 0.035)),
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
                                "Submit",
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
                            doRegister();
                          },
                        ),
                      ),
                    ],
                  )),
            ],
          ),
          if(isLoading)
            CustomProgressBar()
        ],)
      ),
    );
  }

  void doRegister() async {
    if(images.isEmpty){
      showAlertDialog(
          error: "Please add gig image",
          errorType: "Alert");
    }else{
      setState(() {
        isLoading = true;
      });
      await HttpClient()
          .providersignup(
          widget.bodyprovider, images.first)
          .then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavBar(isprovider: false)));
      }).catchError((e) {
        setState(() {
          isLoading = false;
        });
        if(e.response !=null && e.response.data['data'].length>0){
          showAlertDialog(
              error: "Please check your email address",
              errorType: "Alert");
        }
      });
    }


  }
}
