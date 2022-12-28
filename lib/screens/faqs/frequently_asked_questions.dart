import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FrequentlyAskedQuestions extends StatefulWidget {
  const FrequentlyAskedQuestions({Key? key}) : super(key: key);

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
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(18), 40.h, ScreenUtil().setWidth(18), 0),
        child: Column(children: [
          Row(
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
                width: ScreenUtil().setWidth(20),
              ),
              Text(
                "Faq's",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(22)),
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Expanded(
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Is installation required for all Services ?',
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(13)),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  showanser = !showanser;
                                });
                              },
                              icon: Icon(
                                showanser
                                    ? Icons.keyboard_arrow_up
                                    : Icons.arrow_forward_ios,
                              )),
                        ],
                      ),
                      if (showanser)
                        Text(
                          'Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(13),
                              color: Colors.grey),
                        ),
                      5.verticalSpace,
                      const Divider(thickness: 0.7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Here will be your Second Question ?',
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(13)),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  showsecondanswer = !showsecondanswer;
                                });
                              },
                              icon: Icon(showsecondanswer
                                  ? Icons.keyboard_arrow_up
                                  : Icons.arrow_forward_ios)),
                        ],
                      ),
                      if (showsecondanswer)
                        Text(
                          'Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(13),
                              color: Colors.grey),
                        ),
                      5.verticalSpace,
                      const Divider(thickness: 0.7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Here will be your third Question ?',
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(13)),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  show3rdanser = !show3rdanser;
                                });
                              },
                              icon: Icon(show3rdanser
                                  ? Icons.keyboard_arrow_up
                                  : Icons.arrow_forward_ios)),
                        ],
                      ),
                      if (show3rdanser)
                        Text(
                          'Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(13),
                              color: Colors.grey),
                        ),
                      5.verticalSpace,
                      const Divider(thickness: 0.7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Here will be your forth Question ?',
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(13)),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  show4rthanser = !show4rthanser;
                                });
                              },
                              icon: Icon(show4rthanser
                                  ? Icons.keyboard_arrow_up
                                  : Icons.arrow_forward_ios)),
                        ],
                      ),
                      if (show4rthanser)
                        Text(
                          'Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(13),
                              color: Colors.grey),
                        ),
                      5.verticalSpace,
                      const Divider(thickness: 0.7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Is installation required for all Services ?',
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(13)),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  show5thdanser = !show5thdanser;
                                });
                              },
                              icon: Icon(show5thdanser
                                  ? Icons.keyboard_arrow_up
                                  : Icons.arrow_forward_ios)),
                        ],
                      ),
                      if (show5thdanser)
                        Text(
                          'Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(13),
                              color: Colors.grey),
                        ),
                      5.verticalSpace,
                      const Divider(thickness: 0.7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Is installation required for all Services ?',
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(13)),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  show6thanser = !show6thanser;
                                });
                              },
                              icon: Icon(show6thanser
                                  ? Icons.keyboard_arrow_up
                                  : Icons.arrow_forward_ios)),
                        ],
                      ),
                      if (show6thanser)
                        Text(
                          'Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(13),
                              color: Colors.grey),
                        ),
                      5.verticalSpace,
                      const Divider(thickness: 0.7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Is installation required for all Services ?',
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(13)),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  show7thanswer = !show7thanswer;
                                });
                              },
                              icon: Icon(
                                show7thanswer
                                    ? Icons.keyboard_arrow_up
                                    : Icons.arrow_forward_ios,
                              )),
                        ],
                      ),
                      if (show7thanswer)
                        Text(
                          'Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(13),
                              color: Colors.grey),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
