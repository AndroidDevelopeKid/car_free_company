import 'package:car_free_company/common/model/DriverBrief.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/widget/CustomCardItem.dart';
import 'package:flutter/material.dart';

class DriverItem extends StatelessWidget {

  final DriverItemViewModel driverItemViewModel;
  final VoidCallback onPressed;

  DriverItem(this.driverItemViewModel,{this.onPressed}) : super();

  @override
  Widget build(BuildContext context) {
    return  InkWell(
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
                                child: Image.asset(CustomIcons.DRIVER),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Text(
                                    driverItemViewModel.driverName ??
                                      "司机姓名",
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, top: 13.0),
                          child: Text(
                            driverItemViewModel.driverIDNumber ??
                                "身份证号",
                            style: TextStyle(fontSize: 13.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 26.0),
                    child: Text(
                      driverItemViewModel.vehicleCode ??
                          "车辆编号",
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
//      Container(
//      child:  CustomCardItem(
//        child:  FlatButton(
//          onPressed: onPressed,
//          child:
//           Container(
//            padding: const EdgeInsets.all(10.0),
//            child:  Column(
//              children: [
//                 Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                     Image.asset(CustomIcons.DRIVER),
//                     Text(
//                      driverItemViewModel.driverName ?? "无",
//                    ),
//                  ],
//                ),
//                 Padding(padding: EdgeInsets.all(10.0)),
//                 Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                     Text(
//                      driverItemViewModel.driverIDNumber ?? "身份证号",
//                    ),
//                     Text(
//                      driverItemViewModel.vehicleCode ?? "车辆编号",
//                    ),
//                  ],),
//              ],
//            ),
//          ),
//        ),
//      ),
//
//    );
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