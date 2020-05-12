import 'dart:convert';

import 'package:car_free_company/common/dao/ResultDao.dart';
import 'package:car_free_company/common/model/VehicleSingle.dart';
import 'package:car_free_company/common/net/Address.dart';
import 'package:car_free_company/common/net/HttpApi.dart';
import 'package:dio/dio.dart';

class VehicleDao{

  ///车辆查询
  static getVehicleQuery(originalOUId, vehicleCode, mainVehiclePlate, models, vehicleState, maxResultCount, skipCount) async {
    var res = await HttpManager.netFetch(Address.getVehicleQuery() + "?OriginalOUId=${originalOUId}&VehicleCode=${vehicleCode}&MainVehiclePlate=${mainVehiclePlate}&Models=${models}&VehicleState=${vehicleState}&MaxResultCount=${maxResultCount}&SkipCount=${skipCount}", null, null, null);
    if(res != null && res.result){
      print("vehicleList: " + res.data.toString());
      //LocalStorage.save(Config.DRIVERS, json.encode(res.data['result']['items']));
      return new DataResult(res.data, true);
    }else{
      return new DataResult(res.data, false);
    }
  }
  ///查询单个车辆信息
  static getSingleVehicleInfo(id) async {
    var res = await HttpManager.netFetch(Address.getSingleVehicleInfo() + "?Id=${id}", null, null, null);
    if(res != null && res.result){
      if(res.data["result"] != null){
        VehicleSingle vehicle = VehicleSingle.fromJson(res.data["result"]);
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
      "id": id,
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
      "id": id,
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
  static vehicleDispatch(vehicleCode, group) async {
    var res;
    Map requestParams = {
      "vehicleCode": vehicleCode,
      "group": group
    };
    if(vehicleCode != null){
      res = await HttpManager.netFetch(Address.vehicleDispatchPost(), json.encode(requestParams), null, new Options(method: 'post'));
    }else{
      res = new DataResult('车辆调度失败，车辆标识为空', false);
    }
    if(res != null && res.result){
      return DataResult(res.data, true);
    }else{
      return DataResult(res.data, false);
    }

  }
  ///获取车辆分组
  static getVehicleGroup(vehicleCode) async {
    var res;
    if(vehicleCode != null){
      res = await HttpManager.netFetch(Address.vehicleDispatch() + "?VehicleCode=${vehicleCode}", null, null, null);
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
    Map requestParams = {
      "vehicleCode": vehicleCode,
    };
    var res = await HttpManager.netFetch(Address.replaceQueue(), json.encode(requestParams), null, new Options(method: 'post'));// + "?VehicleCode=${vehicleCode}"
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
    Map requestParams = {
      "vehicleCode": vehicleCode,
    };
    var res = await HttpManager.netFetch(Address.cancelQueue(), json.encode(requestParams), null, new Options(method: 'post'));
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

  //车辆状态
  static getVehicleState() async {
    var res = await HttpManager.netFetch(Address.vehicleState(), null, null, null);
    if(res != null && res.result){
      print("vehicleState: " + res.data.toString());
      //LocalStorage.save(Config.DRIVERS, json.encode(res.data['result']['items']));
      return new DataResult(res.data, true);
    }else{
      return new DataResult(res.data, false);
    }
  }
  //车辆分组
  static getVehicleGroupList() async {
    var res = await HttpManager.netFetch(Address.vehicleGroup(), null, null, null);
    if(res != null && res.result){
      print("vehicleGroupList: " + res.data.toString());
      //LocalStorage.save(Config.DRIVERS, json.encode(res.data['result']['items']));
      return new DataResult(res.data, true);
    }else{
      return new DataResult(res.data, false);
    }
  }

}