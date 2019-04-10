import 'package:flutter/material.dart';

///颜色
class CustomColors{
  static const int white = 0xFFFFFFFF;
  static const int primaryDarkValue = 0xFF121917;

  static const int textColorWhite = white;
  static const int mainTextColor = primaryDarkValue;
}
///图标
class CustomIcons{
  static const String LOGIN_FACE_IMAGE = "lib/static/images/user.ico";
}
///字体大小等
class CustomConstant{
  static const normalTextSize = 18.0;
  static const normalTextWhite = TextStyle(
    color: Color(CustomColors.textColorWhite),
    fontSize: normalTextSize,
  );

  static const normalText = TextStyle(
      color: Color(CustomColors.mainTextColor),
      fontSize: normalTextSize
  );
}