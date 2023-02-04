import 'dart:io';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kappu/models/serializable_model/Language.dart';
import 'package:kappu/models/serializable_model/CategoryResponse.dart';
import 'package:kappu/screens/register/register_more.dart';
import 'package:kappu/screens/register/widgets/text_field.dart';
import 'package:kappu/screens/submitdocument/submit_doc.dart';
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

  const SignUp({Key? key, required this.isprovider}) : super(key: key);

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
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _phnocontroller = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _extraRateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addresscontoller = TextEditingController();
  final TextEditingController _checkPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();

  List<Category> catagories = [
    Category(id: 1, name: "Select a Service", createdAt: "")
  ];
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

  Category selectedcatagory =
      Category(id: -1, name: "Select a Service", createdAt: "");
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
    print('bbbb');
    if (widget.isprovider) {
      getcatagory();
    }
  }

  getcatagory() async {
    await HttpClient()
        .getCatagory()
        .then((value) => {
              if (value.status)
                {
                  setState(() {
                    this.catagories = value.data;
                  })
                }
            })
        .catchError((e) {
      BaseDio.getDioError(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.blue,
        ),
        shadowColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: CustomPaint(
          painter: SignUpPainter(),
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            "assets/images/colorfulLogo.png",
                            height: 120.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      30.verticalSpace,
                      CustomTextFormField(
                        controller: _nameController,
                        validator: (value) =>
                            value!.isEmpty ? "Enter Your Name" : null,
                        keyboardType: TextInputType.text,
                        prefixIcon: profileIcon,
                        hintText: 'First Name',
                        onChanged: (value){
                          setState(() {});
                        },
                      ),
                      CustomTextFormField(
                        controller: _lastnameController,
                        validator: (value) =>
                            value!.isEmpty ? "Enter Your Name" : null,
                        keyboardType: TextInputType.text,
                        prefixIcon: profileIcon,
                        hintText: 'Last Name',
                        onChanged: (value){
                          setState(() {});
                        },
                      ),
                      CustomTextFormField(
                        controller: _emailController,
                        validator: (value) =>
                            isEmail(value!) ? null : "Check your email",
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: emailIcon,
                        suffixIcon: isEmail(email) ? checkIcon : null,
                        hintText: 'Email',
                        onChanged: (value) {
                          email = value;
                          setState(() {});
                        },
                      ),
                      CustomTextFormField(
                        controller: _phnocontroller,
                        hintText: 'Phone Number',
                        keyboardType: TextInputType.number,
                        prefixIcon: profileIcon,
                        onChanged: (value){
                          setState(() {});
                        },
                        validator: (value) =>
                            value!.isEmpty ? "Enter Your Phone Number" : null,
                      ),
                      if (!widget.isprovider)
                        CustomTextFormField(
                          controller: _addresscontoller,
                          hintText: 'Address',
                          keyboardType: TextInputType.text,
                          onChanged: (value){
                            setState(() {});
                          },
                          prefixIcon: const Icon(Icons.location_on),
                          validator: (value) =>
                              value!.isEmpty ? "Enter Your username" : null,
                        ),
                      if (widget.isprovider)
                        InkWell(
                          onTap: ()async{
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
                                _ageController.text =
                                    formattedDate;
                                //set output date to TextField value.
                              });
                            } else {}
                          },
                          child: CustomTextFormField(
                          controller: _ageController,
                          hintText: 'Age',
                          readOnly: true,
                          enabled: false,
                            onChanged: (value){
                              setState(() {});
                            },
                          keyboardType: TextInputType.none,
                          prefixIcon: profileIcon,
                          validator: (value) => null,
                        ),),
                      if (widget.isprovider)
                        CustomTextFormField(
                          controller: _nationalityController,
                          hintText: 'Nationality',
                          keyboardType: TextInputType.text,
                          prefixIcon: profileIcon,
                          onChanged: (value){
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
                            defaultCountry: DefaultCountry.Malta,
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
                            elevation: 20,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: ScreenUtil().setHeight(50),
                                    width: ScreenUtil().setWidth(317),
                                    child: DropdownButtonFormField<Language>(
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

                      CustomTextFormField(
                        controller: _passwordController,
                        validator: (value) => vaidatePassword(value!) == 'Weak'
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
                        onChanged: (value) {
                          password = value;
                          passwordStrength = vaidatePassword(value);
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
                      CustomTextFormField(
                        showPassword: _showCheckPassword,
                        controller: _checkPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
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
                          onPressed: widget.isprovider
                              ? onregisterpressedprovider
                              : onregisterpressed),
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
    if (_formState.currentState!.validate()) {

      Map<String, dynamic> bodyprovider = {
        'first_name': _nameController.text,
        'last_name': _lastnameController.text,
        'username': _lastnameController.text,
        'email': _emailController.text,
        'phone_number': _phnocontroller.text,
        'password': _passwordController.text,
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
  }

  onregisterpressed() async {
    if (_formState.currentState!.validate()) {
      if (stateValue != '' && cityValue != '') {
        if (!loading) {
          setState(() {
            this.loading = true;
          });
          Map<String, dynamic> body = {
            'first_name': _nameController.text,
            'last_name': _lastnameController.text,
            'email': _emailController.text,
            'phone_number': _phnocontroller.text,
            'password': _passwordController.text
          };

          await HttpClient().userSignup(body, new File("path")).then((value) {
            loading = false;
            setState(() {});
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EmailOTPConfirmation(
                          id: value!.data['id'],
                          email: _emailController.text,
                        )));
          }).catchError((e) {
            setState(() {
              this.loading = false;
            });
            BaseDio.getDioError(e);
          });
        }
      } else {
        showAlertDialog(
            error: "Select your state and City to complete address",
            errorType: "Incomplete info");
      }
    }
  }
}
