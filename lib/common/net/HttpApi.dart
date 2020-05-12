import 'dart:collection';

import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/local/LocalStorage.dart';
import 'package:car_free_company/common/net/Code.dart';
import 'package:car_free_company/common/net/ResultData.dart';
import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';

///封装http请求
class HttpManager{
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
  static Map optionParams = {
    "timeoutMs": 15000,
    "token" : null,
    "authorizationCode": null,
  };
  ///清除授权
  static clearAuthorization(){
    optionParams["authorizationCode"] = null;
    LocalStorage.remove(Config.BEARER_KEY);
  }
  static getAuthorization() async{
    String bearer = await LocalStorage.get(Config.BEARER_KEY);
    if(bearer != null){
      optionParams["authorizationCode"] = bearer;
    }
    return bearer;
  }
  ///发起网络请求
  ///[url] 请求url
  ///[params] 请求参数
  ///[header] 请求头
  ///[option] 配置
  static netFetch(url, params, Map<String,String> header, Options option, {noTip = false}) async {
    //没有网络情况
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.none){
      return new ResultData(Code.errorHandleFunction(Code.NETWORK_ERROR, "", noTip), false, Code.NETWORK_ERROR);
    }

    Map<String, String> headers = new HashMap();
    if(header != null){
      headers.addAll(header);
    }

    ///授权码
    if(optionParams["authorizationCode"] == null){
      var authorizationCode = await getAuthorization();
      if(authorizationCode != null){
        optionParams["authorizationCode"] = authorizationCode;
      }
    }

    ///配置请求头
    headers["Authorization"] = optionParams["authorizationCode"];

    if(option != null){
      option.headers = headers;
    }else{
      option = new Options(method: "get");
      option.headers = headers;
    }
    ///超时时间
    option.connectTimeout = 15000;

    Dio dio = new Dio();
    Response response;
    try{
      response = await dio.request(url, data: params, options: option);
    } on DioError catch(e){
      Response errorResponse;
      if(e.response != null){
        errorResponse = e.response;
      }else{
        errorResponse = new Response();
      }
      if(e.type == DioErrorType.CONNECT_TIMEOUT){
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }

//      if(Config.DEBUG){
//       // print('请求异常: ' + e.response.data.toString() + "---" + e.response.statusCode.toString());
//        print('请求异常url: ' + url);
//      }

      //return new ResultData(errorResponse.data, false, errorResponse.statusCode);
      return new ResultData(Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip), false, errorResponse.statusCode);

    }
    ///网络请求成功后正常返回的数据debug
    if(Config.DEBUG){
      print('请求url: ' + url);
      print('请求头: ' + option.headers.toString());
      if(params != null){
        print('请求参数: ' + params.toString());
      }
      if(response != null){
        print('返回参数: ' + response.toString());
        print('返回码：' + response.statusCode.toString());
      }
      if(optionParams["authorizationCode"] != null){
        print('authorizationCode : ' + optionParams["authorizationCode"]);
      }
    }

    try{
      if(option.contentType != null && option.contentType.primaryType == "text"){
        return new ResultData(response.data, true, Code.SUCCESS);
      }else{
        var responseJson = response.data;
        if(response.statusCode == 200 && responseJson["result"] != null && headers["Authorization"] == null){
          optionParams["authorizationCode"] = "Bearer " +  responseJson["result"]["accessToken"];
          await LocalStorage.save(Config.BEARER_KEY, optionParams["authorizationCode"]);
        }
      }
      if(response.statusCode == 200 || response.statusCode == 201){
        return new ResultData(response.data, true, Code.SUCCESS, headers: response.headers);
      }
    }catch(e){
      print("e: " + e.toString());
      return new ResultData(response.data, false, response.statusCode);
    }
    return new ResultData(Code.errorHandleFunction(response.statusCode, "", noTip), false, response.statusCode);
  }
}