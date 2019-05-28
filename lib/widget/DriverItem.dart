import 'package:car_free_company/common/dao/DriverDao.dart';
import 'package:car_free_company/common/model/Driver.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/common/utils/CommonUtils.dart';
import 'package:car_free_company/widget/CustomCardItem.dart';
import 'package:car_free_company/widget/CustomFlexButton.dart';
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
                    new Image.asset(CustomIcons.DRIVER_QUERY_SUB),
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
//                new Row(
//                  children: <Widget>[
//                    Expanded(
//                        child: new CustomFlexButton(
//                            text: '锁定',
//                            color: Colors.blue,
//                            onPress: (){
//                              DriverDao.setDriverLocking(driverItemViewModel.id).then((res){
//                                if(res != null && res.result){
//                                  CommonUtils.showShort('锁定成功');
//                                }
//                                if(res != null && !res.result){
//                                  CommonUtils.showShort(res.data["error"]["details"]);
//                                }
//                              });
//                            }
//                        )
//                    ),
//                    Padding(padding: EdgeInsets.all(5.0)),
//                    Expanded(
//                        child: new CustomFlexButton(
//                            text: '解锁',
//                            color: Colors.blue,
//                            onPress: (){}
//                        )
//                    ),
//                    Padding(padding: EdgeInsets.all(5.0)),
//                    Expanded(
//                        child: new CustomFlexButton(
//                            text: '换车',
//                            color: Colors.blue,
//                            onPress: (){}
//                        )
//                    )
//                  ],
//                )
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
  String id;

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
    id = driver.id;
  }


}