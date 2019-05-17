import 'dart:convert';

import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/dao/ResultDao.dart';
import 'package:car_free_company/common/local/LocalStorage.dart';
import 'package:car_free_company/common/model/Driver.dart';
import 'package:car_free_company/common/net/Address.dart';
import 'package:car_free_company/common/net/HttpApi.dart';
import 'package:dio/dio.dart';

class DriverDao{
  ///司机查询
  static getDriverQuery( driverIDNumber, driverName, driverPhone, ouDisplayName) async {
    var res = await HttpManager.netFetch(Address.getDriverQuery() + "?DriverIdNumber=${driverIDNumber}&DriverName=${driverName}&DriverPhone=${driverPhone}&OuDisplayName=${ouDisplayName}", null, null, null);
    if(res != null && res.result){
      print("driverList: " + res.data.toString());
      //LocalStorage.save(Config.DRIVERS, json.encode(res.data['result']['items']));


      return new DataResult(json.encode(res.data['result']['items']), true);

    }else{
      return new DataResult(res.data, false);
    }
  }
  ///司机锁定
  static setDriverLocking(id) async {
    var res;
    Map requestParams = {
      "id": id,
    };
    if(id != null){
      res = await HttpManager.netFetch(Address.setDriverLocking(), json.encode(requestParams), null, new Options(method: 'post'));
    }else{
      res = new DataResult('司机锁定失败，司机标识为空', false);
    }
    if(res != null && res.result){
      return DataResult(res.data, true);
    }else{
      return DataResult(res.data, false);
    }
  }
  ///司机解锁
  static setDriverUnlocking(id) async {
    var res;
    Map requestParams = {
      "id": id,
    };
    if(id != null){
      res = await HttpManager.netFetch(Address.setDriverLocking(), json.encode(requestParams), null, new Options(method: 'post'));
    }else{
      res = new DataResult('司机解锁失败，司机标识为空', false);
    }
    if(res != null && res.result){
      return DataResult(res.data, true);
    }else{
      return DataResult(res.data, false);
    }
  }
}