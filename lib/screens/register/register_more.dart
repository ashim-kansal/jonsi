import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/custom_progress_bar.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/models/serializable_model/CategoryResponse.dart';
import 'package:kappu/screens/gig/AddGig.dart';
import 'package:kappu/screens/register/widgets/text_field.dart';
import 'package:kappu/screens/submitdocument/submit_doc.dart';

import '../../common/button.dart';
import '../../common/painter.dart';
import '../../constants/icons.dart';
import '../../constants/storage_manager.dart';
import '../../net/base_dio.dart';
import '../../net/http_client.dart';

class RegisterMore extends StatefulWidget {
  final Map<String, dynamic> bodyprovider;

  const RegisterMore({Key? key, required this.bodyprovider}) : super(key: key);

  @override
  _RegisterMoreState createState() => _RegisterMoreState();
}

class _RegisterMoreState extends State<RegisterMore> {
  bool loading = false;
  final _formState = GlobalKey<FormState>();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _extraRateController = TextEditingController();
  bool isValidDesc= true;
  bool isValidRate= true;
  bool isValidExtraRate= true;

  List<Category> catagories = [
    Category(id: 1, name: "Select a Service", createdAt: "",image: "", description: "")
  ];

  Category selectedcatagory =
      Category(id: -1, name: "Select a Service", createdAt: "",image: "", description: "");

  @override
  void initState() {
    super.initState();
    print('bbbb');
    getcatagory();
  }

  getcatagory() async {
    setState(() {
      this.loading = true;
    });
    await HttpClient()
        .getCatagory()
        .then((value) => {
              setState(() {
                this.loading = false;
              }),
              print(value),
              if (value.status)
                {
                  setState(() {
                    this.catagories = value.data;
                  })
                }
            })
        .catchError((e) {
      setState(() {
        this.loading = true;
      });
      BaseDio.getDioError(e);
    });
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
        child: CustomPaint(
          painter: SignUpPainter(),
          child: Stack(
            children: [
              Column(
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
                                "assets/images/cheese-logo-trasparente.png",
                                height: 120.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          30.verticalSpace,

                          // if (!widget.isprovider)
                          //   Padding(
                          //     padding: EdgeInsets.only(top: 10.h),
                          //     child: CSCPicker(
                          //       showStates: true,
                          //       showCities: true,
                          //       flagState: CountryFlag.DISABLE,
                          //       dropdownDecoration: BoxDecoration(
                          //           borderRadius:
                          //           const BorderRadius.all(Radius.circular(10)),
                          //           color: Colors.white,
                          //           border:
                          //           Border.all(color: Colors.grey, width: 1)),
                          //       disabledDropdownDecoration: BoxDecoration(
                          //           borderRadius:
                          //           const BorderRadius.all(Radius.circular(10)),
                          //           color: Colors.grey.shade300,
                          //           border: Border.all(
                          //               color: Colors.grey.shade300, width: 1)),
                          //       countrySearchPlaceholder: "Country",
                          //       stateSearchPlaceholder: "State",
                          //       citySearchPlaceholder: "City",
                          //       countryDropdownLabel: "Country",
                          //       stateDropdownLabel: "State",
                          //       cityDropdownLabel: "City",
                          //       defaultCountry: DefaultCountry.Malta,
                          //       selectedItemStyle: TextStyle(
                          //         fontWeight: FontWeight.w500,
                          //         fontSize: ScreenUtil().setSp(15),
                          //       ),
                          //       dropdownHeadingStyle: TextStyle(
                          //         fontWeight: FontWeight.w500,
                          //         fontSize: ScreenUtil().setSp(15),
                          //       ),
                          //       dropdownItemStyle: TextStyle(
                          //         fontWeight: FontWeight.w500,
                          //         fontSize: ScreenUtil().setSp(15),
                          //       ),
                          //       dropdownDialogRadius: 15.0,
                          //       searchBarRadius: 10.0,
                          //       onCountryChanged: (value) {
                          //         countryValue = value;
                          //         setState(() {});
                          //       },
                          //       onStateChanged: (value) {
                          //         if (value != null) {
                          //           stateValue = value;
                          //         }
                          //         setState(() {});
                          //       },
                          //       onCityChanged: (value) {
                          //         if (value != null) {
                          //           cityValue = value;
                          //         }
                          //         setState(() {});
                          //       },
                          //     ),
                          //   ),
                          Material(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().screenHeight * 0.03),
                              elevation: 20,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: ScreenUtil().setHeight(50),
                                      width: ScreenUtil().setWidth(317),
                                      child: DropdownButtonFormField<Category>(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                left: 15, right: 15, top: 5),
                                            hintStyle: TextStyle(
                                                color: Colors.grey[100]),
                                            hintText: "Choose catagory",
                                            fillColor: Colors.red[100]),
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w500,
                                          fontSize: ScreenUtil().setSp(15),
                                        ),
                                        value: catagories.first,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedcatagory = value!;
                                          });
                                        },
                                        items: catagories
                                            .map((value) => DropdownMenuItem(
                                                value: value,
                                                child: Text(value.name)))
                                            .toList(),
                                      ),
                                    )
                                  ])),
                          10.verticalSpace,
                          CustomTextFormField(
                            controller: _descController,
                            hintText:
                                'Description | Cover letter – why should user hire you?',
                            keyboardType: TextInputType.text,
                            prefixIcon: profileIcon,
                            maxlines: 5,
                            isValid: isValidDesc,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                isValidDesc = true;
                              } else {
                                isValidDesc = false;
                              }
                              setState(() {});
                            },
                            validator: (value) => value!.isEmpty
                                ? "Enter Your Description"
                                : null,
                          ),
                          10.verticalSpace,
                          CustomTextFormField(
                            controller: _rateController,
                            hintText: '\€ per hour',
                            keyboardType: TextInputType.number,
                            prefixIcon: profileIcon,
                            isValid: isValidRate,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                isValidRate = true;
                              } else {
                                isValidRate = false;
                              }
                              setState(() {});
                            },
                            validator: (value) => value!.isEmpty
                                ? "Enter \€ per hour"
                                : value!.length > 2
                                    ? "Enter valid \€ per hour"
                                    : null,
                          ),
                          CustomTextFormField(
                            controller: _extraRateController,
                            hintText: 'Extra \€ for urgent need',
                            keyboardType: TextInputType.number,
                            prefixIcon: profileIcon,
                            isValid: isValidExtraRate,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                isValidExtraRate = true;
                              } else {
                                isValidExtraRate = false;
                              }
                              setState(() {});
                            },
                            validator: (value) => value!.isEmpty
                                ? "Enter extra \€"
                                : value!.length > 2
                                    ? "Enter valid extra \€"
                                    : null,
                          ),

                          SizedBox(height: ScreenUtil().setHeight(10)),
                          CustomButton(
                              buttontext: "Next",
                              isLoading: loading,
                              onPressed: onregisterpressedprovider()),
                          10.verticalSpace,

                          // const OrSignUpWith()
                        ],
                      ),
                    ),
                  )
                ],
              ),
              if (loading) CustomProgressBar()
            ],
          ),
        ),
      ),
    );
  }

  onregisterpressedprovider() async {
    if(_descController.text.isEmpty || _rateController.text.isEmpty || _extraRateController.text.isEmpty){
      return;
    }
    Map<String, dynamic> bodyprovider1 = {
      'first_name': widget.bodyprovider['first_name'],
      'last_name': widget.bodyprovider['last_name'],
      'username': widget.bodyprovider['username'],
      'email': widget.bodyprovider['email'],
      'category': selectedcatagory.id,
      'phone_number': widget.bodyprovider['phone_number'],
      'password': widget.bodyprovider['password'],
      'is_provider': true,
      "Age": widget.bodyprovider['Age'],
      "nationality": widget.bodyprovider['nationality'],
      "language": widget.bodyprovider['language'],
      "service_title": "proidehoubroufo-770",
      "description": _descController.text,
      "Perhour": _rateController.text,
      'fcm_token': StorageManager().fcmToken,
      'os': Platform.isAndroid?'android':'ios',
      "Extra_for_urgent_need": _extraRateController.text
    };
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddGig(bodyprovider: bodyprovider1)));

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => AddDocument(bodyprovider: bodyprovider1)));


  }
}
