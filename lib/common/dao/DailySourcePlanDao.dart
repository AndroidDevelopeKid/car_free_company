import 'package:car_free_company/common/dao/ResultDao.dart';
import 'package:car_free_company/common/net/HttpApi.dart';
import 'package:car_free_company/common/net/Address.dart';

class DailySourcePlanDao{
  static getDailySourcePlans(dateBegin, dateEnd, loadPlace, unloadPlace, maxResultCount, skipCount) async {
    var res = await HttpManager.netFetch(Address.getDailySourcePlans() + "?RecordDateStart=${dateBegin}&RecordDateEnd=${dateEnd}&LoadPlaceId=${loadPlace}&UnloadPlaceId=${unloadPlace}&MaxResultCount=${maxResultCount}&SkipCount=${skipCount}", null, null, null);
    if(res != null && res.result){
      print("vehicleList: " + res.data.toString());
      //LocalStorage.save(Config.DRIVERS, json.encode(res.data['result']['items']));
      return new DataResult(res.data, true);
    }else{
      return new DataResult(res.data, false);
    }
  }
}