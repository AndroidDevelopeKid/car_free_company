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
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10.0,
                            top: 15.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 13.0,
                                height: 14.0,
                                child: Image.asset(CustomIcons.VEHICLE_QUERY),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Text(
                                  vehicleItemViewModel.vehicleCode ??
                                      "车辆编号",
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, top: 13.0),
                          child: Text(
                            vehicleItemViewModel.mainVehiclePlate ??
                                "车牌号",
                            style: TextStyle(fontSize: 13.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 26.0),
                    child: Text(
                      vehicleItemViewModel.vehicleTypeText ??
                        "车辆类型",
                      style:
                      TextStyle(color: Color(0xff5AC426), fontSize: 13.0),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 9.0, bottom: 9.0),
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            border: Border.all(
              color: Color(0xffefefef),
              width: 1.0,
              style: BorderStyle.solid,
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
  String id;

  VehicleItemViewModel.fromMap(Vehicle vehicle) {
    vehicleCode = vehicle.vehicleCode;
    mainVehiclePlate = vehicle.mainVehiclePlate;
    oUDisplayName = vehicle.oUDisplayName;
    vehicleTypeText = vehicle.vehicleTypeText;
    vehicleBusinessTypeText = vehicle.vehicleBusinessTypeText;
    //vehicleCode;// = vehicle.vehicleCode;
    modelsText = vehicle.modelsText;
    vehicleStateText = vehicle.vehicleStateText;
    ownerName = vehicle.ownerName;
    ownerIDNumber = vehicle.ownerIDNumber;
    ownerPhone = vehicle.ownerPhone;
    frameNumber = vehicle.trailerFrameNumber;
    engineNumber = vehicle.engineNumber;
    joiningDate = vehicle.joiningDate;
    id = vehicle.id;
  }


}