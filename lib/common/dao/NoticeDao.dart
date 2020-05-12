import 'dart:convert';

import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/dao/ResultDao.dart';
import 'package:car_free_company/common/net/Address.dart';
import 'package:car_free_company/common/net/HttpApi.dart';
import 'package:dio/dio.dart';

import 'UserDao.dart';

class NoticeDao{
  static getPagedUserNotifications(readState, skipCount) async {
    var res;
    if(readState == null){
      res = await HttpManager.netFetch(Address.getPagedUserNotifications()+ "?MaxResultCount=${Config.NOTICE_PAGE_SIZE}&SkipCount=$skipCount", null, null, null);
      if (res.code == Config.ERROR_CODE401 || res.code == Config.ERROR_CODE403) {
        await UserDao.refreshToken();
        res = await HttpManager.netFetch(
            Address.getPagedUserNotifications() +
                "?MaxResultCount=${Config.NOTICE_PAGE_SIZE}&SkipCount=${skipCount}",
            null,
            null,
            null);
      }
    }else{
      res = await HttpManager.netFetch(Address.getPagedUserNotifications()+ "?State=${readState}&MaxResultCount=${Config.NOTICE_PAGE_SIZE}&SkipCount=${skipCount}", null, null, null);
      if (res.code == Config.ERROR_CODE401 || res.code == Config.ERROR_CODE403) {
        await UserDao.refreshToken();
        res = await HttpManager.netFetch(
            Address.getPagedUserNotifications() +
                "?State=${readState}&?MaxResultCount=${Config.NOTICE_PAGE_SIZE}&SkipCount=${skipCount}",
            null,
            null,
            null);
      }
    }
    if(Config.DEBUG){
      print("getPagedUserNotifications res: " + res.toString() + "---" + res.result.toString() + "---");
    }
    if(res != null && res.result){
      return DataResult(res.data, res.result);
    }else{
      return DataResult("没有新的通知", false);
    }
  }
  static makeAllUserNotificationsAsRead() async {
    var res;
    res = await HttpManager.netFetch(Address.makeAllUserNotificationsAsRead(), null, null, new Options(method: 'post'));
    if (res.code == Config.ERROR_CODE401 || res.code == Config.ERROR_CODE403) {
      await UserDao.refreshToken();
      res = await HttpManager.netFetch(Address.makeAllUserNotificationsAsRead(), null, null, new Options(method: 'post'));
    }
    if(Config.DEBUG){
      print("makeAllUserNotificationsAsRead res: " + res.toString() + "---" + res.result.toString() + "---");
    }
    if(res != null && res.result){
      return DataResult(res.data, res.result);
    }else{
      return DataResult("", false);
    }
  }
  static makeNotificationAsRead(notificationId) async {
    Map requestParams = {
      "id":notificationId
    };
    var res = await HttpManager.netFetch(Address.makeNotificationAsRead(), json.encode(requestParams), null, new Options(method: 'post'));
    if(Config.DEBUG){
      print("makeNotificationAsRead res: " + res.toString() + "---" + res.result.toString() + "---");
    }
    if(res != null && res.result){
      return DataResult(res.data, res.result);
    }else{
      return DataResult("调用设置单条消息已读接口失败", false);
    }
  }
}