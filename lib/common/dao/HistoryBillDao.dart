import 'package:car_free_company/common/dao/ResultDao.dart';
import 'package:car_free_company/common/net/Address.dart';
import 'package:car_free_company/common/net/HttpApi.dart';

class HistoryBillDao{
  static getHistoryBills(dateBegin, dateEnd, loadPlace, unloadPlace, vehicleCode, mainVehiclePlate, maxResultCount, skipCount) async {
    var res = await HttpManager.netFetch(Address.getHistoryBill() + "?StartGenerateDate=${dateBegin}&EndGenerateDate=${dateEnd}&LoadPlaceId=${loadPlace}&UnloadPlaceId=${unloadPlace}&VehicleCode=${vehicleCode}&MainVehiclePlate=${mainVehiclePlate}&MaxResultCount=${maxResultCount}&SkipCount=${skipCount}", null, null, null);
    if(res != null && res.result){
      print("historyBillList: " + res.data.toString());
      //LocalStorage.save(Config.DRIVERS, json.encode(res.data['result']['items']));
      return new DataResult(res.data, true);
    }else{
      return new DataResult(res.data, false);
    }
  }

}