


import 'package:car_free_company/common/dao/DriverDao.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/common/utils/CommonUtils.dart';
import 'package:car_free_company/widget/CustomFlexButton.dart';
import 'package:car_free_company/widget/DriverItem.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

class DriverDetailPage extends StatefulWidget{
  static final String name = "messageDetail";

  final DriverItemViewModel model;

  DriverDetailPage(this.model, {Key key}) : super(key:key);

  _DriverDetailPage createState() => _DriverDetailPage(model);
}

class _DriverDetailPage extends State<DriverDetailPage>{
  final DriverItemViewModel model;
  _DriverDetailPage(this.model);
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
                          Text("姓名：", style: CustomConstant.normalTextBlack),
                          Text(model.driverName ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("身份证号：", style: CustomConstant.normalTextBlack),
                          Text(model.driverIDNumber ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("联系电话：", style: CustomConstant.normalTextBlack),
                          Text(model.driverPhone ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("所属物流公司：", style: CustomConstant.normalTextBlack),
                          Text(model.ouDisplayName ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("人员类型：", style: CustomConstant.normalTextBlack),
                          Text(model.personTypeText ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("所属车辆编号：", style: CustomConstant.normalTextBlack),
                          Text(model.vehicleCode ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("人员状态：", style: CustomConstant.normalTextBlack),
                          Text(model.personStateText ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("身份证到期日：", style: CustomConstant.normalTextBlack),
                          Text(model.certificateEndDate == "null" ? "0000-00-00" : model.certificateEndDate.substring(0,10), style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("备用联系人：", style: CustomConstant.normalTextBlack),
                          Text(model.buckupContactPerson ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("备用联系地址：", style: CustomConstant.normalTextBlack),
                          Text(model.buckupContactPersonAddress ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("备用联系方式：", style: CustomConstant.normalTextBlack),
                          Text(model.buckupContactPersonPhone ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("驾驶证号：", style: CustomConstant.normalTextBlack),
                          Text(model.driverLicenseID ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("驾驶证到期日期：", style: CustomConstant.normalTextBlack),
                          Text(model.dlCertificateEndDate == "null" ? "0000-00-00" : model.dlCertificateEndDate.toString().substring(0,10), style: CustomConstant.normalTextBlack),
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
                            DriverDao.setDriverLocking(model.id).then((res){
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
                            DriverDao.setDriverUnlocking(model.id).then((res){
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
                          text: '换车',
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