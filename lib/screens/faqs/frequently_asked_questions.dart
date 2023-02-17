import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/CircleButton.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/components/MyAppBar.dart';
import 'package:kappu/net/http_client.dart';

import '../../common/ExpandableQuestionWidget.dart';
import '../../models/serializable_model/FaqModel.dart';
import '../../models/serializable_model/HelpCenterResponse.dart';

class FrequentlyAskedQuestions extends StatelessWidget {
  String? title;
  String? detaill_title;
  String? desc;

  FrequentlyAskedQuestions({this.title = "",this.detaill_title = "",this.desc = ""});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color_f2f7fd,
      appBar: MyAppBar(title: "Faq's",),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Text("Freqently asked questions", style: TextStyle(color: Colors.black, fontSize: 22, fontFamily: "Montserrat-Bold"),),
                  SizedBox(height: 5,),
                  Text("Have questions? we're here to help.", style: TextStyle(color: AppColors.text_desc, fontSize: 14, fontFamily: "Montserrat-regular"),),
                  SizedBox(height: 20,),
                ],
              ),
            ),),
          Padding(
            padding: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(18), 40.h, ScreenUtil().setWidth(18), 0),
            child:
            SingleChildScrollView(
              child: SizedBox(
                  height: ScreenUtil().setHeight(590),
                  child: FutureBuilder(
                      future: HttpClient()
                          .getFaqs(),
                      builder: (context,
                          AsyncSnapshot<List<FaqModel>>
                          response) {
                        if (response.connectionState != ConnectionState.done) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          children: response.data!
                              .map((item) =>
                              ExpandableQuestionWidget(question: item.question, answer:item.answer,),
                          )
                              .toList(),
                        );
                      })),
            ),

          )
        ],
      ),
    );
  }
}

class HelpCenterQuestions extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color_f2f7fd,
      appBar: MyAppBar(title: "Help Center",),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  Text("For Service Providers", style: TextStyle(color: Colors.black, fontSize: 22, fontFamily: "Montserrat-Bold"),),
                  SizedBox(height: 5,),
                  Text("Your Urban Malta help center. We are here to \nsupport you", textAlign: TextAlign.justify,
                    style: TextStyle(color: AppColors.text_desc, fontSize: 14, fontFamily: "Montserrat-regular"),),
                  SizedBox(height: 20,),],
              ),
            ),),
          Padding(
            padding: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(18), 40.h, ScreenUtil().setWidth(18), 0),
            child:
            SingleChildScrollView(
              child:
              Container(
                  child: FutureBuilder(
                      future: HttpClient()
                          .getHelpCenter(),
                      builder: (context,
                          AsyncSnapshot<List<HelpCenterResponse>>
                          response) {
                        if (response.connectionState != ConnectionState.done) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          children: response.data!
                              .map((item) =>
                              Column(
                                  children:[
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(10,12,10,12),
                                        child: Text(item.heading??"",textAlign: TextAlign.center, style: TextStyle(color: AppColors.app_color, fontSize: 20, fontFamily: "Montserrat-Bold"),),

                                      ),
                                    ),
                                    ListView(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      children: item.body!
                                          .map((item1) =>
                                          ExpandableQuestionWidget(question: item1.question, answer:item1.answer,),
                                      )
                                          .toList(),
                                    )]
                              )
                          )
                              .toList(),
                        );
                      })),

            ),

          )
        ],
      ),
    );
  }
}

class PrivacyPolicyPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color_f2f7fd,
      appBar: MyAppBar(title: "Privacy Policy",),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  Text("Urban Malta Privacy Policy", style: TextStyle(color: Colors.black, fontSize: 22, fontFamily: "Montserrat-Bold"),),
                  SizedBox(height: 5,),
                  Text("Last update: December 05, 2022", style: TextStyle(color: AppColors.text_desc, fontSize: 14, fontFamily: "Montserrat-regular"),),
                  SizedBox(height: 20,),],
              ),
            ),),
          Padding(
            padding: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(18), 40.h, ScreenUtil().setWidth(18), 0),
            child:
            SingleChildScrollView(
              child:
              Container(
                  child: FutureBuilder(
                      future: HttpClient()
                          .getHelpCenter(),
                      builder: (context,
                          AsyncSnapshot<List<HelpCenterResponse>>
                          response) {
                        if (response.connectionState != ConnectionState.done) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          children: response.data!
                              .map((item) =>
                              Column(
                                  children:[
                                    Text(item.heading??""),
                                    ListView(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      children: item.body!
                                          .map((item1) =>
                                          ExpandableQuestionWidget(question: item1.question, answer:item1.answer,),
                                      )
                                          .toList(),
                                    )]
                              )
                          )
                              .toList(),
                        );
                      })),

            ),

          )
        ],
      ),
    );
  }
}



