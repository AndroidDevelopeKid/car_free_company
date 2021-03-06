import 'dart:convert';

import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/dao/ResultDao.dart';
import 'package:car_free_company/common/dao/TransportPlaceDao.dart';
import 'package:car_free_company/common/local/LocalStorage.dart';
import 'package:car_free_company/common/model/LoginInfo.dart';
import 'package:car_free_company/common/model/User.dart';
import 'package:car_free_company/common/net/Address.dart';
import 'package:car_free_company/common/net/HttpApi.dart';
import 'package:car_free_company/common/net/ResultData.dart';
import 'package:dio/dio.dart';

class UserDao{
  static login(companyId, userName, password) async{

    print("company login:" + companyId);
    String tenantId = companyId;

    //String tenantId = Config.TENANT;

    await LocalStorage.save(Config.USER_NAME_KEY, userName);
    await LocalStorage.save(Config.TENANT_ID, tenantId);
    ///清除授权
    HttpManager.clearAuthorization();
    ///清除缓存
//    await LocalStorage.remove(Config.USER_ID);
//    await LocalStorage.remove(Config.USER_INFO);
//    await LocalStorage.remove(Config.LOGIN_INFO);
//    await LocalStorage.remove(Config.DRIVERS);
//    await LocalStorage.remove(Config.TRANSPORT_PLACE);
    Map requestParams = {
      "usernameOrEmailAddress": userName,
      "password": password
    };
    Map<String,String> header = {
      "Abp.TenantId" : tenantId,
    };
    var res = await HttpManager.netFetch(Address.getAuthorization(), json.encode(requestParams), header, new Options(method: 'post'));
    if(Config.DEBUG){
      print("res and res.result and res.data: " + res.toString() + "---" + res.result.toString() + "---");
    }
    if(res != null && res.result){
      await LocalStorage.save(Config.PW_KEY, password);
      await LocalStorage.save(Config.USER_ID, res.data["result"]["userId"].toString());

//      var places = await TransportPlaceDao.getTransportPlace();
//      await LocalStorage.save(Config.TRANSPORT_PLACE, places);
      //redux 管理user状态
      //store.dispatch(new UpdateDriverAction(resultDataDriver.data));

    }
    return new ResultData(res.data, res.result, null);
  }

  ///个人设置
  static getPersonalSettings(userId) async {
    var res;
    if(userId != null){
      res = await HttpManager.netFetch(Address.getPersonalSettings(), null, null, null);// + "?Id=${userId}"
    }
    else{
      res = new DataResult("获取个人设置失败", false);
    }
    if(res != null && res.result){
      print("userInfo: " + res.data.toString());
      if(res.data["result"] != null){
        User user = User.fromJson(res.data["result"]);
        LocalStorage.save(Config.USER_INFO, json.encode(user.toJson()));
        print("userinfo.ls" + json.encode(user.toJson()));
        return new DataResult(user, true);
      }else{
        return new DataResult(null, true);
      }





    }else{
      return new DataResult(res.data, false);
    }
  }
  ///登陆信息
  static getLoginInformation(userId) async {
    var res;
    if(userId != null){
      res = await HttpManager.netFetch(Address.getLoginInformation() + "?UserId=${userId}", null, null, null);
    }
    else{
      res = new DataResult("获取登录信息失败", false);
    }
    if(res != null && res.result){
      print("loginInfo: " + res.data.toString());
      if(res.data["result"] != null){
        LoginInfo loginInfo = LoginInfo.fromJson(res.data["result"]);
        LocalStorage.save(Config.LOGIN_INFO, json.encode(loginInfo.toJson()));
        print("loginInfo.ls" + json.encode(loginInfo.toJson()));

        return new DataResult(loginInfo, true);
      }else{
        return new DataResult(null, true);
      }
    }else{
      return new DataResult(res.data, false);
    }
  }
  ///登陆信息
  static getTenants(maxResultCount, skipCount) async {
    HttpManager.clearAuthorization();
    var res = await HttpManager.netFetch(
        Address.getTenant() +
            "?MaxResultCount=${maxResultCount}&SkipCount=${skipCount}",
        null,
        null,
        null);
    if (res != null) {
      print("tenants: " + res.data.toString());
      return new DataResult(res.data, true);
    }
  }
  ///刷新token
  static refreshToken() async {
    String userName = await LocalStorage.get(Config.USER_NAME_KEY);
    String password = await LocalStorage.get(Config.PW_KEY);
    String tenantId = await LocalStorage.get(Config.TENANT_ID);

    ///清除授权
    HttpManager.clearAuthorization();
    Map requestParams = {
      //"tenancyName": "default",
      "usernameOrEmailAddress": userName,
      "password": password
    };

    Map<String, String> header = {
      "Abp.TenantId": tenantId,
    };
    await HttpManager.netFetch(Address.getAuthorization(),
        json.encode(requestParams), header, new Options(method: 'post'));
  }


}