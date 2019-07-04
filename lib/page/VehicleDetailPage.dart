


import 'package:car_free_company/common/dao/VehicleDao.dart';
import 'package:car_free_company/common/model/Vehicle.dart';
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

  Future<Vehicle> vehicleInfo;

  Future<Vehicle> _getData() async {
    var res = await VehicleDao.getSingleVehicleInfo();
    if(res != null && res.result){
      return res.data;
    }
    if(res != null && !res.result){
      Vehicle dataNull = new Vehicle(null, null, null, null, null, null, null, null, null, null, null, null, null, null);
      return dataNull;
    }
  }

  @override
  void initState() {
    super.initState();
    vehicleInfo = _getData();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: CustomColors.listBackground,
        appBar: new AppBar(
          title: new Text("车辆详情"),
        ),
        body:new SingleChildScrollView(
          child: new Card(
          color: Color(CustomColors.displayCardBackground),
          //margin: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0, bottom: 30),
          margin: EdgeInsets.only(top: 6.0, bottom: 6.0, left: 4.0, right: 4.0),
          elevation: 8.0,
          child: new Container(
            child:FutureBuilder<Vehicle>(
                future: vehicleInfo,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        //new Expanded(child:
                        new Table(
                          border: TableBorder.all(color: Color(CustomColors.tableBorderColor), width: 2.0, style: BorderStyle.solid),
                          children:
                          <TableRow>[
                            TableRow(
                                children: <Widget>[
                                  Text("车辆编号：", style: CustomConstant.normalTextBlack),
                                  Text(snapshot.data.vehicleCode ?? "无", style: CustomConstant.normalTextBlack),
                                ]
                            ),
                            TableRow(
                                children: <Widget>[
                                  Text("车牌号：", style: CustomConstant.normalTextBlack),
                                  Text(snapshot.data.mainVehiclePlate ?? "无", style: CustomConstant.normalTextBlack),
                                ]
                            ),
                            TableRow(
                                children: <Widget>[
                                  Text("所属物流公司：", style: CustomConstant.normalTextBlack),
                                  Text(snapshot.data.oUDisplayName ?? "无", style: CustomConstant.normalTextBlack),
                                ]
                            ),
                            TableRow(
                                children: <Widget>[
                                  Text("车辆类型：", style: CustomConstant.normalTextBlack),
                                  Text(snapshot.data.vehicleTypeText ?? "无", style: CustomConstant.normalTextBlack),
                                ]
                            ),
                            TableRow(
                                children: <Widget>[
                                  Text("车务类型：", style: CustomConstant.normalTextBlack),
                                  Text(snapshot.data.vehicleBusinessTypeText ?? "无", style: CustomConstant.normalTextBlack),
                                ]
                            ),
                            TableRow(
                                children: <Widget>[
                                  Text("车型：", style: CustomConstant.normalTextBlack),
                                  Text(snapshot.data.modelsText ?? "无", style: CustomConstant.normalTextBlack),
                                ]
                            ),
                            TableRow(
                                children: <Widget>[
                                  Text("车辆状态：", style: CustomConstant.normalTextBlack),
                                  Text(snapshot.data.vehicleStateText ?? "无", style: CustomConstant.normalTextBlack),
                                ]
                            ),
                            TableRow(
                                children: <Widget>[
                                  Text("车主姓名：", style: CustomConstant.normalTextBlack),
                                  Text(snapshot.data.ownerName ?? "无", style: CustomConstant.normalTextBlack),
                                ]
                            ),
                            TableRow(
                                children: <Widget>[
                                  Text("车主身份证号：", style: CustomConstant.normalTextBlack),
                                  Text(snapshot.data.ownerIDNumber ?? "无", style: CustomConstant.normalTextBlack),
                                ]
                            ),
                            TableRow(
                                children: <Widget>[
                                  Text("车主联系方式：", style: CustomConstant.normalTextBlack),
                                  Text(snapshot.data.ownerPhone ?? "无", style: CustomConstant.normalTextBlack),
                                ]
                            ),
                            TableRow(
                                children: <Widget>[
                                  Text("车架号：", style: CustomConstant.normalTextBlack),
                                  Text(snapshot.data.frameNumber ?? "无", style: CustomConstant.normalTextBlack),
                                ]
                            ),
                            TableRow(
                                children: <Widget>[
                                  Text("发动机编号：", style: CustomConstant.normalTextBlack),
                                  Text(snapshot.data.engineNumber ?? "无", style: CustomConstant.normalTextBlack),
                                ]
                            ),
                            TableRow(
                                children: <Widget>[
                                  Text("加盟日期：", style: CustomConstant.normalTextBlack),
                                  Text(snapshot.data.joiningDate == "null" ? "无" : model.joiningDate.toString().substring(0,10), style: CustomConstant.normalTextBlack),
                                ]
                            ),
                          ],
                        ),
                        //),
                        Padding(padding: EdgeInsets.all(10.0)),
                        //new Expanded(child:
                        new Row(
                          children: <Widget>[
                            Expanded(
                                child: new CustomFlexButton(
                                    text: '锁定',
                                    color: Colors.blue,
                                    onPress: (){
                                      VehicleDao.setVehicleLocking(model.id).then((res){
                                        if(res != null && res.result){
                                          setState(() {
                                            vehicleInfo = _getData();
                                          });
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
                                          setState(() {
                                            vehicleInfo = _getData();
                                          });
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
                                    onPress: (){
                                      VehicleDao.vehicleDispatch(model.id).then((res){
                                        if(res != null && res.result){
                                          setState(() {
                                            vehicleInfo = _getData();
                                          });
                                          CommonUtils.showShort('调度成功');
                                        }
                                        if(res != null && !res.result){
                                          CommonUtils.showShort(res.data['error']['message'].toString() + "-" + res.data["error"]["details"].toString());
                                        }
                                      });
                                    }
                                )
                            )
                          ],
                        )
                        //)
                      ],
                    );
                  }else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                }),


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
        )
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