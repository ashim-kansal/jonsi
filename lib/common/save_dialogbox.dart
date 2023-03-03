import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kappu/components/AppColors.dart';

class SaveDialogBox extends StatefulWidget {
  /// Creates a widget combines of  [Container].
  /// [title], [descriptions], [onPressed] must not be null.
  ///
  /// This widget will return dialog to show warning.
  /// For e.g. when user tap on report user icon will show [SaveDialogBox] to warn user about the action.
  const SaveDialogBox({
    Key? key,
    required this.title,
    required this.icon,
    required this.descriptions,
    required this.buttonTitle,
    required this.onPressed,
    this.buttonColor = AppColors.red,
  }) : super(key: key);

  final String title, descriptions, buttonTitle;
  final Color buttonColor;
  final IconData icon;
  final Function() onPressed;

  @override
  _SaveDialogBoxState createState() => _SaveDialogBoxState();
}

class _SaveDialogBoxState extends State<SaveDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Stack contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),

              Text(
                widget.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Color(0xff7B7D83),
                    fontSize: 12),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                  onTap:widget.onPressed,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: widget.buttonColor),
                    padding: EdgeInsets.only(
                        left: 25, right: 25, top: 10, bottom: 10),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
