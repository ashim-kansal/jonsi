import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/common/CircleButton.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/components/MyAppBar.dart';
import 'package:kappu/net/http_client.dart';

import '../../common/ExpandableQuestionWidget.dart';
import '../../models/serializable_model/FaqModel.dart';

class FrequentlyAskedQuestions extends StatefulWidget {
  String? title = "ttt";

  FrequentlyAskedQuestions({this.title = ""});

  @override
  _FrequentlyAskedQuestionsState createState() =>
      _FrequentlyAskedQuestionsState();
}

class _FrequentlyAskedQuestionsState extends State<FrequentlyAskedQuestions> {
  bool showanser = false;
  bool showsecondanswer = true;
  bool show3rdanser = true;
  bool show4rthanser = true;
  bool show5thdanser = true;
  bool show6thanser = true;
  bool show7thanswer = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color_f2f7fd,
      appBar: MyAppBar(title: widget.title!,),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(18), 40.h, ScreenUtil().setWidth(18), 0),
        child:
        SingleChildScrollView(
          child: Column(children: [
            SizedBox(
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
          ]),
        ),

      ),
    );
  }
}
