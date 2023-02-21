import 'dart:io';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kappu/common/bottom_nav_bar.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/models/serializable_model/Language.dart';
import 'package:kappu/models/serializable_model/CategoryResponse.dart';
import 'package:kappu/provider/provider_provider.dart';
import 'package:kappu/screens/register/register_more.dart';
import 'package:kappu/screens/register/widgets/text_field.dart';
import 'package:kappu/screens/submitdocument/submit_doc.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';
import '../../common/button.dart';
import '../../common/dialogues.dart';
import '../../common/painter.dart';
import '../../constants/icons.dart';
import '../../net/base_dio.dart';
import '../../net/http_client.dart';
import 'email_otp.dart';

class SignUp extends StatefulWidget {
  final bool isprovider;

  const SignUp(
      {Key? key,
      required this.isprovider,
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
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = '';
  String password = '';
  String checkPassword = '';
  bool loading = false;
  bool _showPassword = true;
  bool _showCheckPassword = true;
  String passwordStrength = '';
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  final _formState = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _phnocontroller = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addresscontoller = TextEditingController();
  final TextEditingController _checkPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  bool isVaildFirstName = true;
  bool isVaildLastName = true;
  bool isVaildEmail = true;
  bool isVaildPhone = true;
  bool isVaildAge = true;
  bool isVaildNati = true;
  bool isVaildPassword = true;
  bool isVaildConfirm = true;

  List<Language> languages = [
    Language(id: -1, name: 'English'),
    Language(id: -2, name: 'Maltese'),
    Language(id: -3, name: 'Italian'),
    Language(id: -4, name: 'Spanish'),
    Language(id: -5, name: 'French'),
    Language(id: -6, name: 'German'),
    Language(id: -7, name: 'Polish'),
    Language(id: -8, name: 'Arabic'),
    Language(id: -9, name: 'Dutch')
  ];

  // Category selectedcatagory =
  //     Category(id: -1, name: "Select a Service", createdAt: "");
  Language selectedLanguage = Language(id: -1, name: 'English');

  String vaidatePassword(String password) {
    if (password.contains(
        RegExp(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$'))) {
      return 'Strong';
    } else {
      return 'Weak';
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
    _nameController.text = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: AppColors.app_color,
        ),
        shadowColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                child: Form(
                  key: _formState,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/icons/logo.png",
                          height: 90.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      30.verticalSpace,
                      CustomTextFormField(
                        controller: _nameController,
                        validator: (value) =>
                        value!.isEmpty ? "Enter Your Name" : null,
                        keyboardType: TextInputType.text,
                        prefixIcon: ImageIcon(AssetImage('assets/icons/prf.png'), color: AppColors.app_color,),
                        hintText: 'Name',
                        isValid: isVaildFirstName,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            isVaildFirstName = true;
                          } else {
                            isVaildFirstName = false;
                          }
                          setState(() {});
                        },
                      ),
                      // CustomTextFormField(
                      //   controller: _lastnameController,
                      //   validator: (value) =>
                      //   value!.isEmpty ? "Enter Your Name" : null,
                      //   keyboardType: TextInputType.text,
                      //   prefixIcon: profileIcon,
                      //   hintText: 'Last Name',
                      //   isValid: isVaildLastName,
                      //   onChanged: (value) {
                      //     if (value.isNotEmpty) {
                      //       isVaildLastName = true;
                      //     } else {
                      //       isVaildLastName = false;
                      //     }
                      //     setState(() {});
                      //   },
                      // ),
                      CustomTextFormField(
                        controller: _emailController,
                        validator: (value) =>
                        isEmail(value!) ? null : "Check your email",
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon:  ImageIcon(AssetImage('assets/icons/ft-4.png'), color: AppColors.app_color,),
                        suffixIcon: isEmail(email) ? checkIcon : null,
                        hintText: 'Email',
                        isValid: isVaildEmail,
                        enabled: widget.socialId.isEmpty,
                        onChanged: (value) {
                          if (value.isNotEmpty && isEmail(value)) {
                            isVaildEmail = true;
                          } else {
                            isVaildEmail = false;
                          }
                          setState(() {});
                        },
                      ),
                      // CustomTextFormField(
                      //   controller: _phnocontroller,
                      //   hintText: 'Phone Number',
                      //   keyboardType: TextInputType.number,
                      //   prefixIcon: profileIcon,
                      //   isValid: isVaildPhone,
                      //   onChanged: (value) {
                      //     if (value.isNotEmpty && value.length == 10) {
                      //       isVaildPhone = true;
                      //     } else {
                      //       isVaildPhone = false;
                      //     }
                      //     setState(() {});
                      //   },
                      //   validator: (value) => value!.length != 10
                      //       ? "Phone Number should be 10 digit long"
                      //       : null,
                      // ),
                      if (!widget.isprovider)
                        CustomTextFormField(
                          controller: _addresscontoller,
                          hintText: 'Address',
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {});
                          },
                          prefixIcon: const Icon(Icons.location_on),
                          validator: (value) =>
                          value!.isEmpty ? "Enter Your Address" : null,
                        ),
                      if (widget.isprovider)
                        InkWell(
                          onTap: () async {
                            print('ssss');
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              setState(() {
                                _ageController.text = formattedDate;
                                //set output date to TextField value.
                              });
                            } else {}
                          },
                          child: CustomTextFormField(
                            controller: _ageController,
                            hintText: 'Age',
                            readOnly: true,
                            enabled: false,
                            isValid: isVaildAge,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                isVaildAge = true;
                              } else {
                                isVaildAge = false;
                              }
                              setState(() {});
                            },
                            keyboardType: TextInputType.none,
                            prefixIcon: ImageIcon(AssetImage('assets/icons/age.png'), color: AppColors.app_color,),
                            validator: (value) => null,
                          ),
                        ),
                      if (widget.isprovider)
                        CustomTextFormField(
                          controller: _nationalityController,
                          hintText: 'Nationality',
                          keyboardType: TextInputType.text,
                          prefixIcon: ImageIcon(AssetImage('assets/icons/flag.png'), color: AppColors.app_color,),
                          isValid: isVaildNati,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              isVaildNati = true;
                            } else {
                              isVaildNati = false;
                            }
                            setState(() {});
                          },
                          validator: (value) =>
                          value!.isEmpty ? "Enter Your Nationality" : null,
                        ),
                      // if (widget.isprovider)
                      //   CustomTextFormField(
                      //     controller: _descController,
                      //     hintText:
                      //         'Description | Cover letter – why should user hire you?',
                      //     keyboardType: TextInputType.text,
                      //     prefixIcon: profileIcon,
                      //     maxlines: 3,
                      //     validator: (value) =>
                      //         value!.isEmpty ? "Enter Your Description" : null,
                      //   ),
                      if (!widget.isprovider)
                        Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: CSCPicker(
                            showStates: true,
                            showCities: true,
                            flagState: CountryFlag.DISABLE,
                            dropdownDecoration: BoxDecoration(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                                border:
                                Border.all(color: Colors.grey, width: 1)),
                            disabledDropdownDecoration: BoxDecoration(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                                color: Colors.grey.shade300,
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1)),
                            countrySearchPlaceholder: "Country",
                            stateSearchPlaceholder: "State",
                            citySearchPlaceholder: "City",
                            countryDropdownLabel: "Country",
                            stateDropdownLabel: "State",
                            cityDropdownLabel: "City",
                            defaultCountry: CscCountry.Malta,
                            selectedItemStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(15),
                            ),
                            dropdownHeadingStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(15),
                            ),
                            dropdownItemStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(15),
                            ),
                            dropdownDialogRadius: 15.0,
                            searchBarRadius: 10.0,
                            onCountryChanged: (value) {
                              countryValue = value;
                              setState(() {});
                            },
                            onStateChanged: (value) {
                              if (value != null) {
                                stateValue = value;
                              }
                              setState(() {});
                            },
                            onCityChanged: (value) {
                              if (value != null) {
                                cityValue = value;
                              }
                              setState(() {});
                            },
                          ),
                        ),
                      // if (widget.isprovider)
                      //   Material(
                      //       borderRadius: BorderRadius.circular(
                      //           ScreenUtil().screenHeight * 0.03),
                      //       elevation: 20,
                      //       child: Row(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             SizedBox(
                      //               height: ScreenUtil().setHeight(50),
                      //               width: ScreenUtil().setWidth(317),
                      //               child: DropdownButtonFormField<Category>(
                      //                 decoration: InputDecoration(
                      //                     border: InputBorder.none,
                      //                     contentPadding: EdgeInsets.only(
                      //                         left: 15, right: 15, top: 5),
                      //                     hintStyle: TextStyle(
                      //                         color: Colors.grey[100]),
                      //                     hintText: "Choose catagory",
                      //                     fillColor: Colors.red[100]),
                      //                 style: TextStyle(
                      //                   color: Colors.grey.shade600,
                      //                   fontWeight: FontWeight.w500,
                      //                   fontSize: ScreenUtil().setSp(15),
                      //                 ),
                      //                 value: catagories.first,
                      //                 onChanged: (value) {
                      //                   setState(() {
                      //                     selectedcatagory = value!;
                      //                   });
                      //                 },
                      //                 items: catagories
                      //                     .map((value) => DropdownMenuItem(
                      //                         value: value,
                      //                         child: Text(value.name)))
                      //                     .toList(),
                      //               ),
                      //             )
                      //           ])),
                      10.verticalSpace,
                      if (widget.isprovider)
                        Material(
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().screenHeight * 0.03),
                            elevation: 3,
                              shadowColor: Colors.black.withOpacity(0.14),
                            child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: ScreenUtil().setHeight(50),
                                    width: ScreenUtil().setWidth(317),
                                    child: Row(
                                      children: [
                                        ImageIcon(AssetImage('assets/icons/flag.png'), color: AppColors.app_color,),

                                        DropdownButtonFormField<Language>(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, right: 15, top: 5),
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[100]),
                                              hintText: "Language known",
                                              fillColor: Colors.red[100]),
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.w500,
                                            fontSize: ScreenUtil().setSp(15),
                                          ),
                                          value: languages.first,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedLanguage = value!;
                                            });
                                          },
                                          items: languages
                                              .map((value) => DropdownMenuItem(
                                              value: value,
                                              child: Text(
                                                value.name,
                                                style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                  ScreenUtil().setSp(15),
                                                ),
                                              )))
                                              .toList(),
                                        ),
                                      ],
                                    )
                                  ),
                                ])),
                      10.verticalSpace,
                      // if (widget.isprovider)
                      //   CustomTextFormField(
                      //     controller: _rateController,
                      //     hintText: '\$ per hour',
                      //     keyboardType: TextInputType.number,
                      //     prefixIcon: profileIcon,
                      //     validator: (value) => value!.isEmpty
                      //         ? "Enter \$ per hour"
                      //         : value!.length > 2
                      //             ? "Enter valid \$ per hour"
                      //             : null,
                      //   ),
                      // if (widget.isprovider)
                      //   CustomTextFormField(
                      //     controller: _extraRateController,
                      //     hintText: 'Extra \$ for urgent need',
                      //     keyboardType: TextInputType.number,
                      //     prefixIcon: profileIcon,
                      //     validator: (value) => value!.isEmpty
                      //         ? "Enter extra \$"
                      //         : value!.length > 2
                      //             ? "Enter valid extra \$"
                      //             : null,
                      //   ),

                      if (widget.socialId.isEmpty)
                        CustomTextFormField(
                          controller: _passwordController,
                          validator: (value) => vaidatePassword(value!) ==
                              'Weak'
                              ? "Must contain at least one Capital letter and a number"
                              : null,
                          keyboardType: TextInputType.visiblePassword,
                          prefixIcon: passwordIcon,
                          showPassword: _showPassword,
                          suffixIcon: GestureDetector(
                              onTap: () {
                                _showPassword = !_showPassword;
                                setState(() {});
                              },
                              child: _showPassword
                                  ? passwordEyeIcon
                                  : passwordGreenEyeIcon),
                          hintText: "Password",
                          isValid: isVaildPassword,
                          onChanged: (value) {
                            password = value;
                            passwordStrength = vaidatePassword(value);
                            setState(() {});
                            if (value.isNotEmpty &&
                                vaidatePassword(value) == 'Strong') {
                              isVaildPassword = true;
                            } else {
                              isVaildPassword = false;
                            }
                            setState(() {});
                          },
                        ),
                      passwordStrength == ''
                          ? SizedBox(height: ScreenUtil().setHeight(0))
                          : Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Password Strength:',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF767F94),
                                  fontSize: ScreenUtil().setSp(13)),
                            ),
                            Text(
                              passwordStrength,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: passwordStrength == 'Weak'
                                      ? Colors.red
                                      : const Color(0xFF05C46B),
                                  fontSize: ScreenUtil().setSp(13)),
                            )
                          ],
                        ),
                      ),
                      if (widget.socialId.isEmpty)
                        CustomTextFormField(
                          showPassword: _showCheckPassword,
                          controller: _checkPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          isValid: isVaildConfirm,
                          onChanged: (value) {
                            if (value.isNotEmpty && value == password) {
                              isVaildConfirm = true;
                            } else {
                              isVaildConfirm = false;
                            }
                            checkPassword = value;
                            setState(() {});
                          },
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              if (value != _passwordController.value.text) {
                                return "Passwords do not match";
                              } else {
                                return null;
                              }
                            } else {
                              return "Enter Your password";
                            }
                          },
                          prefixIcon: passwordIcon,
                          suffixIcon: GestureDetector(
                              onTap: () {
                                _showCheckPassword = !_showCheckPassword;
                                setState(() {});
                              },
                              child: _showCheckPassword
                                  ? passwordEyeIcon
                                  : passwordGreenEyeIcon),
                          hintText: "Confirm Password",
                        ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      CustomButton(
                          buttontext: "Next",
                          isLoading: loading,
                          onPressed: () {
                            widget.isprovider
                                ? onregisterpressedprovider
                                : onregisterpressed();
                          }),
                      10.verticalSpace,

                      // const OrSignUpWith()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onregisterpressedprovider() async {
    print("inside>>>>>>>>>>>>");
    if (widget.socialId.isEmpty) {
      if (_nameController.text.isEmpty ||
          _lastnameController.text.isEmpty ||
          _emailController.text.isEmpty ||
          !isEmail(_emailController.text) ||
          _phnocontroller.text.isEmpty ||
          _phnocontroller.text.length < 8 ||
          _passwordController.text.isEmpty ||
          passwordStrength == 'Weak' ||
          _checkPasswordController.text.isEmpty ||
          _checkPasswordController.text != _passwordController.text) {
        return;
      }
    }

    if (_nameController.text.isEmpty ||
        _lastnameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        !isEmail(_emailController.text) ||
        _phnocontroller.text.isEmpty ||
        _phnocontroller.text.length < 8) {
      return;
    }

    Map<String, dynamic> bodyprovider = widget.socialId.isEmpty
        ? {
            'first_name': _nameController.text,
            'last_name': _lastnameController.text,
            'username': _lastnameController.text,
            'email': _emailController.text,
            'phone_number': '11',
            'password': _passwordController.text,
            "Age": _ageController.text,
            "nationality": _nationalityController.text,
            'fcm_token': StorageManager().fcmToken,
            'os': Platform.isAndroid ? 'android' : 'ios',
            "language": selectedLanguage.name,
            "service_title": "proidehoubroufo-770",
            "login_src": "",
            "social_login_id": "",
          }
        : {
            'first_name': _nameController.text,
            'last_name': _lastnameController.text,
            'username': _lastnameController.text,
            'email': _emailController.text,
            'phone_number': '111',
            'password': '',
            'login_src': widget.loginType,
            'social_login_id': widget.socialId,
            'fcm_token': StorageManager().fcmToken,
            'os': Platform.isAndroid ? 'android' : 'ios',
            "Age": _ageController.text,
            "nationality": _nationalityController.text,
            "language": selectedLanguage.name,
            "service_title": "proidehoubroufo-770",
          };
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RegisterMore(bodyprovider: bodyprovider)));
  }

  onregisterpressed() async {
    if (widget.socialId.isEmpty) {
      if (_nameController.text.isEmpty ||
          _lastnameController.text.isEmpty ||
          _emailController.text.isEmpty ||
          !isEmail(_emailController.text) ||
          _phnocontroller.text.isEmpty ||
          _phnocontroller.text.length != 10 ||
          _passwordController.text.isEmpty ||
          passwordStrength == 'Weak' ||
          _checkPasswordController.text.isEmpty ||
          _checkPasswordController.text != _passwordController.text) {
        return;
      }
    }
    if (_nameController.text.isEmpty ||
        _lastnameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        !isEmail(_emailController.text) ||
        _phnocontroller.text.isEmpty ||
        _phnocontroller.text.length != 10) {
      return;
    }
    if (!loading) {
      setState(() {
        this.loading = true;
      });
      Map<String, dynamic> body = widget.socialId.isEmpty
          ? {
              'first_name': _nameController.text,
              'username': _nameController.text + "_" + _lastnameController.text,
              'last_name': _lastnameController.text,
              'email': _emailController.text,
              'phone_number': _phnocontroller.text,
              'password': _passwordController.text,
              'fcm_token': StorageManager().fcmToken,
              'os': Platform.isAndroid ? 'android' : 'ios',
              'language': 'english',
              'nationality': countryValue,
        'login_src': '',
        'social_login_id':''
            }
          : {
              'first_name': _nameController.text,
              'username': _nameController.text + "_" + _lastnameController.text,
              'last_name': _lastnameController.text,
              'email': _emailController.text,
              'phone_number': _phnocontroller.text,
              'password': '',
              'login_src': widget.loginType,
              'social_login_id': widget.socialId,
              'fcm_token': StorageManager().fcmToken,
              'os': Platform.isAndroid ? 'android' : 'ios',
              'language': 'english',
              'nationality': countryValue,
            };

      await HttpClient().userSignup(body, new File("path")).then((value) {
        loading = false;
        if (value?.data['status']) {
          var provider = StorageManager();
          provider.accessToken = value?.data['token'];
          provider.name = _nameController.text + " " + _lastnameController.text;
          provider.phone = _phnocontroller.text;
          provider.email = _emailController.text;
          provider.isProvider = false;
          provider.nationality = value?.data['user']['nationality'];
          provider.language = value?.data['user']['languages'];
        }
        setState(() {});
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavBar(isprovider: false)));
      }).catchError((e) {
        setState(() {
          this.loading = false;
        });
        BaseDio.getDioError(e);
      });
    }
  }
}
