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
                      vehicleItemViewModel.vehicleCode ?? "车辆编号",
                    ),
                  ],
                ),
                new Padding(padding: EdgeInsets.all(10.0)),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      vehicleItemViewModel.vehicleStateText ?? "车辆状态",
                    ),
                    new Text(
                      vehicleItemViewModel.mainVehiclePlate ?? "车牌号",
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
  String mainVehiclePlate;//车牌号
  String oUDisplayName;//所属物流公司
  String vehicleTypeText;//车辆类型
  String vehicleBusinessTypeText;//业务类型
  String modelsText;//车型
  String vehicleStateText;//车辆状态
  String ownerName;//车主姓名
  String ownerIDNumber;//车主身份证号
  String ownerPhone;//车主联系方式
  String frameNumber;//车架号
  String engineNumber;//发动机编号
  String joiningDate;//加盟日期

  VehicleItemViewModel.fromMap(Vehicle vehicle) {
    vehicleCode = vehicle.vehicleCode;
    mainVehiclePlate = vehicle.mainVehiclePlate;
    oUDisplayName = vehicle.oUDisplayName;
    vehicleTypeText = vehicle.vehicleTypeText;
    vehicleBusinessTypeText = vehicle.vehicleBusinessTypeText;
    vehicleCode = vehicle.vehicleCode;
    modelsText = vehicle.modelsText;
    vehicleStateText = vehicle.vehicleStateText;
    ownerName = vehicle.ownerName;
    ownerIDNumber = vehicle.ownerIDNumber;
    ownerPhone = vehicle.ownerPhone;
    frameNumber = vehicle.frameNumber;
    engineNumber = vehicle.engineNumber;
    joiningDate = vehicle.joiningDate;
  }


}