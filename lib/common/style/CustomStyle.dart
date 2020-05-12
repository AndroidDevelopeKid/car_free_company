import 'package:flutter/material.dart';

///颜色
class CustomColors{
  static const int tableBackground = 0xffCCCCCC;
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
  static const String MY_FONT = "MyIcons";
  static const String FONT_FAMILY = 'MaterialIcons';

  ///首页image 图标
  static const String BANNER = "assets/images/banner.png";
  static const String CANCEL = "assets/images/cancel.png";
  static const String CUSTOMER = "assets/images/customer.png";
  static const String DAIRY = "assets/images/dairy.png";
  static const String DI_ZHI = "assets/images/dizhi.png";
  static const String DISPATCH = "assets/images/tiaozheng.png";
  static const String VEHICLE_TYPE = "assets/images/vehicletype.png";
  static const String VEHICLE_STATUS = "assets/images/vehiclestatus.png";
  static const String DRIVER = "assets/images/driver.png";
  static const String FORM = "assets/images/form.png";
  static const String FREIGHT_QUERY = "assets/images/freightquery.png";
  static const String HISTORY_BILL = "assets/images/history-bill.png";
  static const String ICON_MSG = "assets/images/icon_msg.png";
  static const String LOGO = "assets/images/LOGO.png";
  static const String MESSAGE_READ = "assets/images/icon_msg.png";
  static const String MESSAGE_UNREAD = "assets/images/messageunread.png";
  static const String MY_BACKGROUND = "assets/images/mybackground.png";
  static const String NO_MORE = "assets/images/nomore.png";
  static const String QUERY = "assets/images/query.png";
  static const String READ = "assets/images/read.png";
  static const String READ_PRESSED = "assets/images/readpressed.png";
  static const String SEND_BILL_EXCEPTION = "assets/images/sendbillexception.png";
  static const String SET_ALL_READ = "assets/images/setallread.png";
  static const String SOU_SUO = "assets/images/sousuo.png";
  static const String UNREAD = "assets/images/unread.png";
  static const String UNREAD_PRESSED = "assets/images/unreadpressed.png";
  static const String VEHICLE_QUERY = "assets/images/vehiclequery.png";
  static const String WELCOME = "assets/images/welcome.png";
  static const String ARROW_ICON = "assets/images/ic_arrow_right.png";
  static const String LOGIN_BACKGROUND = "assets/images/loginbackground.jpg";


  static const IconData USER_NAME = const IconData(0xe624, fontFamily: CustomIcons.MY_FONT);
  static const IconData PASSWORD = const IconData(0xe625, fontFamily: CustomIcons.MY_FONT);
  static const IconData BACK = const IconData(0xe610, fontFamily: CustomIcons.MY_FONT);

  static const IconData HOME_HOME = const IconData(0xe612, fontFamily: CustomIcons.MY_FONT);
  static const IconData HOME_HOME_ON = const IconData(0xe611, fontFamily: CustomIcons.MY_FONT);
  static const IconData HOME_MESSAGE = const IconData(0xe61b, fontFamily: CustomIcons.MY_FONT);
  static const IconData HOME_MESSAGE_ON = const IconData(0xe613, fontFamily:  CustomIcons.MY_FONT);
  static const IconData HOME_MY = const IconData(0xe616, fontFamily: CustomIcons.MY_FONT);
  static const IconData HOME_MY_ON = const IconData(0xe617, fontFamily: CustomIcons.MY_FONT);

  static const IconData ENTRY = const IconData(0xe61f, fontFamily: CustomIcons.MY_FONT);

  static const IconData USER_FILE = const IconData(0xe61e, fontFamily: CustomIcons.MY_FONT);
  static const IconData CHECK = const IconData(0xe627, fontFamily: CustomIcons.MY_FONT);
  static const IconData SOU = const IconData(0xe629, fontFamily: CustomIcons.MY_FONT);

}
///字体大小等
class CustomConstant{
  static const normalTextSize = 18.0;
  static const placeTextSize = 15.0;
  static const listFieldTextSize = 15.0;
  static const listFieldResultTextSize = 11.0;
  static const normalTextWhite = TextStyle(
    color: Color(CustomColors.textColorWhite),
    fontSize: normalTextSize,
  );
  static const hintText = TextStyle(
    fontSize: 13.0,
    color: Color(0x8A000000)
  );
  static const hintBlueText = TextStyle(
      fontSize: 15.0,
      color: Color(0xff4C88FF)
  );

  static const normalText = TextStyle(
      color: Color(CustomColors.mainTextColor),
      fontSize: normalTextSize
  );
  static const normalTextBlack = TextStyle(
    color: Color(CustomColors.textColorBlack),
    fontSize: normalTextSize,
  );
  static const placeTextBlack = TextStyle(
    color: Color(CustomColors.textColorBlack),
    fontSize: placeTextSize,
  );
  static const listFieldStyle = TextStyle(
    color: Color(0xff4C88FF),
    fontSize: listFieldTextSize,
  );
  static const listFieldResultStyle = TextStyle(
    color: Color(0xff000000),
    fontSize: listFieldResultTextSize,
  );
}