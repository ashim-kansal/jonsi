import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/custom_progress_bar.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/models/serializable_model/CategoryResponse.dart';
import 'package:kappu/models/serializable_model/GigListResponse.dart';
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
  bool? isFromAddGig = false;
  bool? isFromEditGig = false;
  GigListResponse? myGig;

  RegisterMore({Key? key, required this.bodyprovider, this.isFromAddGig, this.isFromEditGig, this.myGig}) : super(key: key);

  @override
  _RegisterMoreState createState() => _RegisterMoreState();
}

class _RegisterMoreState extends State<RegisterMore> {
  bool loading = false;
  final _formState = GlobalKey<FormState>();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _extraRateController = TextEditingController();
  bool isValidDesc= true;
  bool isValidTitle= true;
  bool isValidRate= true;
  bool isValidExtraRate= true;

  List<Category> catagories = [
    Category(id: -1, name: "Select a Service", createdAt: "",image: "", description: "")
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
                  if(widget.isFromEditGig??false){
                    for (var value1 in value.data) {
                        if(widget.myGig!.categoryId==value1.id){
                          setState(() {
                            this.catagories = value.data;
                            this.selectedcatagory = value1;
                            this._descController.text = widget.myGig!.description??"";
                            this._titleController.text = widget.myGig!.title??"";
                            this._rateController.text = widget.myGig!.servicepackages?.price??"";
                            this._extraRateController.text = widget.myGig!.servicepackages?.extraForUrgentNeed??"";
                          })
                        }
                    }
                  }else {
                      setState(() {
                        this.catagories = value.data;
                      })
                    }
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
        child: Container(
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
                            child: Image.asset(
                              "assets/icons/logo.png",
                              height: 90.h,
                              fit: BoxFit.cover,
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
                              elevation: 3,
                              shadowColor: Colors.black.withOpacity(0.14),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: ScreenUtil().setHeight(40),
                                      width: ScreenUtil().setWidth(317),
                                      child: DropdownButtonFormField<Category>(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            prefixIcon: Padding(
                                              padding:
                                              const EdgeInsetsDirectional.only(start: 15, end: 10),
                                              child: ImageIcon(AssetImage('assets/icons/service.png'), color: AppColors.app_color,),
                                            ),

                                            hintStyle: TextStyle(
                                                color: Colors.grey[100], fontFamily: "Montserrat-Medium"),
                                            hintText: "Choose catagory",
                                            fillColor: Colors.red[100]),
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w500,
                                          fontSize: ScreenUtil().setSp(15),
                                        ),
                                        value: widget.isFromEditGig??false ? selectedcatagory : catagories.first,
                                        onChanged: widget.isFromEditGig??false ? null :  (value) {
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
                            controller: _titleController,
                            hintText: 'Title',
                            keyboardType: TextInputType.text,
                            prefixIcon: ImageIcon(AssetImage('assets/icons/price.png'), color: AppColors.app_color,),
                            isValid: isValidTitle,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                isValidTitle = true;
                              } else {
                                isValidTitle = false;
                              }
                              setState(() {});
                            },
                            validator: (value) => value!.isEmpty
                                ? "Enter Title"
                                : null,
                          ),

                          10.verticalSpace,
                          CustomTextFormField(
                            controller: _descController,
                            hintText:
                                'Description | Cover letter – why should user hire you?',
                            keyboardType: TextInputType.text,
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
                            prefixIcon: ImageIcon(AssetImage('assets/icons/price.png'), color: AppColors.app_color,),
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
                            prefixIcon: ImageIcon(AssetImage('assets/icons/price.png'), color: AppColors.app_color,),
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
                          Container(
                            height: ScreenUtil().screenHeight * 0.06,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(AppColors.app_color),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          ScreenUtil().screenHeight * 0.03)),
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
                                    "Continue",
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
                              onPressed: onregisterpressedprovider,
                            ),
                          ),
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
    print('anc');
    if(_titleController.text.isEmpty ||_descController.text.isEmpty || _rateController.text.isEmpty || _extraRateController.text.isEmpty){
      return;
    }

    print("aa");

    Map<String, dynamic> bodyprovider1 = (widget.isFromAddGig??false || (widget.isFromEditGig??false)) ? {
      'category': selectedcatagory.id,
      "description": _descController.text,
      "Perhour": _rateController.text,
      "Extra_for_urgent_need": _extraRateController.text,
      "service_title": _titleController.text
    } : {
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
      "service_title": _titleController.text,
      "description": _descController.text,
      "Perhour": _rateController.text,
      'fcm_token': StorageManager().fcmToken,
      'os': Platform.isAndroid?'android':'ios',
      "Extra_for_urgent_need": _extraRateController.text
    };

    print('bb');
    if(widget.isFromEditGig??false){
      final result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddGig(bodyprovider: bodyprovider1, isFromEditGig: widget.isFromEditGig, myGig: widget.myGig??null)));
      if(result == "1" && (widget.isFromEditGig??false)){
        Navigator.pop(context, "1");
      }
    }
    else {
      final result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AddGig(bodyprovider: bodyprovider1,
                      isFromAddGig: widget.isFromAddGig)));
      if (result == "1" && (widget.isFromAddGig??false)) {
        Navigator.pop(context, "1");
      }
    }
  }
}
