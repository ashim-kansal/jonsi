import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ValidationDialogBox extends StatefulWidget {
  /// Creates a widget combines of  [Container].
  /// [title], [descriptions], [onPressed] must not be null.
  ///
  /// This widget will return dialog to show validation.
  /// For e.g. if the user enter invalid credentials then will show dialog with appropriate [title] and [descriptions]
  const ValidationDialogBox(
      {Key? key,
      this.title,
      this.descriptions,
      required this.onPressed})
      : super(key: key);

  final String ?title, descriptions;
  final Function onPressed;

  @override
  _ValidationDialogBoxState createState() => _ValidationDialogBoxState();
}

class _ValidationDialogBoxState extends State<ValidationDialogBox> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        title: Text('Title'),
        elevation: 5,
        insetPadding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height - 380, left: 25, right: 25),
        backgroundColor: Colors.white,
        children: [
          Text('Title'),

        ],
    );
  }
}
