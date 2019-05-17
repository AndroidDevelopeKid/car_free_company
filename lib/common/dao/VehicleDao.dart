import 'dart:convert';

import 'package:car_free_company/common/dao/ResultDao.dart';
import 'package:car_free_company/common/net/Address.dart';
import 'package:car_free_company/common/net/HttpApi.dart';
import 'package:dio/dio.dart';

class VehicleDao{

  ///车辆查询
  static getVehicleQuery(oUDisplayName, vehicleCode, mainVehiclePlate, models) async {
    var res = await HttpManager.netFetch(Address.getVehicleQuery() + "?OUDisplayName=${oUDisplayName}&VehicleCode=${vehicleCode}&MainVehiclePlate=${mainVehiclePlate}&Models=${models}", null, null, null);
    if(res != null && res.result){
      print("vehicleList: " + res.data.toString());
      //LocalStorage.save(Config.DRIVERS, json.encode(res.data['result']['items']));
      return new DataResult(json.encode(res.data['result']['items']), true);
    }else{
      return new DataResult(res.data, false);
    }
  }
  ///车辆锁定
  static setVehicleLocking(id) async {
    var res;
    Map requestParams = {
      "idStr": id,
    };
    if(id != null){
      res = await HttpManager.netFetch(Address.setVehicleLocking(), json.encode(requestParams), null, new Options(method: 'post'));
    }else{
      res = new DataResult('车辆锁定失败，车辆标识为空', false);
    }
    if(res != null && res.result){
      return DataResult(res.data, true);
    }else{
      return DataResult(res.data, false);
    }
  }
  ///车辆解锁
  static setVehicleUnlocking(id) async {
    var res;
    Map requestParams = {
      "idStr": id,
    };
    if(id != null){
      res = await HttpManager.netFetch(Address.setVehicleUnlocking(), json.encode(requestParams), null, new Options(method: 'post'));
    }else{
      res = new DataResult('车辆解锁失败，车辆标识为空', false);
    }
    if(res != null && res.result){
      return DataResult(res.data, true);
    }else{
      return DataResult(res.data, false);
    }
  }

}