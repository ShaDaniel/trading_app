import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final String labelText;
  final IconData preIcon;
  final Widget postIcon;
  final bool obscure;
  final FormFieldValidator validator;
  final TextEditingController controller;
  final Function onSaved;

  PrimaryTextField({
    Key key,
    this.labelText,
    this.preIcon,
    this.postIcon,
    this.obscure = false,
    this.validator,
    this.controller,
    this.onSaved,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(primaryColor: Color(0xff2C1A1D)),
        child: TextFormField(
          onSaved: onSaved,
          obscureText: obscure,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
              labelText: labelText,
              prefixIcon: Icon(preIcon),
              suffixIcon: postIcon,
              labelStyle: TextStyle(fontSize: 25, color: Color(0xff2C1A1D)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff2C1A1D)))),
          style: TextStyle(fontSize: 20),
        ));
  }
}
