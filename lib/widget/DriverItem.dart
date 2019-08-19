import 'package:car_free_company/common/dao/DriverDao.dart';
import 'package:car_free_company/common/model/Driver.dart';
import 'package:car_free_company/common/model/DriverBrief.dart';
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
                      driverItemViewModel.driverIDNumber ?? "身份证号",
                    ),
                    new Text(
                      driverItemViewModel.vehicleCode ?? "车辆编号",
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
  String vehicleCode;//车辆编号

  String id;

  DriverItemViewModel.fromMap(DriverBrief driverBrief) {
    driverIDNumber = driverBrief.driverIDNumber;
    driverName = driverBrief.driverName;
    driverPhone = driverBrief.driverPhone;
    vehicleCode = driverBrief.vehicleCode;
    id = driverBrief.id;
  }


}