import 'package:flutter/material.dart';

///颜色
class CustomColors{
  static const int white = 0xFFFFFFFF;
  static const int cardWhite = 0xFFFFFFFF;
  static const int textWhite = 0xFFFFFFFF;
  static const int primaryDarkValue = 0xFF121917;

  static const int textColorWhite = white;
  static const int mainTextColor = primaryDarkValue;
}
///图标
class CustomIcons{
  static const String FONT_FAMILY = 'MaterialIcons';

  static const String LOGIN_FACE_IMAGE = "lib/static/images/user.ico";
  static const String WELCOME_ICON= "lib/static/images/welcome01.jpg";
  static const String LOGIN_BACKGROUND_IMAGE = "lib/static/images/loginbackground.jpeg";

  static const IconData LOGIN_PW = const IconData(0xe312, fontFamily: CustomIcons.FONT_FAMILY);
  static const IconData LOGIN_USER = const IconData(0xe851, fontFamily: CustomIcons.FONT_FAMILY);
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