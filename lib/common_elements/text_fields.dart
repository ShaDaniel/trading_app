import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatelessWidget {
  final String labelText;
  final IconData preIcon;
  final Widget postIcon;
  final bool obscure;
  final FormFieldValidator validator;
  final TextEditingController controller;
  final Function onSaved;
  final int maxLines;
  final TextInputType keyboardType;
  final String initialValue;

  PrimaryTextField({
    Key key,
    this.labelText,
    this.preIcon,
    this.postIcon,
    this.obscure = false,
    this.validator,
    this.controller,
    this.onSaved,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.initialValue = "",
  });
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(primaryColor: Color(0xff2C1A1D)),
        child: TextFormField(
          initialValue: initialValue,
          keyboardType: keyboardType,
          maxLength: keyboardType == TextInputType.number ? 9 : null,
          inputFormatters: keyboardType == TextInputType.number
              ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
              : null,
          minLines: 1,
          maxLines: maxLines,
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
