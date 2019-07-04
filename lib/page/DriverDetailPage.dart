


import 'package:car_free_company/common/dao/DriverDao.dart';
import 'package:car_free_company/common/model/Driver.dart';
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
  String _newVehicleCode = "";
  final TextEditingController newVehicleCodeController = new TextEditingController();
  final DriverItemViewModel model;
  _DriverDetailPage(this.model);

  Future<Driver> driverInfo;


  ///////////解锁，锁定，换车后刷新数据，获取单个司机信息
  Future<Driver> _getData() async {
    var res = await DriverDao.getSingleDriverInfo();
    if(res != null && res.result){
      return res.data;
    }
    if(res != null && !res.result){
      Driver dataNull = new Driver(null, null, null, null, null, null, null, null, null, null, null, null, null, null);
      return dataNull;
    }


  }
  ///////////

  @override
  void initState() {
    super.initState();
    newVehicleCodeController.value = new TextEditingValue(text: "");
    driverInfo = _getData();
  }
  @override
  void dispose() {
    newVehicleCodeController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        //resizeToAvoidBottomPadding: false, //键盘弹出覆盖，不重新布局
        backgroundColor: CustomColors.listBackground,
        appBar: new AppBar(
          title: new Text("司机详情"),
        ),

        body:new SingleChildScrollView(child: new Card(
          color: Color(CustomColors.displayCardBackground),
          //margin: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0, bottom: 30),
          margin: EdgeInsets.only(top: 6.0, bottom: 6.0, left: 4.0, right: 4.0),
          elevation: 8.0,
          child: new Container(
            child:FutureBuilder<Driver>(
              future: driverInfo,
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
                                Text("姓名：", style: CustomConstant.normalTextBlack),
                                Text(snapshot.data.driverName ?? "无", style: CustomConstant.normalTextBlack),
                              ]
                          ),
                          TableRow(
                              children: <Widget>[
                                Text("身份证号：", style: CustomConstant.normalTextBlack),
                                Text(snapshot.data.driverIDNumber ?? "无", style: CustomConstant.normalTextBlack),
                              ]
                          ),
                          TableRow(
                              children: <Widget>[
                                Text("联系电话：", style: CustomConstant.normalTextBlack),
                                Text(snapshot.data.driverPhone ?? "无", style: CustomConstant.normalTextBlack),
                              ]
                          ),
                          TableRow(
                              children: <Widget>[
                                Text("所属物流公司：", style: CustomConstant.normalTextBlack),
                                Text(snapshot.data.ouDisplayName ?? "无", style: CustomConstant.normalTextBlack),
                              ]
                          ),
                          TableRow(
                              children: <Widget>[
                                Text("人员类型：", style: CustomConstant.normalTextBlack),
                                Text(snapshot.data.personTypeText ?? "无", style: CustomConstant.normalTextBlack),
                              ]
                          ),
                          TableRow(
                              children: <Widget>[
                                Text("所属车辆编号：", style: CustomConstant.normalTextBlack),
                                Text(snapshot.data.vehicleCode ?? "无", style: CustomConstant.normalTextBlack),
                              ]
                          ),
                          TableRow(
                              children: <Widget>[
                                Text("人员状态：", style: CustomConstant.normalTextBlack),
                                Text(snapshot.data.personStateText ?? "无", style: CustomConstant.normalTextBlack),
                              ]
                          ),
                          TableRow(
                              children: <Widget>[
                                Text("身份证到期日：", style: CustomConstant.normalTextBlack),
                                Text(snapshot.data.certificateEndDate == "null" ? "无" : snapshot.data.certificateEndDate.substring(0,10), style: CustomConstant.normalTextBlack),
                              ]
                          ),
                          TableRow(
                              children: <Widget>[
                                Text("备用联系人：", style: CustomConstant.normalTextBlack),
                                Text(snapshot.data.buckupContactPerson ?? "无", style: CustomConstant.normalTextBlack),
                              ]
                          ),
                          TableRow(
                              children: <Widget>[
                                Text("备用联系地址：", style: CustomConstant.normalTextBlack),
                                Text(snapshot.data.buckupContactPersonAddress ?? "无", style: CustomConstant.normalTextBlack),
                              ]
                          ),
                          TableRow(
                              children: <Widget>[
                                Text("备用联系方式：", style: CustomConstant.normalTextBlack),
                                Text(snapshot.data.buckupContactPersonPhone ?? "无", style: CustomConstant.normalTextBlack),
                              ]
                          ),
                          TableRow(
                              children: <Widget>[
                                Text("驾驶证号：", style: CustomConstant.normalTextBlack),
                                Text(snapshot.data.driverLicenseID ?? "无", style: CustomConstant.normalTextBlack),
                              ]
                          ),
                          TableRow(
                              children: <Widget>[
                                Text("驾驶证到期日期：", style: CustomConstant.normalTextBlack),
                                Text(snapshot.data.dlCertificateEndDate == "null" ? "无" : snapshot.data.dlCertificateEndDate.toString().substring(0,10), style: CustomConstant.normalTextBlack),
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
                                    DriverDao.setDriverLocking(model.id).then((res){
                                      if(res != null && res.result){//106-临时停车
                                        setState(() {
                                          //model.personStateText = "106-
                                          driverInfo = _getData();
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
                                    DriverDao.setDriverUnlocking(model.id).then((res){
                                      if(res != null && res.result){
                                        setState(() {
                                          //model.personStateText = "101-正常";
                                          driverInfo = _getData();
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

                        ],
                      ),
                      //),
                      Padding(padding: EdgeInsets.all(10.0)),
                      new TextField(
                        textAlign: TextAlign.center,
                        onChanged: (String value) {
                          _newVehicleCode = value;
                        },
                        controller: newVehicleCodeController,
                        decoration: InputDecoration(
                            hintText: '输入新车号',
                            contentPadding: EdgeInsets.all(10.0),
                            border:
                            OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor),)
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10.0)),
                      //Expanded(child:
                      new CustomFlexButton(
                          text: '换车',
                          color: Colors.blue,
                          onPress: (){
                            DriverDao.setDriverChangeVehicle(model.driverIDNumber, model.vehicleCode, _newVehicleCode).then((res){
                              if(res != null && res.result){
                                setState(() {
                                  //model.vehicleCode = _newVehicleCode;
                                  driverInfo = _getData();
                                });
                                CommonUtils.showShort("换车成功");
                              }
                              if(res != null && !res.result){
                                CommonUtils.showShort(res.data['error']['message'].toString() + "-" + res.data["error"]["details"].toString());
                              }
                            });
                          }
                      )
                      //)
                    ],
                  );
                } else if (snapshot.hasError) {
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

        ),)


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