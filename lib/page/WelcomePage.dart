import 'package:car_free_company/common/dao/UserDao.dart';
import 'package:car_free_company/common/redux/CustomState.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/common/utils/CommonUtils.dart';
import 'package:car_free_company/common/utils/NavigatorUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget{
  static final String sName = "/";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}
class _WelcomePageState extends State<WelcomePage>{
  bool hadInit = false;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    if(hadInit){
      return;
    }
    hadInit = true;
    ///防止多次进入
    CommonUtils.initStatusBarHeight(context);
    new Future.delayed(const Duration(seconds: 3),(){
      NavigatorUtils.goLogin(context);
    });
  }

  @override
  Widget build(BuildContext context){
        return new Container(
          color: Color(CustomColors.white),
          child: new Center(
            child: new Image(image: new AssetImage(CustomIcons.WELCOME_ICON)),
          ),
        );
  }
}