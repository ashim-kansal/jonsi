import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/helperfunctions/screen_nav.dart';
import 'package:kappu/screens/register/social_signup.dart';

class ProviderHomeScreen extends StatefulWidget{

  const ProviderHomeScreen({Key? key}) : super(key: key);

  @override
  _ProviderHomeScreenState createState() => _ProviderHomeScreenState();


}
class _ProviderHomeScreenState extends State<ProviderHomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.blue,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Center(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.blue),
                ),
              )),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              child:
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(children: [
                CircleAvatar(
                  radius: ScreenUtil().setHeight(30),
                  backgroundImage:
                  NetworkImage('https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    width: ScreenUtil().setWidth(250),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          "john wing",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(16),
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              height: 1.4),
                        ),
                        Text(
                          "johnwing@gmail.com",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(12),
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              height: 1.4),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Current Balance : ',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(16),
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              height: 1.4),
                        ),
                      ],
                    ),
                  ),
                )
              ])
            ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Text(
                            "Seller mode  ",
                            style: TextStyle(
                                color: Color(0xFF000000), fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          Switch(
                            value: true,
                            onChanged: (b){
                            },
                            activeTrackColor: Colors.white,
                            activeColor: Colors.blue,
                          )
                        ],
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:  [
                                Image.asset('assets/images/ic_earning.jpg',
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.fill),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Earnings",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.text_desc,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width/2-20,
                      ),
                      Container(
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:  [
                                Image.asset('assets/images/ic_earning.jpg',
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.fill),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Earnings",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.text_desc,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width/2-20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:  [
                                Image.asset('assets/images/ic_earning.jpg',
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.fill),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Earnings",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.text_desc,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width/2-20,
                      ),
                      Container(
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:  [
                                Image.asset('assets/images/ic_earning.jpg',
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.fill),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Earnings",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.text_desc,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width/2-20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                "Project Completed\n",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xFF7B7D83), fontSize: 10),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "50 M+",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontFamily: 'Montserrat-Bold',
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                "Price Range\n",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xFF7B7D83), fontSize: 10),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  '\u{20AC}${5}-\u{20AC}${10}',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontFamily: 'Montserrat-Bold',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
