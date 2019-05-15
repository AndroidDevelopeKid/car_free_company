import 'package:car_free_company/common/model/Vehicle.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/widget/CustomCardItem.dart';
import 'package:flutter/material.dart';

class VehicleItem extends StatelessWidget {

  final VehicleItemViewModel vehicleItemViewModel;
  final VoidCallback onPressed;

  VehicleItem(this.vehicleItemViewModel,{this.onPressed}) : super();

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new CustomCardItem(
        child: new FlatButton(
          onPressed: onPressed,
          child:
          new Container(
            padding: const EdgeInsets.all(10.0),
            child: new Column(
              children: [
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Image.asset(CustomIcons.DAILY_PLAN_IMAGE),
                    new Text(
                      vehicleItemViewModel.vehicleCode == null ? "车辆编号" : vehicleItemViewModel.vehicleCode,
                    ),
                  ],
                ),
                new Padding(padding: EdgeInsets.all(10.0)),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      vehicleItemViewModel.vehicleStatus == null ? "车辆状态" : vehicleItemViewModel.vehicleStatus,
                    ),
                    new Text(
                      vehicleItemViewModel.plateNumber == null ? "车牌号" : vehicleItemViewModel.plateNumber,
                    ),
                  ],),
              ],
            ),
          ),
        ),
      ),

    );
  }
}

class VehicleItemViewModel {
  String vehicleCode;//车辆编号
  String plateNumber;//车牌号
  String logisticsCompany;//所属物流公司
  String vehicleType;//车辆类型
  String businessType;//业务类型
  String carType;//车型
  String vehicleStatus;//车辆状态
  String vehicleOwnerName;//车主姓名
  String vehicleOwnerIdNumber;//车主身份证号
  String vehicleOwnerContactMode;//车主联系方式
  String frameNumber;//车架号
  String engineNumber;//发动机编号
  String joinDate;//加盟日期

  VehicleItemViewModel.fromMap(Vehicle vehicle) {
    vehicleCode = vehicle.vehicleCode;
    plateNumber = vehicle.plateNumber;
    logisticsCompany = vehicle.logisticsCompany;
    vehicleType = vehicle.vehicleType;
    businessType = vehicle.businessType;
    vehicleCode = vehicle.vehicleCode;
    carType = vehicle.carType;
    vehicleStatus = vehicle.vehicleStatus;
    vehicleOwnerName = vehicle.vehicleOwnerName;
    vehicleOwnerIdNumber = vehicle.vehicleOwnerIdNumber;
    vehicleOwnerContactMode = vehicle.vehicleOwnerContactMode;
    frameNumber = vehicle.frameNumber;
    engineNumber = vehicle.engineNumber;
    joinDate = vehicle.joinDate;
  }


}