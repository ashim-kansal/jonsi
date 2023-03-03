import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:kappu/common/validation_dialogbox.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/components/ProviderItem.dart';
import 'package:kappu/constants/storage_manager.dart';
import 'package:kappu/models/serializable_model/AddOrderResponse.dart';
import 'package:kappu/net/base_dio.dart';
import 'package:kappu/net/http_client.dart';

import '../../components/MyAppBar.dart';

class ProviderProfileScreen extends StatefulWidget {
  @override
  _ProviderProfileScreenState createState() => _ProviderProfileScreenState();
}

class _ProviderProfileScreenState extends State<ProviderProfileScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(title: "Profile detail"),
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.grey.withOpacity(0.1),
          child: Column(
            children: [
              const Divider(
                height: 0.5,
                color: Colors.grey,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 32,bottom: 32),
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 40,
                          backgroundImage:  NetworkImage(
                              'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
                      ),
                      SizedBox(width: 15,),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            StorageManager().name,
                            maxLines: 3,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            StorageManager().email,
                            maxLines: 3,
                            style: TextStyle(
                                color: AppColors.color_7B7D83,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ))
                    ],
                  )
              ),
              Expanded(
                  child: ListView(
                padding: EdgeInsets.all(20),
                shrinkWrap: true,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                    child: Row(
                      children: [
                        Image.asset('assets/icons/prf.png',
                            scale: 1.0),
                        SizedBox(width: 20,),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                            StorageManager().name,
                              maxLines: 3,
                              style: TextStyle(
                                  color: AppColors.color_7B7D83,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              "email",
                              maxLines: 3,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                    child: Row(
                      children: [
                        Image.asset('assets/icons/prf.png',
                            scale: 1.0),
                        SizedBox(width: 20,),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "email",
                              maxLines: 3,
                              style: TextStyle(
                                  color: AppColors.color_7B7D83,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              StorageManager().email,
                              maxLines: 3,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                    child: Row(
                      children: [
                        Image.asset('assets/icons/call.png',
                            scale: 1.0),
                        SizedBox(width: 20,),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Text(
                              "Phone Number",
                              maxLines: 3,
                              style: TextStyle(
                                  color: AppColors.color_7B7D83,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              StorageManager().phone.toString(),
                              maxLines: 3,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                ],
              ))
            ],
          ),
        ));
  }
}