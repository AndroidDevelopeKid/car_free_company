import 'dart:convert';

import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/local/LocalStorage.dart';
import 'package:car_free_company/common/net/Address.dart';
import 'package:car_free_company/common/net/HttpApi.dart';
import 'package:car_free_company/common/net/ResultData.dart';
import 'package:dio/dio.dart';
import 'package:redux/redux.dart';

class UserDao{
  static login(company, userName, password, store) async{

    print("company login:" + company);
    String tenantId = Config.TENANT;
    await LocalStorage.save(Config.USER_NAME_KEY, userName);
    ///清除授权
    HttpManager.clearAuthorization();
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
      //redux 管理user状态
      //store.dispatch(new UpdateDriverAction(resultDataDriver.data));

    }
    return new ResultData(res.data, res.result, null);
  }
  ///初始化用户信息
  static initUserInfo(Store store) async {

  }
}