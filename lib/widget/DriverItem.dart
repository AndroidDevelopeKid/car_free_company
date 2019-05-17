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
                      driverItemViewModel.driverName ?? "无",
                    ),
                  ],
                ),
                new Padding(padding: EdgeInsets.all(10.0)),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      driverItemViewModel.personStateText ?? "人员状态",
                    ),
                    new Text(
                      driverItemViewModel.driverPhone ?? "电话号码",
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
  String driverIDNumber;//身份证号
  String driverName;//姓名
  String driverPhone;//电话
  String ouDisplayName;//所属物流公司 ??signingOrganization
  String personTypeText;//人员类型
  String vehicleCode;//车辆编号
  String certificateEndDate;//身份证到期日期
  String personStateText;//人员状态
  String buckupContactPerson;//备用联系人
  String buckupContactPersonAddress;//备用联系地址
  String buckupContactPersonPhone;//备用联系方式
  String driverLicenseID;//驾驶证号
  String dlCertificateEndDate;//驾驶证到期日期

  DriverItemViewModel.fromMap(Driver driver) {
    driverIDNumber = driver.driverIDNumber;
    driverName = driver.driverName;
    driverPhone = driver.driverPhone;
    ouDisplayName = driver.ouDisplayName;
    personTypeText = driver.personTypeText;
    vehicleCode = driver.vehicleCode;
    certificateEndDate = driver.certificateEndDate;
    personStateText = driver.personStateText;
    buckupContactPerson = driver.buckupContactPerson;
    buckupContactPersonAddress = driver.buckupContactPersonAddress;
    buckupContactPersonPhone = driver.buckupContactPersonPhone;
    driverLicenseID = driver.driverLicenseID;
    dlCertificateEndDate = driver.dlCertificateEndDate;
  }


}