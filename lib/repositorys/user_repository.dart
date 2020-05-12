import 'dart:convert';

import 'package:car_free_company/common/local/LocalStorage.dart';
import 'package:car_free_company/common/net/HttpApi.dart';
import 'package:car_free_company/common/net/ResultData.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/net/Address.dart';

class UserRepository{
  Future<ResultData> authenticate({
    @required username,
    @required password,
    @required company}) async {
    ///缓存用户名
    await LocalStorage.save(Config.USER_NAME_KEY, username);
    ///清除授权
    HttpManager.clearAuthorization();
    ///清除缓存
    await LocalStorage.remove(Config.USER_ID);

    Map requestParams = {
      "usernameOrEmailAddress" : username,
      "password" : password
    };
    Map<String, String> header = {
      "Abp.TenantId" : company
    };

    return await HttpManager.netFetch(Address.getAuthorization(), json.encode(requestParams), header, new Options(method: 'post'));

  }

  Future<void> deleteToken() async {

  }

  Future<ResultData> getTenants(maxResultCount, skipCount) async {
    return await HttpManager.netFetch(Address.getTenant() + "?MaxResultCount=${maxResultCount}&SkipCount=${skipCount}", null, null, null);
  }

  Future<bool> hasToken() async {

    return false;
  }


}