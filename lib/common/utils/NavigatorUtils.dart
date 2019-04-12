import 'package:car_free_company/page/HomePage.dart';
import 'package:car_free_company/page/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///控制页面跳转逻辑
class NavigatorUtils{
  ///主页
  static goHome(BuildContext context){
    Navigator.pushReplacementNamed(context, HomePage.sName);
  }
  ///登录页
  static goLogin(BuildContext context){
    Navigator.pushReplacementNamed(context, LoginPage.sName);
  }

}