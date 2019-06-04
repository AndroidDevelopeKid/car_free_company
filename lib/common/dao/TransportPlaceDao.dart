import 'package:car_free_company/common/dao/ResultDao.dart';
import 'package:car_free_company/common/net/Address.dart';
import 'package:car_free_company/common/net/HttpApi.dart';

class TransportPlaceDao{
  static getTransportPlace() async {
    var res = await HttpManager.netFetch(Address.getTransportPlace(), null, null, null);
    if(res != null && res.result){
      print("transportPlace: " + res.data.toString());
      //LocalStorage.save(Config.DRIVERS, json.encode(res.data['result']['items']));
      return new DataResult(res.data, true);
    }else{
      return new DataResult(res.data, false);
    }
  }
}