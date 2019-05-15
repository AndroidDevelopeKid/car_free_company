import 'package:car_free_company/common/model/Driver.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/widget/CustomCardItem.dart';
import 'package:flutter/material.dart';

class DriverItem extends StatelessWidget {

  final DriverItemViewModel driverItemViewModel;
  final VoidCallback onPressed;

  DriverItem(this.driverItemViewModel,{this.onPressed}) : super();

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
                      driverItemViewModel.name == null ? "姓名" : driverItemViewModel.name,
                    ),
                  ],
                ),
                new Padding(padding: EdgeInsets.all(10.0)),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      driverItemViewModel.personStatus == null ? "人员状态" : driverItemViewModel.personStatus,
                    ),
                    new Text(
                      driverItemViewModel.phoneNumber == null ? "电话号码" : driverItemViewModel.phoneNumber,
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

class DriverItemViewModel {
  String idNumber;//身份证号
  String name;//姓名
  String phoneNumber;//电话
  String logisticsCompany;//所属物流公司
  String personType;//人员类型
  String vehicleCode;//车辆编号
  String idCardExpireDate;//身份证到期日期
  String personStatus;//人员状态
  String standbyContactPerson;//备用联系人
  String standbyContactAddress;//备用联系地址
  String standbyContactMode;//备用联系方式
  String driverLicenseNumber;//驾驶证号
  String driverLicenseExpireDate;//驾驶证到期日期

  DriverItemViewModel.fromMap(Driver driver) {
    idNumber = driver.idNumber;
    name = driver.name;
    phoneNumber = driver.phoneNumber;
    logisticsCompany = driver.logisticsCompany;
    personType = driver.personType;
    vehicleCode = driver.vehicleCode;
    idCardExpireDate = driver.idCardExpireDate;
    personStatus = driver.personStatus;
    standbyContactPerson = driver.standbyContactPerson;
    standbyContactAddress = driver.standbyContactAddress;
    standbyContactMode = driver.standbyContactMode;
    driverLicenseNumber = driver.driverLicenseNumber;
    driverLicenseExpireDate = driver.driverLicenseExpireDate;
  }


}