import 'dart:convert';

import 'package:car_free_company/common/dao/ResultDao.dart';
import 'package:car_free_company/common/model/Vehicle.dart';
import 'package:car_free_company/common/net/Address.dart';
import 'package:car_free_company/common/net/HttpApi.dart';
import 'package:dio/dio.dart';

class VehicleDao{

  ///车辆查询
  static getVehicleQuery(oUDisplayName, vehicleCode, mainVehiclePlate, models, maxResultCount, skipCount) async {
    var res = await HttpManager.netFetch(Address.getVehicleQuery() + "?OUDisplayName=${oUDisplayName}&VehicleCode=${vehicleCode}&MainVehiclePlate=${mainVehiclePlate}&ModelsText=${models}&MaxResultCount=${maxResultCount}&SkipCount=${skipCount}", null, null, null);
    if(res != null && res.result){
      print("vehicleList: " + res.data.toString());
      //LocalStorage.save(Config.DRIVERS, json.encode(res.data['result']['items']));
      return new DataResult(res.data, true);
    }else{
      return new DataResult(res.data, false);
    }
  }
  ///查询单个车辆信息
  static getSingleVehicleInfo() async {
    var res = await HttpManager.netFetch(Address.getSingleVehicleInfo() + "?", null, null, null);
    if(res != null && res.result){
      if(res.data["result"] != null){
        Vehicle vehicle = Vehicle.fromJson(res.data["result"]);
        return new DataResult(vehicle, true);
      }else{
        return new DataResult(null, true);
      }
    }
    if(res != null && !res.result){
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
  ///车辆调度
  static vehicleDispatch(id) async {
    var res;
    Map requestParams = {
      "idStr": id,
    };
    if(id != null){
      res = await HttpManager.netFetch(Address.vehicleDispatch(), json.encode(requestParams), null, new Options(method: 'post'));
    }else{
      res = new DataResult('车辆调度失败，车辆标识为空', false);
    }
    if(res != null && res.result){
      return DataResult(res.data, true);
    }else{
      return DataResult(res.data, false);
    }

  }
  ///代排队
  static setReplaceQueue(vehicleCode) async {
    var res = await HttpManager.netFetch(Address.replaceQueue() + "?VehicleCode=${vehicleCode}", null, null, null);
    if(res != null && res.result){
      print("vehicleList: " + res.data.toString());
      //LocalStorage.save(Config.DRIVERS, json.encode(res.data['result']['items']));
      return new DataResult(res.data, true);
    }else{
      return new DataResult(res.data, false);
    }
  }
  ///取消排队
  static setCancelQueue(vehicleCode) async {
    var res = await HttpManager.netFetch(Address.cancelQueue() + "?VehicleCode=${vehicleCode}", null, null, null);
    if(res != null && res.result){
      print("vehicleList: " + res.data.toString());
      //LocalStorage.save(Config.DRIVERS, json.encode(res.data['result']['items']));
      return new DataResult(res.data, true);
    }else{
      return new DataResult(res.data, false);
    }
  }
  //车型枚举
  static getVehicleModels() async {
    var res = await HttpManager.netFetch(Address.vehicleModels(), null, null, null);
    if(res != null && res.result){
      print("vehicleModels: " + res.data.toString());
      //LocalStorage.save(Config.DRIVERS, json.encode(res.data['result']['items']));
      return new DataResult(res.data, true);
    }else{
      return new DataResult(res.data, false);
    }
  }

}