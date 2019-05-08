import 'package:flutter/material.dart';

///颜色
class CustomColors{
  static const int white = 0xFFFFFFFF;
  static const int cardWhite = 0xFFFFFFFF;
  static const int textWhite = 0xFFFFFFFF;
  static const int primaryDarkValue = 0xFF121917;
  static const int black = 0xFF000000;
  static const int subLightTextColor = 0xffc4c4c4;

  static const int textColorWhite = white;
  static const int mainTextColor = primaryDarkValue;
  static const int textColorBlack = black;

  static const int displayCardBackground = 0xFFFFFFFF;//0xFFF5F5DC;
  static const int tableBorderColor = 0XFF7F7F7F;
  static const Color listBackground = Colors.blue;
}
///图标
class CustomIcons{
  static const String FONT_FAMILY = 'MaterialIcons';

  ///首页image 图标
  static const String HISTORY_BILL_IMAGE = "lib/static/images/historybill.ico";
  static const String CANCEL_QUEUE = "lib/static/images/cancelqueue.ico";
  static const String DAILY_SOURCE_PLAN = "lib/static/images/dailysourceplan.ico";
  static const String DISPATCH_EH = "lib/static/images/dispatcheh.ico";
  static const String DRIVER_QUERY = "lib/static/images/driverquery.ico";
  static const String VEHICLE_QUERY = "lib/static/images/vehiclequery.ico";
  static const String VEHICLE_QUEUE = "lib/static/images/vehiclequeue.ico";

  static const String LOGIN_FACE_IMAGE = "lib/static/images/user.ico";
  static const String WELCOME_ICON= "lib/static/images/welcome01.jpg";
  static const String LOGIN_BACKGROUND_IMAGE = "lib/static/images/loginbackground.jpeg";
  static const String ARROW_ICON = "lib/static/images/ic_arrow_right.png";
  static const String LOGIN_FACE_IMAGE_MY = "lib/static/images/userformy02.ico";
  static const String MESSAGE_IMAGE = "lib/static/images/message.ico";

  static const IconData HOME_HOME = const IconData(58819, fontFamily: CustomIcons.FONT_FAMILY);
  static const IconData HOME_NOTICE = const IconData(0xe0b7, fontFamily: CustomIcons.FONT_FAMILY);
  static const IconData LOGIN_PW = const IconData(0xe312, fontFamily: CustomIcons.FONT_FAMILY);
  static const IconData LOGIN_USER = const IconData(0xe851, fontFamily: CustomIcons.FONT_FAMILY);
  static const IconData HOME_MY = const IconData(0xe853, fontFamily: CustomIcons.FONT_FAMILY);
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
  static const normalTextBlack = TextStyle(
    color: Color(CustomColors.textColorBlack),
    fontSize: normalTextSize,
  );
}