import 'package:car_free_company/common/dao/DriverDao.dart';
import 'package:car_free_company/common/model/Driver.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/common/utils/CommonUtils.dart';
import 'package:car_free_company/widget/CustomErrorReturnWidget.dart';
import 'package:car_free_company/widget/CustomFlexButton.dart';
import 'package:car_free_company/widget/CustomTableRowWidget.dart';
import 'package:car_free_company/widget/DriverItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DriverDetailPage extends StatefulWidget {
  static final String name = "messageDetail";

  final DriverItemViewModel model;

  DriverDetailPage(this.model, {Key key}) : super(key: key);

  _DriverDetailPage createState() => _DriverDetailPage(model);
}

class _DriverDetailPage extends State<DriverDetailPage> {
  var _changeDate = "";
  String _newVehicleCode = "";
  var csvalue = false;
  String _mainVehiclePlate = "";
  final TextEditingController plateNumberController =
  new TextEditingController();
  final TextEditingController newVehicleCodeController =
      new TextEditingController();
  var _dateChange =
  DateTime.now().add(new Duration()).toString().substring(0, 10);
  final DriverItemViewModel model;

  _DriverDetailPage(this.model);

  Future<Driver> driverInfo;

  _showDatePickerChange() async {
    DateTime _picker = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now().subtract(new Duration(days: 3000)),
      // 减 30 天
      lastDate: new DateTime.now().add(new Duration(days: 30)), // 加 30 天
    );
    if (_picker == null) return;
    setState(() {
      _changeDate = _picker.toString();
    });
  }

  ///////////解锁，锁定，换车后刷新数据，获取单个司机信息
  Future<Driver> _getData(id) async {
    var res = await DriverDao.getSingleDriverInfo(id);
    if (res != null && res.result) {
      return res.data;
    }
    if (res != null && !res.result) {
      Driver dataNull = new Driver(null, null, null, null, null, null, null,
          null, null, null, null, null, null, null, null, null);
      return dataNull;
    }
    Driver dataNull1 = new Driver(null, null, null, null, null, null, null,
        null, null, null, null, null, null, null, null, null);
    return dataNull1;
  }

  ///////////

  @override
  void initState() {
    super.initState();
    newVehicleCodeController.value = new TextEditingValue(text: "");
    driverInfo = _getData(model.id);
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
        appBar: AppBar(
          leading: IconButton(
              iconSize: 15.0,
              icon: Icon(CustomIcons.BACK, color: Color(0xff4C88FF)),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Text("司机详情",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
        ),
        body: SingleChildScrollView(child: FutureBuilder<Driver>(
            future: driverInfo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if(snapshot.data.personState == "101"){//司机未锁定
                  csvalue = false;
                }else{//已锁定
                  csvalue = true;
                }
                return Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 15.0, left: 25.0, right: 25.0, bottom: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        //new Expanded(child:
                        Table(
                          children: <TableRow>[
                            TableRow(
                              //decoration: BoxDecoration(color: Color(CustomColors.tableBackground) ),
                                children: <Widget>[
                                  CustomTableRowWidget(
                                    "姓名：",
                                    snapshot.data.driverName ?? "无",
                                  ),
                                ]),
                            TableRow(children: <Widget>[
                              CustomTableRowWidget(
                                "身份证号：",
                                snapshot.data.driverIDNumber ?? "无",
                              ),
                            ]),
                            TableRow(
                              //decoration: BoxDecoration(color: Color(CustomColors.tableBackground) ),
                                children: <Widget>[
                                  CustomTableRowWidget(
                                    "联系电话：",
                                    snapshot.data.driverPhone ?? "无",
                                  ),
                                ]),
                            TableRow(children: <Widget>[
                              CustomTableRowWidget(
                                "所属物流公司：",
                                snapshot.data.ouDisplayName ?? "无",
                              ),
                            ]),
                            TableRow(
                              //decoration: BoxDecoration(boxShadow: [new BoxShadow(color: Color(CustomColors.tableBackground), blurRadius: 0.5)],),
                                children: <Widget>[
                                  CustomTableRowWidget(
                                    "人员类型：",
                                    snapshot.data.personTypeText ?? "无",
                                  ),
                                ]),
                            TableRow(children: <Widget>[
                              CustomTableRowWidget(
                                "所属车辆编号：",
                                snapshot.data.vehicleCode ?? "无",
                              ),
                            ]),
                            TableRow(children: <Widget>[
                              CustomTableRowWidget(
                                "人员状态：",
                                snapshot.data.personStateText ?? "无",
                              ),
                            ]),
                            TableRow(children: <Widget>[
                              CustomTableRowWidget(
                                "身份证到期日：",
                                snapshot.data.certificateEndDate ?? "无",
                              ),
                            ]),
                            TableRow(children: <Widget>[
                              CustomTableRowWidget(
                                "备用联系人：",
                                snapshot.data.buckupContactPerson ?? "无",
                              ),
                            ]),
                            TableRow(children: <Widget>[
                              CustomTableRowWidget(
                                "备用联系地址：",
                                snapshot.data.buckupContactPersonAddress ?? "无",
                              ),
                            ]),
                            TableRow(children: <Widget>[
                              CustomTableRowWidget(
                                "备用联系方式：",
                                snapshot.data.buckupContactPersonPhone ?? "无",
                              ),
                            ]),
                            TableRow(children: <Widget>[
                              CustomTableRowWidget(
                                "驾驶证号：",
                                snapshot.data.driverLicenseID ?? "无",
                              ),
                            ]),
                            TableRow(children: <Widget>[
                              CustomTableRowWidget(
                                "驾驶证到期日期：",
                                snapshot.data.dlCertificateEndDate ?? "无",
                              ),
                            ]),
                          ],
                        ),
                        //),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              width: 85.0,
                              child: Text('锁定',
                                  style: CustomConstant.listFieldStyle),
                            ),
                            CupertinoSwitch(
                              value: this.csvalue,
                              activeColor: Color(0xff4C88FF),
                              onChanged: (bool value) {
                                setState(() {
                                  this.csvalue = value;
                                });
                                if (value) {
                                  //suoding
                                  DriverDao.setDriverLocking(model.id)
                                      .then((res) {
                                    if (res != null && res.result) {
                                      //106-临时停车
                                      setState(() {
                                        //model.personStateText = "106-
                                        driverInfo = _getData(model.id);
                                      });

                                      CommonUtils.showShort('锁定成功');
                                    }
                                    if (res != null && !res.result) {
                                      CommonUtils.showShort(res
                                          .data['error']['message']
                                          .toString() +
                                          "-" +
                                          res.data["error"]["details"]
                                              .toString());
                                    }
                                  });
                                }
                                if (!value) {
                                  //jiesuo
                                  DriverDao.setDriverUnlocking(model.id)
                                      .then((res) {
                                    if (res != null && res.result) {
                                      setState(() {
                                        //model.personStateText = "101-正常";
                                        driverInfo = _getData(model.id);
                                      });
                                      CommonUtils.showShort('解锁成功');
                                    }
                                    if (res != null && !res.result) {
                                      CommonUtils.showShort(res
                                          .data['error']['message']
                                          .toString() +
                                          "-" +
                                          res.data["error"]["details"]
                                              .toString());
                                    }
                                  });
                                }

                              },
                            ),
                          ],
                        ),
                        Divider(),
                        Padding(padding: EdgeInsets.all(5.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 15.0,
                                  height: 15.0,
                                  child: Image(
                                      image:
                                      AssetImage(CustomIcons.DISPATCH)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 6.0, right: 6.0),
                                ),
                                Text(
                                  "换车",
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ],
                            ),
                            GestureDetector(child: Padding(padding: EdgeInsets.only(right: 10.0), child: Text(
                              "保存",
                              style: CustomConstant.listFieldStyle,
                            ),),onTap: (){
                              if(_mainVehiclePlate == ""){
                                CommonUtils.showShort("请先输入车牌号再换车！");
                              }else{
                                showDialog(context: context,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        content: new SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[Text("是否要换车？")],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("确定"),
                                            onPressed: (){
                                              print("huanche:" + model.driverIDNumber);
                                              DriverDao.setDriverChangeVehicle(
                                                  model.driverIDNumber,
                                                  model.vehicleCode,
                                                  _newVehicleCode,
                                                  _changeDate)
                                                  .then((res) {
                                                if (res != null && res.result) {
                                                  setState(() {
                                                    //model.vehicleCode = _newVehicleCode;
                                                    driverInfo = _getData(model.id);
                                                  });
                                                  CommonUtils.showShort("换车成功");
                                                }
                                                if (res != null && !res.result) {
                                                  CommonUtils.showShort("换车失败");
                                                  //CommonUtils.showShort(res.data['error']['message'].toString() + "-" + res.data["error"]["details"].toString());
                                                }
                                                Navigator.pop(context);
                                              });
                                            },
                                          ),
                                          FlatButton(
                                            child: Text("取消"),
                                            onPressed: (){
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                        elevation: 20,
                                        // 设置成 圆角
                                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

                                      );
                                    });
                              }



                            },),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 85.0,
                              child: Text("车牌号",
                                  style: CustomConstant.listFieldStyle),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.only(left: 15.0, right: 15.0),
                              child: Text(
                                "|",
                                style: TextStyle(
                                    color: Color(0xffE2EAFF),
                                    fontSize: 12.0),
                              ),
                            ),
                            SizedBox(
                              width: 135.0,
                              child: TextField(
                                textAlign: TextAlign.center,
                                onChanged: (String value) {
                                  _mainVehiclePlate = value;
                                },
                                controller: plateNumberController,
                                decoration: InputDecoration(
                                    hintText: '点击输入车牌号',
                                    hintStyle: TextStyle(fontSize: 15.0),
                                    contentPadding: EdgeInsets.all(0.0),

                                    border: InputBorder.none),

                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 85.0,
                              child: Text("日期",
                                  style: CustomConstant.listFieldStyle),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.only(left: 15.0, right: 15.0),
                              child: Text(
                                "|",
                                style: TextStyle(
                                    color: Color(0xffE2EAFF),
                                    fontSize: 12.0),
                              ),
                            ),
                            SizedBox(width: 135.0, child: GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 13.0,
                                    width: 13.0,
                                    child: Image.asset(CustomIcons.DAIRY),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 7.0),
                                  ),
                                  Text(
                                      _dateChange == ""
                                          ? DateTime.now()
                                          .toString()
                                          .substring(0, 10)
                                          : _dateChange
                                          .toString()
                                          .substring(0, 10),
                                      style: CustomConstant.hintText),
                                ],
                              ),
                              //onPressed: () => _showDatePickerEnd(),
                              onTap: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    maxTime: DateTime.now()
                                        .add(Duration(days: 30)),
                                    minTime: DateTime(1900, 1, 1),
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.zh, onConfirm: (date) {
                                      setState(() {
                                        _dateChange = date.toString();
                                      });
                                    });
                              },
                            ),)
                            ,


                          ],
                        ),

//                        Row(
//                          children: <Widget>[
//                            Expanded(
//                              child: new TextField(
//                                textAlign: TextAlign.center,
//                                onChanged: (String value) {
//                                  _newVehicleCode = value;
//                                },
//                                controller: newVehicleCodeController,
//                                decoration: InputDecoration(
//                                    hintText: '输入新车号',
//                                    contentPadding: EdgeInsets.all(6.0),
//                                    border: OutlineInputBorder(
//                                      borderSide: BorderSide(
//                                          color:
//                                          Theme.of(context).primaryColor),
//                                    )),
//                              ),
//                            ),
//                            Padding(padding: EdgeInsets.all(5.0)),
//                            Expanded(
//                              child: new OutlineButton(
//                                child: new Text(
//                                  _changeDate == ""
//                                      ? DateTime.now()
//                                      .toString()
//                                      .substring(0, 10)
//                                      : _changeDate.toString().substring(0, 10),
//                                  style: CustomConstant.hintText,
//                                ),
//                                color: Color(CustomColors.white),
//                                borderSide: new BorderSide(color: Colors.grey),
//                                onPressed: () => _showDatePickerChange(),
//                              ),
//                            ),
//                          ],
//                        ),
//
//                        Padding(padding: EdgeInsets.all(5.0)),
//                        //Expanded(child:
//                        CustomFlexButton(
//                            text: '换车',
//                            color: Colors.blue,
//                            onPress: () {
//                              print("huanche:" + model.driverIDNumber);
//                              DriverDao.setDriverChangeVehicle(
//                                  model.driverIDNumber,
//                                  model.vehicleCode,
//                                  _newVehicleCode,
//                                  _changeDate)
//                                  .then((res) {
//                                if (res != null && res.result) {
//                                  setState(() {
//                                    //model.vehicleCode = _newVehicleCode;
//                                    driverInfo = _getData(model.id);
//                                  });
//                                  CommonUtils.showShort("换车成功");
//                                }
//                                if (res != null && !res.result) {
//                                  //CommonUtils.showShort("换车失败");
//                                  CommonUtils.showShort(res.data['error']
//                                  ['message']
//                                      .toString() +
//                                      "-" +
//                                      res.data["error"]["details"].toString());
//                                }
//                              });
//                            })
                        //)
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.0),
                    border: Border.all(
                      color: Color(0xffF9FBFF),
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return CustomErrorReturnWidget();
              }
              return SizedBox(height: 2.0, child: LinearProgressIndicator());
            }),)
        ,
      ),
      onWillPop: _onBack,
    );
  }

  Future<bool> _onBack() {
    try {} catch (e) {} finally {}
    Navigator.pop(context, true);
    return Future.value(false);
  }
}
