import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/serializable_model/offer.dart';
import '../date_time_selection/service_datetime.dart';

class SelectServiceLocation extends StatefulWidget {
  final Offers offer;

  const SelectServiceLocation({Key? key, required this.offer})
      : super(key: key);

  @override
  _SelectServiceLocationState createState() => _SelectServiceLocationState();
}

class _SelectServiceLocationState extends State<SelectServiceLocation> {
  String address = '';
  List<bool> isSelected = [true, false, false];

  TextEditingController addressController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Form(
            key: _formkey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(45),
                      left: ScreenUtil().setWidth(15),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  //
                  Image.asset(
                    "assets/images/locationreview.png",
                    height: ScreenUtil().setHeight(250),
                  ),
                  // const Spacer(),
                  137.verticalSpace,
                  Container(
                      height: ScreenUtil().setHeight(220),
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Container(
                              height: 6,
                              width: ScreenUtil().setWidth(100),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(20),
                          ),
                          ToggleButtons(
                            color: Colors.white,
                            borderColor: Colors.white,
                            fillColor: Colors.white,
                            borderWidth: 1,
                            selectedBorderColor: Colors.white,
                            selectedColor: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                width: ScreenUtil().setWidth(100),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Home',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(100),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Office',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(100),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Others',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            onPressed: (int index) {
                              setState(() {
                                for (int i = 0; i < isSelected.length; i++) {
                                  isSelected[i] = i == index;
                                  setState(() {});
                                }
                              });
                            },
                            isSelected: isSelected,
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(20),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(20)),
                            child: TextFormField(
                              cursorColor: Colors.white,
                              validator: (value) =>
                                  value!.isEmpty ? "Enter your Address" : null,
                              controller: addressController,
                              decoration: InputDecoration(
                                // errorText: validatePassword(emailcontroller.text),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFF6F6F6),
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFF6F6F6),
                                    )),
                                prefixIcon: const Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: 10, end: 10),
                                  child: Icon(
                                    Icons.location_city,
                                    color: Colors.white,
                                  ),
                                ),
                                prefixIconConstraints:
                                    BoxConstraints(maxHeight: 20.h),
                                hintText: '(service) Address',
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                              ),
                              onChanged: (value) {
                                address = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(15),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(20)),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: ScreenUtil().setHeight(40),
                                    width: ScreenUtil().setWidth(155),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.blue,
                                          fontSize: ScreenUtil().setWidth(16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(10),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (_formkey.currentState!.validate()) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ServicedateTime(
                                                    address:
                                                        addressController.text,
                                                    offer: widget.offer,
                                                  )));
                                    }
                                  },
                                  child: Container(
                                    height: ScreenUtil().setHeight(40),
                                    width: ScreenUtil().setWidth(155),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Proceed',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.blue,
                                          fontSize: ScreenUtil().setWidth(16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ))
                ]),
          ),
        ),
      ),
    );
  }
}
