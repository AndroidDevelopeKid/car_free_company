import 'package:car_free_company/common/model/TransportPlace.dart';
import 'package:car_free_company/page/DailySourcePlanPage.dart';
import 'package:car_free_company/page/DriverPage.dart';
import 'package:car_free_company/page/HistoryBillPage.dart';
import 'package:car_free_company/page/HomePage.dart';
import 'package:car_free_company/page/LoginInfoPage.dart';
import 'package:car_free_company/page/LoginPage.dart';
import 'package:car_free_company/page/PersonalSettingsPage.dart';
import 'package:car_free_company/page/VehicleCancelQueuePage.dart';
import 'package:car_free_company/page/VehicleInsteadQueuePage.dart';
import 'package:car_free_company/page/VehiclePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///控制页面跳转逻辑
class NavigatorUtils{
  ///主页
  static goHome(BuildContext context){
    Navigator.push(context, new CupertinoPageRoute(builder: (context) => new HomePage()));
  }
  ///登录页
  static goLogin(BuildContext context){
    //Navigator.pushReplacementNamed(context, LoginPage.sName);
  }

  ///历史提货单
  static goHistoryBill(BuildContext context){
    Navigator.push(context, new CupertinoPageRoute(builder: (context) => new HistoryBillPage()));
  }
  ///每日货源计划查询
  static goDailySourcePlan(BuildContext context){
    Navigator.push(context, new CupertinoPageRoute(builder: (context) => new DailySourcePlanPage()));
  }
  ///司机查询
  static goDriver(BuildContext context){
    Navigator.push(context, new CupertinoPageRoute(builder: (context) => new DriverPage()));
  }
  ///车辆查询
  static goVehicle(BuildContext context){
    Navigator.push(context, new CupertinoPageRoute(builder: (context) => new VehiclePage()));
  }
  ///车辆代排队
  static goVehicleInsteadQueue(BuildContext context){
    Navigator.push(context, new CupertinoPageRoute(builder: (context) => new VehicleInsteadQueuePage()));
  }
  ///取消排队
  static goVehicleCancelQueue(BuildContext context){
    Navigator.push(context, new CupertinoPageRoute(builder: (context) => new VehicleCancelQueuePage()));
  }
  ///个人设置
  static goPersonalSettings(BuildContext context){
    Navigator.push(context, new CupertinoPageRoute(builder: (context) => new PersonalSettingsPage()));
  }

  ///显示人员档案，车辆档案，人员及证件状态，车辆状态页
  static goDisplayUserInfo(BuildContext context, String title){
    switch(title){
      case "个人设置":
        Navigator.push(context, new CupertinoPageRoute(builder: (context) => new PersonalSettingsPage()));
        break;
      case "登录信息":
        Navigator.push(context, new CupertinoPageRoute(builder: (context) => new LoginInfoPage()));
        break;
    }
  }

  ///返回上一页，不带参数
  static void goBackWithNoParams(BuildContext context){
    Navigator.pop(context);
  }
  ///返回上一页，带参数
  static T goBackWithParams<T>(BuildContext context, T params){
    Navigator.pop(context, params);
    return params;

  }

}