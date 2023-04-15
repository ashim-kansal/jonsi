import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kappu/provider/provider_provider.dart';
import 'package:kappu/provider/userprovider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;
import 'package:kappu/net/http_client.dart';

class EditProfile extends StatefulWidget {
  final bool isuser;
  const EditProfile({Key? key, required this.isuser}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  XFile? image;
  bool picked = false;
  Future getImage(
      {required ImageSource imageSource,
      context,
      required UserProvider userprovider,
      required ProviderProvider providerProvider}) async {
    image = await ImagePicker().pickImage(source: imageSource);
    picked = true;
    final extension = p.extension(image!.name);
    Map<String, dynamic> body = {
      "fileName": widget.isuser
          ? "${userprovider.user.email}/${image!.name}"
          : "${providerProvider.provider.email}/${image!.name}",
      "fileType": 'image/${extension.substring(1)}'
    };
    HttpClient().updateprofilepic(body).then((updatedprofileresponse) async {
      Uri uri = Uri.parse(updatedprofileresponse.data['data']['signedRequest']);
      await put(uri, body: await image!.readAsBytes(), headers: {
        "Content-Type": "image/${extension.substring(1)}",
        "x-amz-acl": "public-read"
      }).then((response) async {
        Map<String, dynamic> updatebody = {
          "profile_picture": updatedprofileresponse.data['data']['url']
        };
        HttpClient()
            .updateprofile(
                widget.isuser
                    ? userprovider.user.id.toString()
                    : providerProvider.provider.id.toString(),
                updatebody)
            .then((value) => {
                  // widget.isuser
                  //     ? userprovider.userprofilepicurl =
                  //         updatedprofileresponse.data['data']['url']
                  //     : providerProvider.providerprofilepicurl =
                  //         updatedprofileresponse.data['data']['url'],
                })
            .catchError((e) {});
      });
    }).catchError((e) {});

    Navigator.pop(context);
    setState(() {});
  }

  Future source(
      {required BuildContext context,
      required UserProvider userprovider,
      required ProviderProvider providerProvider}) async {
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
                      showDialog(
                          context: context,
                          builder: (context) {
                            getImage(
                                imageSource: ImageSource.camera,
                                context: context,
                                providerProvider: providerProvider,
                                userprovider: userprovider);
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
                            getImage(
                                imageSource: ImageSource.gallery,
                                context: context,
                                providerProvider: providerProvider,
                                userprovider: userprovider);
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Consumer<UserProvider>(
          builder: (context, loggedinuser, child) => Consumer<ProviderProvider>(
            builder: (context, loggedinprovider, child) =>
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              40.verticalSpace,
              const BackButton(),
              30.verticalSpace,
              Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: Ink.image(
                              image: FileImage(File(image!.path)),

                              fit: BoxFit.cover,
                              width: 128,
                              height: 128,
                              child: InkWell(onTap: () {}),
                            ),
                          ),
                        ),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () {
                                source(
                                    context: context,
                                    providerProvider: loggedinprovider,
                                    userprovider: loggedinuser);
                              },
                              child: Container(
                                  height: ScreenUtil().setHeight(30),
                                  width: ScreenUtil().setHeight(30),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.blue),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  )),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    widget.isuser
                        ? loggedinuser.user.fname +
                            " " +
                            loggedinuser.user.lname
                        : loggedinprovider.provider.firstname,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(22)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.isuser
                        ? loggedinuser.user.email
                        : loggedinprovider.provider.email,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(35),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.grey.shade100,
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            ...ListTile.divideTiles(
                              color: Colors.grey,
                              tiles: [
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  leading: const Icon(Icons.person),
                                  title: const Text("Name"),
                                  subtitle: Text(
                                    widget.isuser
                                        ? loggedinuser.user.fname +
                                            " " +
                                            loggedinuser.user.lname
                                        : loggedinprovider.provider.firstname ,
                                  ),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  leading: const Icon(Icons.my_location),
                                  title: const Text("Email"),
                                  subtitle: Text(
                                    widget.isuser
                                        ? loggedinuser.user.email
                                        : loggedinprovider.provider.email,
                                  ),
                                ),
                                ListTile(
                                  leading: const Icon(Icons.email),
                                  title: const Text("Phone Number"),
                                  subtitle: Text(
                                    widget.isuser
                                        ? loggedinuser.user.phno
                                        : loggedinprovider.provider.phno,
                                  ),
                                ),
                                ListTile(
                                  leading: const Icon(Icons.phone),
                                  title: const Text("Location"),
                                  subtitle: Text(
                                    widget.isuser
                                        ? loggedinuser.user.address
                                        : "Nills",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
