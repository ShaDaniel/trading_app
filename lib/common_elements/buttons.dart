import 'package:flutter/material.dart';
import 'colors.dart' as colors;

class PrimaryButton extends StatelessWidget {
  final String _text;
  final Function _func;
  final List _funcArgs;

  PrimaryButton(this._text, this._func, [this._funcArgs]);
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        height: 50,
        minWidth: 140,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular((10))),
        child: FlatButton(
          onPressed: () => Function.apply(_func, _funcArgs, {}),
          child: Text(
            _text,
            style: TextStyle(fontSize: 25, color: colors.btnText),
          ),
          color: colors.btnBckgr,
        ));
  }
}

class SecondaryButton extends StatelessWidget {
  final String _text;
  final Function _func;
  final IconData _icon;

  SecondaryButton(this._text, this._func, [this._icon]);

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      icon: Icon(
        _icon,
        size: _icon == null ? 0 : 15,
      ),
      onPressed: () => _func(context),
      label: Text(_text, style: TextStyle(color: colors.btnText)),
      color: colors.btnBckgr,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular((10))),
    );
  }
}
