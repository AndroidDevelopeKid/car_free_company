


import 'package:car_free_company/common/dao/VehicleDao.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/common/utils/CommonUtils.dart';
import 'package:car_free_company/widget/CustomFlexButton.dart';
import 'package:car_free_company/widget/VehicleItem.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

class VehicleDetailPage extends StatefulWidget{
  static final String name = "messageDetail";

  final VehicleItemViewModel model;

  VehicleDetailPage(this.model, {Key key}) : super(key:key);

  _VehicleDetailPage createState() => _VehicleDetailPage(model);
}

class _VehicleDetailPage extends State<VehicleDetailPage>{
  final VehicleItemViewModel model;
  _VehicleDetailPage(this.model);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: CustomColors.listBackground,
        appBar: new AppBar(
          title: new Text("司机详情"),
        ),

        body:
        new Card(
          color: Color(CustomColors.displayCardBackground),
          //margin: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0, bottom: 30),
          margin: EdgeInsets.only(top: 6.0, bottom: 6.0, left: 4.0, right: 4.0),
          elevation: 8.0,
          child: new Container(
            child:new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(child: new Table(
                  border: TableBorder.all(color: Color(CustomColors.tableBorderColor), width: 2.0, style: BorderStyle.solid),
                  children:
                  <TableRow>[
                    TableRow(
                        children: <Widget>[
                          Text("车辆编号：", style: CustomConstant.normalTextBlack),
                          Text(model.vehicleCode ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("车牌号：", style: CustomConstant.normalTextBlack),
                          Text(model.mainVehiclePlate ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("所属物流公司：", style: CustomConstant.normalTextBlack),
                          Text(model.oUDisplayName ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("车辆类型：", style: CustomConstant.normalTextBlack),
                          Text(model.vehicleTypeText ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("车务类型：", style: CustomConstant.normalTextBlack),
                          Text(model.vehicleBusinessTypeText ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("车型：", style: CustomConstant.normalTextBlack),
                          Text(model.modelsText ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("车辆状态：", style: CustomConstant.normalTextBlack),
                          Text(model.vehicleStateText ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("车主姓名：", style: CustomConstant.normalTextBlack),
                          Text(model.ownerName ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("车主身份证号：", style: CustomConstant.normalTextBlack),
                          Text(model.ownerIDNumber ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("车主联系方式：", style: CustomConstant.normalTextBlack),
                          Text(model.ownerPhone ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("车架号：", style: CustomConstant.normalTextBlack),
                          Text(model.frameNumber ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("发动机编号：", style: CustomConstant.normalTextBlack),
                          Text(model.engineNumber ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("加盟日期：", style: CustomConstant.normalTextBlack),
                          Text(model.joiningDate == "null" ? "0000-00-00" : model.joiningDate.toString().substring(0,10), style: CustomConstant.normalTextBlack),
                        ]
                    ),
                  ],
                ),),
                new Expanded(child: new Row(
                  children: <Widget>[
                    Expanded(
                        child: new CustomFlexButton(
                            text: '锁定',
                            color: Colors.blue,
                            onPress: (){
                              VehicleDao.setVehicleLocking(model.id).then((res){
                                if(res != null && res.result){
                                  CommonUtils.showShort('锁定成功');
                                }
                                if(res != null && !res.result){
                                  CommonUtils.showShort(res.data['error']['message'].toString() + "-" + res.data["error"]["details"].toString());
                                }
                              });
                            }
                        )
                    ),
                    Padding(padding: EdgeInsets.all(5.0)),
                    Expanded(
                        child: new CustomFlexButton(
                            text: '解锁',
                            color: Colors.blue,
                            onPress: (){
                              VehicleDao.setVehicleUnlocking(model.id).then((res){
                                if(res != null && res.result){
                                  CommonUtils.showShort('解锁成功');
                                }
                                if(res != null && !res.result){
                                  CommonUtils.showShort(res.data['error']['message'].toString() + "-" + res.data["error"]["details"].toString());
                                }
                              });
                            }
                        )
                    ),
                    Padding(padding: EdgeInsets.all(5.0)),
                    Expanded(
                        child: new CustomFlexButton(
                            text: '调度',
                            color: Colors.blue,
                            onPress: (){}
                        )
                    )
                  ],
                ))
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: CustomColors.listBackground,
                width: 0.7,
                style: BorderStyle.solid,
              ),
            ),
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
          ),

        ),

      ),
      onWillPop: _onBack,
    );
  }
  Future<bool> _onBack(){
    try{}catch(e){}finally{}
    Navigator.pop(context, true);
    return Future.value(false);
  }
}