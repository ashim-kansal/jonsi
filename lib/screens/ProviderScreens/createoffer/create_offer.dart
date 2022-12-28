import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/net/http_client.dart';
import 'package:kappu/screens/register/widgets/text_field.dart';
import 'package:provider/provider.dart';
// import 'package:kappu/screens/createoffer/widgets/customdropdown.dart';
import '../../../models/serializable_model/Language.dart';
import '../../../provider/provider_provider.dart';
import 'addpackages.dart';

class CreateOffer extends StatefulWidget {
  const CreateOffer({Key? key}) : super(key: key);

  @override
  _CreateOfferState createState() => _CreateOfferState();
}

class _CreateOfferState extends State<CreateOffer> {
  final _formState = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _offertitle = TextEditingController();
  final TextEditingController _catagory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Consumer<ProviderProvider>(
            builder: (context, loggedinprovider, child) =>
                SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(45),
                            left: ScreenUtil().setWidth(15),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
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
                              SizedBox(
                                width: ScreenUtil().setWidth(30),
                              ),
                              Text(
                                'Create new Offer',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: ScreenUtil().setWidth(24),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //
                        Image.asset(
                          "assets/images/Servicesimage.png",
                          height: ScreenUtil().setHeight(250),
                        ),

                        Container(
                            height: ScreenUtil().setHeight(350),
                            decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: Form(
                              key: _formState,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Container(
                                      height: 6,
                                      width: ScreenUtil().setWidth(100),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(20),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ScreenUtil().setWidth(20)),
                                      child: CustomTextFormField(
                                        maxlines: 1,
                                        controller: _offertitle,
                                        hintText: 'Offer Title',
                                        keyboardType: TextInputType.text,
                                        validator: (value) => value!.isEmpty
                                            ? "Enter Offer Title"
                                            : null,
                                        bordercolor: Colors.white,
                                      )),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(5),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ScreenUtil().setWidth(20)),
                                      child: CustomTextFormField(
                                        controller: _descriptionController,
                                        hintText: 'Offer Description',
                                        keyboardType: TextInputType.text,
                                        validator: (value) => value!.isEmpty
                                            ? "Enter Offer Discription"
                                            : null,
                                        maxlines: 5,
                                        bordercolor: Colors.white,
                                      )),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(5),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ScreenUtil().setWidth(20)),
                                      child: Container()),
                                  // FutureBuilder(
                                  //     future: HttpClient()
                                  //         .getservicecatagorynbyid(
                                  //         loggedinprovider
                                  //             .provider.catagoryid
                                  //             .toString()),
                                  //     builder: (context,
                                  //         AsyncSnapshot<Category>
                                  //         catagory) {
                                  //       if (catagory.connectionState !=
                                  //           ConnectionState.done) {
                                  //         return const CircularProgressIndicator();
                                  //       }
                                  //       return CustomTextFormField(
                                  //         enabled: false,
                                  //         controller: _catagory,
                                  //         hintText: catagory.data!.name,
                                  //         keyboardType: TextInputType.text,
                                  //         validator: (vale) {
                                  //           return null;
                                  //         },
                                  //         bordercolor: Colors.white,
                                  //       );
                                  //     })
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.blue,
                                                  fontSize:
                                                      ScreenUtil().setWidth(16),
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
                                            if (_formState.currentState!
                                                .validate()) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddPackages(
                                                            offertittle:
                                                                _offertitle
                                                                    .text,
                                                            offerdescription:
                                                                _descriptionController
                                                                    .text,
                                                          )));
                                            }
                                          },
                                          child: Container(
                                            height: ScreenUtil().setHeight(40),
                                            width: ScreenUtil().setWidth(155),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Proceed',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.blue,
                                                  fontSize:
                                                      ScreenUtil().setWidth(16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ))
                      ]),
                )),
      ),
    );
  }
}

class ViewItem extends StatelessWidget {
  String item;
  bool itemSelected;
  final Function(String) selected;

  ViewItem(
      {Key? key,
      required this.item,
      required this.itemSelected,
      required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.only(left: size.width * .032, right: size.width * .098),
      child: Row(
        children: [
          SizedBox(
            height: 24.0,
            width: 24.0,
            child: Checkbox(
              value: itemSelected,
              onChanged: (val) {
                selected(item);
              },
              activeColor: Colors.blue,
            ),
          ),
          SizedBox(
            width: size.width * .025,
          ),
          Text(
            item,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 17.0,
            ),
          ),
        ],
      ),
    );
  }
}
