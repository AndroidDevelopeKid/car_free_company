


import 'package:car_free_company/common/dao/VehicleDao.dart';
import 'package:car_free_company/common/model/Vehicle.dart';
import 'package:car_free_company/common/model/VehicleGroup.dart';
import 'package:car_free_company/common/model/VehicleSingle.dart';
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

  var _newGroup;//派车分组
  final TextEditingController newGroupController = new TextEditingController();

  var _groupId = "";
  var _groupText = "";

  var selectedGroup;
  var selectedIdGroup;


  Future<VehicleSingle> vehicleInfo;

  Future<VehicleSingle> _getData(id) async {
    var res = await VehicleDao.getSingleVehicleInfo(model.id);
    if(res != null && res.result){
      return res.data;
    }
    if(res != null && !res.result){
      VehicleSingle dataNull = new VehicleSingle(null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
      return dataNull;
    }
    VehicleSingle dataNull1 = new VehicleSingle(null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
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
            child:FutureBuilder<VehicleSingle>(
                future: vehicleInfo,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        //new Expanded(child:
                        new Table(
                          //border: TableBorder.all(color: Color(CustomColors.tableBorderColor), width: 2.0, style: BorderStyle.solid),
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
                                  Text(snapshot.data.trailerFrameNumber ?? "无", style: CustomConstant.normalTextBlack),
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
                                  Text(snapshot.data.joiningDate ?? "无" , style: CustomConstant.normalTextBlack),
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
                                      print("vehicle id for lock: " + model.id);
                                      VehicleDao.setVehicleLocking(model.id).then((res){
                                        if(res != null && res.result){
                                          setState(() {
                                            vehicleInfo = _getData(model.id);
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
                                            vehicleInfo = _getData(model.id);
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
                        Padding(padding: EdgeInsets.all(5.0)),
                        new Row(children: <Widget>[
                          Expanded(child:
                          new CustomFlexButton(
                              text: '代排队',
                              color: Colors.blue,
                              onPress: (){
                                if(snapshot.data.vehicleCode == null || snapshot.data.vehicleCode.length == 0){
                                  CommonUtils.showShort("车辆编号为空");
                                  return;
                                }
                                VehicleDao.setReplaceQueue(snapshot.data.vehicleCode.trim()).then((res){
                                  if(res != null && res.result){
                                    //代排队成功
                                    CommonUtils.showShort("代排队成功");
                                  }
                                  if(res != null && !res.result){
                                    CommonUtils.showShort(res.data['error']['message'].toString() + "-" + res.data["error"]["details"].toString());
                                  }
                                });
                              }
                          ),

                          ),
                          Padding(padding: EdgeInsets.all(5.0),),
                          Expanded(child:
                          new CustomFlexButton(
                            color: Colors.blue,
                            text: '取消排队',
                            onPress: (){
                              if(snapshot.data.vehicleCode == null || snapshot.data.vehicleCode.length == 0){
                                CommonUtils.showShort("车辆编号为空");
                                return;
                              }
                              VehicleDao.setCancelQueue(snapshot.data.vehicleCode.trim()).then((res){
                                if(res != null && res.result){
                                  //取消排队成功
                                  CommonUtils.showShort("取消排队成功");
                                }
                                if(res != null && !res.result){
                                  CommonUtils.showShort(res.data['error']['message'].toString() + "-" + res.data["error"]["details"].toString());
                                }
                              });


                            },
                          ),
                          )
                        ],),
                        Padding(padding: EdgeInsets.all(5.0),),
                        new Row(children: <Widget>[
                          Expanded(
                              child:new OutlineButton(
                                  child: new Padding(
                                    padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                    child: new Text(
                                      _groupText == "" ? " 新的分组 " : _groupText,
                                      style: CustomConstant.hintText,
                                    ),
                                  ),
                                  color: Color(CustomColors.white),
                                  borderSide: new BorderSide(color: Colors.grey),
                                  onPressed: () {
                                    VehicleDao.getVehicleGroupList().then((res){
                                      List<VehicleGroup> groupLists = new List();
                                      if (res != null && res.result) {
                                        print("groups: " + res.data.toString());
                                        var itemList = res.data["result"];
                                        print("groups's itemList: " + itemList.toString() + itemList.length.toString());
                                        print("group itemList length: " + itemList.length.toString());
                                        for (int i = 0; i < itemList.length; i++) {
                                          var text = itemList[i]["text"];
                                          var value = itemList[i]["value"];
                                          var selected = itemList[i]["selected"];
                                          groupLists.add(new VehicleGroup(value, text, selected));
                                        }

                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return new AlertDialog(
                                                title: new Text("派车分组"),
                                                content: new StatefulBuilder(
                                                    builder: (context, StateSetter setState) {
                                                      return new Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: <Widget>[
                                                            Expanded(
                                                                child: new Container(
                                                                  width:MediaQuery.of(context).size.width * 0.9,
                                                                  height:MediaQuery.of(context).size.height * 0.9,
                                                                  child: new ListView.builder(
                                                                      shrinkWrap: true,
                                                                      itemCount: groupLists.length,
                                                                      itemBuilder: (context, index) {
                                                                        return new OutlineButton(
                                                                            borderSide: new BorderSide(color: Colors.grey),
                                                                            child: Text('${groupLists[index].text}',style: CustomConstant.placeTextBlack,),
                                                                            onPressed: () {
                                                                              selectedGroup = groupLists[index].text.toString();
                                                                              selectedIdGroup = groupLists[index].value.toString();
                                                                              var callback;
                                                                              callback = [selectedGroup,selectedIdGroup];
                                                                              Navigator.of(context).pop(callback);
                                                                            });
                                                                      }),
                                                                ),
                                                            ),

                                                            new Row(
                                                                mainAxisAlignment:MainAxisAlignment.spaceAround,
                                                                children: <Widget>[
                                                                  new FlatButton(
                                                                    child: Text("取消",style:TextStyle(color: Colors.blue),),
                                                                    onPressed: () => Navigator.of(context).pop(["", ""]),
                                                                  ),

                                                                ],
                                                              ),

                                                          ]);
                                                    }),
                                              );
                                            }).then((value) {
                                          setState(() {
                                            _groupText = value[0];
                                            print("_groupText: " + _groupText);
                                            if (value[1] != "") {
                                              _groupId = value[1];
                                            } else {
                                              _groupId = null;
                                            }
                                          });
                                        });
                                      }});
                                  }),
                          ),

                          Padding(padding: EdgeInsets.all(5.0),),
                          Expanded(
                              child:new CustomFlexButton(
                                  text: '调度',
                                  color: Colors.blue,
                                  onPress: () {
                                    VehicleDao.getVehicleGroup(snapshot.data.vehicleCode).then((groups){

                                      if(groups != null && groups.result){
                                        var groupList = groups.data["result"]["items"];
                                        var groupActive;
                                        for(int i = 0; i < groupList.length; i++){
                                          if(groupList[i]["isActive"])
                                            groupActive = groupList[i];
                                        }
                                        var organizationUnitId = groupActive["organizationUnitId"];
                                        var organizationUnitName = groupActive["organizationUnitName"];
                                        var vehicleCode = groupActive["vehicleCode"];
                                        var group = groupActive["group"];
                                        var groupText = groupActive["groupText"];
                                        var isActive = groupActive["isActive"];
                                        var id = groupActive["id"];
//*****************
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context){
                                              return new AlertDialog(
                                                  title: Text("车辆调度"),
                                                  content:
                                                  new Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        new Text("所属业务单位: " + organizationUnitName),
                                                        //new Text(),
                                                        new Text("当前分组: " + groupText),
                                                        //new Text(groupText),
                                                        new Text("是否激活: ${isActive ? "是" : "否"}"),
                                                        new Text("即将调去的分组: " + _groupText),
                                                        new Padding(padding: EdgeInsets.all(10.0)),

                                                        new Row(
                                                          mainAxisAlignment:MainAxisAlignment.spaceAround,
                                                          children: <Widget>[
                                                            new FlatButton(
                                                                child: Text("取消",style:TextStyle(color: Colors.blue),),
                                                                onPressed:  (){Navigator.pop(context);}
                                                            ),
                                                            new FlatButton(
                                                              child: Text("调度",style: TextStyle(color: Colors.blue),),
                                                              onPressed: ()
                                                              {
                                                                print("sss: " + vehicleCode + "--" + group);

                                                                VehicleDao.vehicleDispatch(vehicleCode, _groupId).then((res){
                                                                  if(res != null && res.result){
                                                                    CommonUtils.showShort('调度成功');
                                                                    Navigator.pop(context);
                                                                  }
                                                                  if(res != null && !res.result){
                                                                    //print("" + res.data["error"]);
                                                                    CommonUtils.showShort(res.data['error']['message']);
                                                                    Navigator.pop(context);
                                                                  }
                                                                });
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ])


                                              );
                                            });
                                        //*****************
                                      }
                                      //CommonUtils.showShort('调度成功');

                                      if(groups != null && !groups.result){
                                        //CommonUtils.showShort(groups.data['error']['message'].toString() + "-" + groups.data["error"]["details"].toString());
                                      }
                                    });

                                  }),
                          ),

                        ],),

                      ]);
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