import 'package:car_free_company/common/dao/VehicleDao.dart';
import 'package:car_free_company/common/model/VehicleGroup.dart';
import 'package:car_free_company/common/model/VehicleSingle.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/common/utils/CommonUtils.dart';
import 'package:car_free_company/widget/CustomErrorReturnWidget.dart';
import 'package:car_free_company/widget/CustomFlexButton.dart';
import 'package:car_free_company/widget/CustomTableRowWidget.dart';
import 'package:car_free_company/widget/VehicleItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VehicleDetailPage extends StatefulWidget {
  static final String name = "messageDetail";

  final VehicleItemViewModel model;

  VehicleDetailPage(this.model, {Key key}) : super(key: key);

  _VehicleDetailPage createState() => _VehicleDetailPage(model);
}

class _VehicleDetailPage extends State<VehicleDetailPage> {
  final VehicleItemViewModel model;

  _VehicleDetailPage(this.model);

  var _newGroup; //派车分组
  final TextEditingController newGroupController = new TextEditingController();

  var _groupId = "";
  var _groupText = "";
  var csvalue = false;

  var selectedGroup;
  var selectedIdGroup;

  Future<VehicleSingle> vehicleInfo;

  Future<VehicleSingle> _getData(id) async {
    var res = await VehicleDao.getSingleVehicleInfo(model.id);
    if (res != null && res.result) {
      return res.data;
    }
    if (res != null && !res.result) {
      VehicleSingle dataNull = new VehicleSingle(
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null);
      return dataNull;
    }
    VehicleSingle dataNull1 = new VehicleSingle(
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null);
    return dataNull1;
  }

  @override
  void initState() {
    super.initState();
    newGroupController.value = new TextEditingValue(text: "");
    vehicleInfo = _getData(model.id);
  }

  @override
  void dispose() {
    newGroupController.dispose();
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
          title: Text("车辆详情",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<VehicleSingle>(
              future: vehicleInfo,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var currentGroup = "";//当前分组
                  if (snapshot.data.vehicleState == "101") {
                    //车辆未锁定
                    csvalue = false;
                  } else {
                    //已锁定
                    csvalue = true;
                  }
                  try{
                    //获取当前分组
                    VehicleDao.getVehicleGroup(snapshot.data.vehicleCode)
                        .then((groups) {
                      if (groups != null && groups.result) {
                        var groupList = groups.data["result"]["items"];
                        var groupActive;
                        for (int i = 0; i < groupList.length; i++) {
                          if (groupList[i]["isActive"])
                            groupActive = groupList[i];
                        }
                        var organizationUnitId =
                        groupActive["organizationUnitId"];
                        var organizationUnitName =
                        groupActive["organizationUnitName"];
                        var vehicleCode = groupActive["vehicleCode"];
                        var group = groupActive["group"];
                        var groupText = groupActive["groupText"];
                        var isActive = groupActive["isActive"];
                        var id = groupActive["id"];

                        currentGroup = groupText;
//*****************
//                      showDialog(
//                          context: context,
//                          barrierDismissible: false,
//                          builder: (BuildContext context) {
//                            return AlertDialog(
//                                title: Text("车辆调度"),
//                                content: Column(
//                                    mainAxisSize: MainAxisSize.min,
//                                    children: <Widget>[
//                                      Text("所属业务单位: " + organizationUnitName),
//                                      Text("当前分组: " + groupText),
//                                      Text("是否激活: ${isActive ? "是" : "否"}"),
//                                      Text("即将调去的分组: " + _groupText),
//                                      Padding(padding: EdgeInsets.all(10.0)),
//                                      Row(
//                                        mainAxisAlignment:
//                                            MainAxisAlignment.spaceAround,
//                                        children: <Widget>[
//                                          FlatButton(
//                                              child: Text(
//                                                "取消",
//                                                style: TextStyle(
//                                                    color: Colors.blue),
//                                              ),
//                                              onPressed: () {
//                                                Navigator.pop(context);
//                                              }),
//                                          FlatButton(
//                                            child: Text(
//                                              "调度",
//                                              style:
//                                                  TextStyle(color: Colors.blue),
//                                            ),
//                                            onPressed: () {
//                                              print("sss: " +
//                                                  vehicleCode +
//                                                  "--" +
//                                                  group);
//                                            },
//                                          ),
//                                        ],
//                                      ),
//                                    ]));
//                          });
                        //*****************
                      }

                      if (groups != null && !groups.result) {
                        //CommonUtils.showShort(groups.data['error']['message'].toString() + "-" + groups.data["error"]["details"].toString());
                      }
                    });
                  }catch(e){}finally{}

                  return Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 15.0, left: 25.0, right: 25.0, bottom: 15.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Table(
                              children: <TableRow>[
                                TableRow(children: <Widget>[
                                  CustomTableRowWidget(
                                    "车辆编号：",
                                    snapshot.data.vehicleCode ?? "无",
                                  ),
                                ]),
                                TableRow(children: <Widget>[
                                  CustomTableRowWidget(
                                    "车牌号：",
                                    snapshot.data.mainVehiclePlate ?? "无",
                                  ),
                                ]),
                                TableRow(children: <Widget>[
                                  CustomTableRowWidget(
                                    "所属物流公司：",
                                    snapshot.data.oUDisplayName ?? "无",
                                  ),
                                ]),
                                TableRow(children: <Widget>[
                                  CustomTableRowWidget(
                                    "车辆类型：",
                                    snapshot.data.vehicleTypeText ?? "无",
                                  ),
                                ]),
                                TableRow(children: <Widget>[
                                  CustomTableRowWidget(
                                    "车务类型：",
                                    snapshot.data.vehicleBusinessTypeText ??
                                        "无",
                                  ),
                                ]),
                                TableRow(children: <Widget>[
                                  CustomTableRowWidget(
                                    "车型：",
                                    snapshot.data.modelsText ?? "无",
                                  ),
                                ]),
                                TableRow(children: <Widget>[
                                  CustomTableRowWidget(
                                    "车辆状态：",
                                    snapshot.data.vehicleStateText ?? "无",
                                  ),
                                ]),
                                TableRow(children: <Widget>[
                                  CustomTableRowWidget(
                                    "车主姓名：",
                                    snapshot.data.ownerName ?? "无",
                                  ),
                                ]),
                                TableRow(children: <Widget>[
                                  CustomTableRowWidget(
                                    "车主身份证号：",
                                    snapshot.data.ownerIDNumber ?? "无",
                                  ),
                                ]),
                                TableRow(children: <Widget>[
                                  CustomTableRowWidget(
                                    "车主联系方式：",
                                    snapshot.data.ownerPhone ?? "无",
                                  ),
                                ]),
                                TableRow(children: <Widget>[
                                  CustomTableRowWidget(
                                    "车架号：",
                                    snapshot.data.trailerFrameNumber ?? "无",
                                  ),
                                ]),
                                TableRow(children: <Widget>[
                                  CustomTableRowWidget(
                                    "发动机编号：",
                                    snapshot.data.engineNumber ?? "无",
                                  ),
                                ]),
                                TableRow(children: <Widget>[
                                  CustomTableRowWidget(
                                    "加盟日期：",
                                    snapshot.data.joiningDate ?? "无",
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
                                      print("vehicle id for lock: " + model.id);
                                      VehicleDao.setVehicleLocking(model.id)
                                          .then((res) {
                                        if (res != null && res.result) {
                                          setState(() {
                                            vehicleInfo = _getData(model.id);
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
                                      VehicleDao.setVehicleUnlocking(model.id)
                                          .then((res) {
                                        if (res != null && res.result) {
                                          setState(() {
                                            vehicleInfo = _getData(model.id);
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                      "调度",
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      "保存",
                                      style: CustomConstant.listFieldStyle,
                                    ),
                                  ),
                                  onTap: () {
                                    if (_groupId == "") {
                                      CommonUtils.showShort("请先选择新的分组再调度！");
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content:
                                                  new SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    Text("是否要调度？")
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text("确定"),
                                                  onPressed: () {
                                                    VehicleDao.vehicleDispatch(
                                                            snapshot.data
                                                                .vehicleCode,
                                                            _groupId)
                                                        .then((res) {
                                                      if (res != null &&
                                                          res.result) {
                                                        CommonUtils.showShort(
                                                            '调度成功');
                                                        Navigator.pop(context);
                                                      }
                                                      if (res != null &&
                                                          !res.result) {
                                                        //print("" + res.data["error"]);
                                                        CommonUtils.showShort(
                                                            "调度失败！");
//                                                        res
//                                                            .data['error']
//                                                        [
//                                                        'message']);
                                                        Navigator.pop(context);
                                                      }
                                                    });
                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text("取消"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                              elevation: 20,
                                              // 设置成 圆角
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            );
                                          });
                                    }
                                  },
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
                                  child: Text("当前分组",
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
                                  child: Text(
                                    currentGroup == "" ? "分组名称" : currentGroup,
                                    style: CustomConstant.listFieldResultStyle,
                                    textAlign: TextAlign.left,
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
                                  child: Text("新的分组",
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
                                  child: GestureDetector(
                                      child: Text(
                                        _groupText == ""
                                            ? " 点击选择新的分组 "
                                            : _groupText,
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            color: Color(0x8A000000)),
                                      ),
                                      onTap: () {
                                        VehicleDao.getVehicleGroupList()
                                            .then((res) {
                                          List<VehicleGroup> groupLists =
                                              new List();
                                          if (res != null && res.result) {
                                            print("groups: " +
                                                res.data.toString());
                                            var itemList = res.data["result"];
                                            print("groups's itemList: " +
                                                itemList.toString() +
                                                itemList.length.toString());
                                            print("group itemList length: " +
                                                itemList.length.toString());
                                            for (int i = 0;
                                                i < itemList.length;
                                                i++) {
                                              var text = itemList[i]["text"];
                                              var value = itemList[i]["value"];
                                              var selected =
                                                  itemList[i]["selected"];
                                              groupLists.add(new VehicleGroup(
                                                  value, text, selected));
                                            }

                                            showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text("派车分组"),
                                                    content: StatefulBuilder(
                                                        builder: (context,
                                                            StateSetter
                                                                setState) {
                                                      return Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.9,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.9,
                                                                child: ListView
                                                                    .builder(
                                                                        shrinkWrap:
                                                                            true,
                                                                        itemCount:
                                                                            groupLists
                                                                                .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return OutlineButton(
                                                                              borderSide: BorderSide(color: Colors.grey),
                                                                              child: Text(
                                                                                '${groupLists[index].text}',
                                                                                style: CustomConstant.placeTextBlack,
                                                                              ),
                                                                              onPressed: () {
                                                                                selectedGroup = groupLists[index].text.toString();
                                                                                selectedIdGroup = groupLists[index].value.toString();
                                                                                var callback;
                                                                                callback = [
                                                                                  selectedGroup,
                                                                                  selectedIdGroup
                                                                                ];
                                                                                Navigator.of(context).pop(callback);
                                                                              });
                                                                        }),
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: <
                                                                  Widget>[
                                                                FlatButton(
                                                                  child: Text(
                                                                    "取消",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .blue),
                                                                  ),
                                                                  onPressed: () =>
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop([
                                                                    "",
                                                                    ""
                                                                  ]),
                                                                ),
                                                              ],
                                                            ),
                                                          ]);
                                                    }),
                                                  );
                                                }).then((value) {
                                              setState(() {
                                                _groupText = value[0];
                                                print("_groupText: " +
                                                    _groupText);
                                                if (value[1] != "") {
                                                  _groupId = value[1];
                                                } else {
                                                  _groupId = null;
                                                }
                                              });
                                            });
                                          } else {
                                            CommonUtils.showShort("调用接口失败！");
                                          }
                                        });
                                      }),
                                ),
                              ],
                            ),
                            Divider(),
                            SizedBox(
                              height: 26.0,
                            ),

                            FlatButton(
                                color: Color(0xff4C88FF),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 18.0, bottom: 17.0),
                                  child: Text(
                                    '代排队',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.0),
                                  ),
                                ),
                                onPressed: () {
                                  if (snapshot.data.vehicleCode == null ||
                                      snapshot.data.vehicleCode.length == 0) {
                                    CommonUtils.showShort("车辆编号为空");
                                    return;
                                  }
                                  VehicleDao.setReplaceQueue(
                                          snapshot.data.vehicleCode.trim())
                                      .then((res) {
                                    if (res != null && res.result) {
                                      //代排队成功
                                      CommonUtils.showShort("代排队成功");
                                    }
                                    if (res != null && !res.result) {
                                      CommonUtils.showShort(res.data['error']
                                                  ['message']
                                              .toString() +
                                          "-" +
                                          res.data["error"]["details"]
                                              .toString());
                                    }
                                  });
                                }),
                            Padding(padding: EdgeInsets.all(10.0)),
                            FlatButton(
                              color: Color(0xffFFFFFF),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: 18.0, bottom: 17.0),
                                child: Text(
                                  '取消排队',
                                  style: TextStyle(
                                      color: Color(0xff4C88FF), fontSize: 15.0),
                                ),
                              ),
                              onPressed: () {
                                if (snapshot.data.vehicleCode == null ||
                                    snapshot.data.vehicleCode.length == 0) {
                                  CommonUtils.showShort("车辆编号为空");
                                  return;
                                }
                                VehicleDao.setCancelQueue(
                                        snapshot.data.vehicleCode.trim())
                                    .then((res) {
                                  if (res != null && res.result) {
                                    //取消排队成功
                                    CommonUtils.showShort("取消排队成功");
                                  }
                                  if (res != null && !res.result) {
                                    CommonUtils.showShort(res.data['error']
                                                ['message']
                                            .toString() +
                                        "-" +
                                        res.data["error"]["details"]
                                            .toString());
                                  }
                                });
                              },
                            ),

//                          Row(
//                            children: <Widget>[
//                              Expanded(
//                                child:
//                              ),
//                              Padding(
//                                padding: EdgeInsets.all(5.0),
//                              ),
//                              Expanded(
//                                child: CustomFlexButton(
//                                    text: '调度',
//                                    color: Colors.blue,
//                                    onPress: () {
//
//                                    }),
//                              ),
//                            ],
//                          ),
                          ]),
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
              }),
        ),
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
