import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/screens/search_screen/search_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SearchTextField extends StatefulWidget {
  final String hintext;

  final Function onSearchingComplete;
  const SearchTextField(
      {Key? key, required this.hintext, required this.onSearchingComplete})
      : super(key: key);

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.02,
      ),
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey),
        ),
        child: TextFormField(
          onTap: () {
            // pushDynamicScreen(context,
            //     screen: SearchScreen(), withNavBar: false);
          },
          controller: controller,
          onFieldSubmitted: (value) => {if (value.length > 2) {}},
          cursorColor: Colors.black,
          style: TextStyle(
            color: Colors.grey,
            fontSize: ScreenUtil().setSp(18),
          ),
          decoration: InputDecoration(
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.color_3f3c3c,
              ),
            ),
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
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFF6F6F6),
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFF6F6F6),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 5,
            ),
            hintText: widget.hintext,
            hintStyle: TextStyle(
              color: AppColors.text_desc,
              fontSize: ScreenUtil().setSp(14),
              fontFamily: "Montserrat-Regular",
            ),
            prefixIcon: Transform.scale(
              scale: 0.45,
              child: Image.asset(
                "assets/images/Search.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
