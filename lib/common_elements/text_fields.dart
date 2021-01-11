import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart' as colors;

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
  final bool readOnly;
  final Function onTap;

  PrimaryTextField(
      {Key key,
      this.labelText,
      this.preIcon,
      this.postIcon,
      this.obscure = false,
      this.validator,
      this.controller,
      this.onSaved,
      this.maxLines = 1,
      this.keyboardType = TextInputType.text,
      this.initialValue = null,
      this.readOnly = false,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(primaryColor: colors.textScndry),
        child: TextFormField(
          onTap: onTap,
          readOnly: readOnly,
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
              labelStyle: TextStyle(fontSize: 25, color: colors.textScndry),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colors.textScndry))),
          style: TextStyle(fontSize: 20),
        ));
  }
}
