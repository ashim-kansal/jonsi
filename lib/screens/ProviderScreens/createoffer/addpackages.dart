import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/models/serializable_model/offer_package.dart';
import 'package:kappu/net/base_dio.dart';
import 'package:kappu/net/http_client.dart';
import 'package:kappu/screens/ProviderScreens/myoffers/myoffers.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../common/flushbar.dart';
import '../../../provider/provider_provider.dart';
import '../../register/widgets/text_field.dart';

// import '../register/widgets/text_field.dart';

class AddPackages extends StatefulWidget {
  final String offertittle;
  final String offerdescription;

  const AddPackages({
    Key? key,
    required this.offertittle,
    required this.offerdescription,
  }) : super(key: key);

  @override
  _AddPackagesState createState() => _AddPackagesState();
}

class _AddPackagesState extends State<AddPackages> {
  bool publishing = false;

  final _formState = GlobalKey<FormState>();

  final TextEditingController _packagetitle = TextEditingController();
  final TextEditingController _packageprice = TextEditingController();
  final TextEditingController _packagelocation = TextEditingController();
  List<Offerpackage> packages = [];
  String dropDownValue = 'Package timing';
  List<String> catagories = [
    'Package timing',
    '15 min',
    '30 min',
    '45 min',
    '1 hour',
    '1 hour 15 min',
    '1 hour 30 min',
    '1 hour 45 min',
    '2 hours',
    '2 hour 15 min',
    '2 hour 30 min',
    '2 hour 45 min',
    '3 hours',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<ProviderProvider>(
          builder: (context, loggedinprovider, child) => Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const CreateOfferBackground(),
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setWidth(60),
                    right: ScreenUtil().setWidth(290),
                    bottom: ScreenUtil().setWidth(20)),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset('assets/images/Back.png')),
              ),

              if (packages.isNotEmpty)
                Text(
                  'Packages',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.bold),
                ),
              if (packages.isNotEmpty)
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: ListView(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: packages
                        .map((item) => Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.packagetitle,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    r" $"
                                    '${item.packagePrice.toString()}'
                                    '     \u2022 ${item.packageServicetime}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(14)),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(10)),
                                  Center(
                                    child: Card(
                                      elevation: 2,
                                      child: Container(
                                        height: ScreenUtil().setHeight(30),
                                        width: ScreenUtil().setWidth(100),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            packages.remove(item);
                                          },
                                          child: Text(
                                            "Remove",
                                            style: TextStyle(
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  5.verticalSpace,
                                  const Divider(thickness: 1)
                                ],
                              ),
                            ))
                        .toList()),
              ),
              if (packages.isEmpty)
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(10), bottom: 10),
                  child: Text(
                    "Add Packages to your Offer!",
                    style: TextStyle(
                        wordSpacing: 2,
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(22),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              Center(
                child: TextButton(
                    onPressed: () {
                      addpackagedialogue();
                      // showofferdetail(context);
                      // pushDynamicScreen(context, screen: OfferDetail());
                    },
                    child: const Text('+ Add package')),
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
                                  leading: const Icon(Icons.title),
                                  title: const Text("Offer Title"),
                                  subtitle: Text(widget.offertittle),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  leading: const Icon(Icons.description),
                                  title: const Text("Description"),
                                  subtitle: Text(widget.offerdescription),
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

              SizedBox(height: ScreenUtil().setHeight(20)),
              GestureDetector(
                onTap: () async {
                  if (!publishing) {
                    if (packages.isEmpty) {
                      return;
                    }
                    publishing = true;
                    setState(() {});
                    List<Map<String, dynamic>> packagestojson = [];
                    for (var element in packages) {
                      packagestojson.add(element.toJson());
                    }
                    Map<String, dynamic> body = {
                      'title': widget.offertittle,
                      'description': widget.offerdescription,
                      'category': loggedinprovider.provider.catagoryid,
                      'user': loggedinprovider.provider.id,
                      'packages': packagestojson
                    };
                    await HttpClient()
                        .createoffer(body)
                        .then((value) => {
                              publishing = false,
                              setState(() {}),
                              showSuccessFlushBar(
                                  context: context,
                                  message: "Offer Created Successfully"),
                              Future.delayed(const Duration(milliseconds: 2000),
                                  () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                pushDynamicScreen(context,
                                    screen: Myoffers(), withNavBar: false);
                              }),
                            })
                        .catchError((e) {
                      publishing = false;
                      setState(() {});
                      BaseDio.getDioError(e);
                    });
                  }
                },
                child: Container(
                  height: ScreenUtil().setHeight(40),
                  width: ScreenUtil().setWidth(320),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.blue),
                  child: Center(
                    child: publishing
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Publish Offer',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: ScreenUtil().setWidth(16),
                            ),
                          ),
                  ),
                ),
              ),

              SizedBox(
                height: ScreenUtil().setHeight(40),
              ),
            ],
          ),
        ),
      ),
    );
  }

//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

  addpackagedialogue() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: SizedBox(
              width: ScreenUtil().setWidth(400),
              child: Form(
                key: _formState,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        Text(
                          "Add Package",
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20)),
                      child: CustomTextFormField(
                        controller: _packagetitle,
                        validator: (value) =>
                            value!.isEmpty ? "This field is required" : null,
                        keyboardType: TextInputType.emailAddress,
                        showPassword: false,
                        hintText: 'Package Title',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20)),
                      child: CustomTextFormField(
                        controller: _packageprice,
                        validator: (value) =>
                            value!.isEmpty ? "This field is required" : null,
                        keyboardType: TextInputType.emailAddress,
                        showPassword: false,
                        hintText: 'Package Price',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20)),
                      child: CustomTextFormField(
                        controller: _packagelocation,
                        validator: (value) =>
                            value!.isEmpty ? "This field is required" : null,
                        keyboardType: TextInputType.emailAddress,
                        showPassword: false,
                        hintText: 'Prefered Location',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20)),
                      child: SizedBox(
                        height: ScreenUtil().setHeight(50),
                        width: ScreenUtil().setWidth(317),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                              // filled: true,
                              hintStyle: TextStyle(color: Colors.grey[100]),
                              hintText: "Package Time",
                              fillColor: Colors.red[100]),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(15),
                          ),
                          value: dropDownValue,
                          onChanged: (value) {
                            setState(() {
                              dropDownValue = value!;
                            });
                          },
                          items: catagories
                              .map((value) => DropdownMenuItem(
                                  value: value, child: Text(value)))
                              .toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    InkWell(
                      onTap: () {
                        if (_formState.currentState!.validate()) {
                          Offerpackage temp = Offerpackage(
                              packagePrice: double.parse(_packageprice.text),
                              packageServicetime: dropDownValue,
                              packagetitle: _packagetitle.text,
                              packagelocation: _packagelocation.text);
                          packages.add(temp);
                          _packageprice.clear();
                          _packagetitle.clear();
                          setState(() {});
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: const Text(
                          "Add Package",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
