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
  static getDriverQuery(driverIDNumber, driverName, driverPhone, vehicleCode, maxResultCount, skipCount) async {
    var res = await HttpManager.netFetch(Address.getDriverQuery() + "?DriverIdNumber=${driverIDNumber}&DriverName=${driverName}&DriverPhone=${driverPhone}&VehicleCode=${vehicleCode}&MaxResultCount=${maxResultCount}&SkipCount=${skipCount}", null, null, null);
    if(res != null && res.result){
      print("driverList: " + res.data.toString());
      //LocalStorage.save(Config.DRIVERS, json.encode(res.data['result']['items']));
      return new DataResult(res.data, true);

    }else{
      return new DataResult(res.data, false);
    }
  }
  ///获取单个司机信息
  static getSingleDriverInfo() async {
    var res = await HttpManager.netFetch(Address.getSingleDriverInfo() + "?", null, null, null);
    if(res != null && res.result){
      if(res.data["result"] != null){
        Driver driver = Driver.fromJson(res.data["result"]);
        return new DataResult(driver, true);
      }else{
        return new DataResult(null, true);
      }
    }
    if(res != null && !res.result){
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
      res = await HttpManager.netFetch(Address.setDriverUnlocking(), json.encode(requestParams), null, new Options(method: 'post'));
    }else{
      res = new DataResult('司机解锁失败，司机标识为空', false);
    }
    if(res != null && res.result){
      return DataResult(res.data, true);
    }else{
      return DataResult(res.data, false);
    }
  }
  ///司机换车
  static setDriverChangeVehicle(driverIdNumber, oldVehicleCode, newVehicleCode) async {
    var res;
    Map requestParams = {
      "driverIdNumber": driverIdNumber,
      "oldVehicleCode": oldVehicleCode,
      "newVehicleCode": newVehicleCode
    };
    if(driverIdNumber != null && oldVehicleCode != null && newVehicleCode != null){
      res = await HttpManager.netFetch(Address.setDriverChangeVehicle(), json.encode(requestParams), null, new Options(method: 'post'));
    }else{
      res = new DataResult('司机换车失败，输入参数为空', false);
    }
    if(res != null && res.result){
      return DataResult(res.data, true);
    }else{
      return DataResult(res.data, false);
    }
  }
}