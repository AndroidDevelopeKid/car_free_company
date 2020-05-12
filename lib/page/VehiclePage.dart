import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/dao/ResultDao.dart';
import 'package:car_free_company/common/dao/VehicleDao.dart';
import 'package:car_free_company/common/model/Vehicle.dart';
import 'package:car_free_company/common/model/VehicleModel.dart';
import 'package:car_free_company/common/model/VehicleState.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/common/utils/CommonUtils.dart';
import 'package:car_free_company/widget/BaseVehicleState.dart';
import 'package:car_free_company/widget/CustomPullLoadWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VehiclePage extends StatefulWidget {
  static final String name = "Vehicle";

  VehiclePage({Key key}) : super(key: key);

  _VehiclePage createState() => _VehiclePage();
}

class _VehiclePage extends BaseVehicleState<VehiclePage> {
  ///消息颜色
  Color planColor = const Color(CustomColors.subLightTextColor);
  int skipCountGlobal = 10;
  int skipCountInit = 0;

  _refreshNotify() {
    if (isShow) {
      setState(() {
        planColor = Colors.green;
      });
    }
  }

  var _isExpanded = false;
  var selected; //选中的车型的描述
  var selectedId; //选中的车型编号
  String _key = ""; //搜索的关键字

  var selectedState;
  var selectedIdState;

  String _oUDisplayName = "";
  String _vehicleCode = "";
  String _mainVehiclePlate = "";
  String _models = "";
  String _modelsText = "";
  String _state = "";
  String _stateText = "";

  String _oUDisplayNameNext = "";
  String _vehicleCodeNext = "";
  String _mainVehiclePlateNext = "";
  String _modelsNext = "";
  String _stateNext = "";
  final TextEditingController logisticsCompanyController =
      new TextEditingController();
  final TextEditingController vehicleCodeController =
      new TextEditingController();
  final TextEditingController plateNumberController =
      new TextEditingController();
  final TextEditingController carTypeController = new TextEditingController();

  final CustomPullLoadWidgetControl pullLoadWidgetControl =
      new CustomPullLoadWidgetControl();

  ///获取数据
  _getData(originalOUId, vehicleCode, mainVehiclePlate, models, state,
      skipCount) async {
    final List<Vehicle> vehicleList = new List();
    var vehicles = await VehicleDao.getVehicleQuery(originalOUId, vehicleCode,
        mainVehiclePlate, models, state, Config.MAX_RESULT, skipCount);
    if (vehicles != null && vehicles.result) {
      print("skipCount : " + skipCountGlobal.toString());
      print("vehicles: " + vehicles.data.toString());
      var itemList = vehicles.data["result"]["items"];
      print("vehicles's itemList: " +
          itemList.toString() +
          itemList.length.toString());
      print("vehicles itemList length: " + itemList.length.toString());
      for (int i = 0; i < itemList.length; i++) {
        var id = itemList[i]["id"].toString();
        var vehicleCode = itemList[i]["vehicleCode"].toString();
        var mainVehiclePlate = itemList[i]["mainVehiclePlate"].toString();
        var originalOUId = itemList[i]["originalOUId"];
        var oUDisplayName = itemList[i]["oUDisplayName"].toString();
        var vehicleType = itemList[i]["vehicleType"];
        var vehicleTypeText = itemList[i]["vehicleTypeText"].toString();
        var vehicleBusinessType = itemList[i]["vehicleBusinessType"];
        var vehicleBusinessTypeText =
            itemList[i]["vehicleBusinessTypeText"].toString();
        var models = itemList[i]["models"];
        var modelsText = itemList[i]["modelsText"].toString();
        var vehicleState = itemList[i]["vehicleState"];
        var vehicleStateText = itemList[i]["vehicleStateText"].toString();
        var ownerName = itemList[i]["ownerName"].toString();
        var ownerIDNumber = itemList[i]["ownerIDNumber"].toString();
        var ownerPhone = itemList[i]["ownerPhone"].toString();
        var trailerFrameNumber = itemList[i]["trailerFrameNumber"].toString();
        var engineNumber = itemList[i]["engineNumber"].toString();
        var joiningDate = itemList[i]["joiningDate"].toString();
        vehicleList.add(new Vehicle(
            id,
            oUDisplayName,
            vehicleCode,
            engineNumber,
            vehicleTypeText,
            trailerFrameNumber,
            vehicleBusinessTypeText,
            modelsText,
            joiningDate,
            mainVehiclePlate,
            vehicleStateText,
            ownerName,
            ownerIDNumber,
            ownerPhone,
            originalOUId,
            models,
            vehicleBusinessType,
            vehicleState,
            vehicleType));
      }
      return new DataResult(vehicleList, true);
    }
    if (vehicles.data == null && !vehicles.result) {
      return new DataResult("到底了", false);
    }
//    final List<Vehicle> test = new List();
//    test.add(new Vehicle("000012121", "oUDisplayName", "vehicleCode", "engineNumber", "vehicleTypeText", "trailerFrameNumber", "vehicleBusinessTypeText", "modelsText", "2020-02-02", "mainVehiclePlate", "vehicleStateText", "ownerName", "ownerIDNumber", "ownerPhone", 103948434, "models", "vehicleBusinessType", "vehicleState", "vehicleType"));
//    return new DataResult(test, true);
  }

  ///请求刷新
  @override
  requestRefresh() {
    // TODO: implement requestRefresh
    //getMessagePush();
    skipCountGlobal = 10;
    return _getData(_oUDisplayName, _vehicleCode, _mainVehiclePlate, _models,
        _state, skipCountInit);
  }

  ///请求加载更多
  @override
  requestLoadMore() async {
    // TODO: implement requestLoadMore
    var dataLoadMore = await _getData(
        _oUDisplayNameNext.trim(),
        _vehicleCodeNext.trim(),
        _mainVehiclePlateNext.trim(),
        _modelsNext.trim(),
        _stateNext.trim(),
        skipCountGlobal);
    if (dataLoadMore.result) {
      skipCountGlobal = skipCountGlobal + Config.PAGE_SIZE;
      print("skipCountGlobal : " + skipCountGlobal.toString());
    }
    return dataLoadMore;
  }

  ///tab切换防止页面重置
  @override
  bool get wantKeepAlive => true;

  @override
  bool get needHeader => false;

  @override
  void initState() {
    pullLoadWidgetControl.needHeader = true;
    super.initState();
    logisticsCompanyController.value = new TextEditingValue(text: "");
    vehicleCodeController.value = new TextEditingValue(text: "");
    plateNumberController.value = new TextEditingValue(text: "");
    carTypeController.value = new TextEditingValue(text: "");
  }

  ///initState后调用，在didChangeDependencies中，可以跨组件拿到数据。
  @override
  void didChangeDependencies() {
//    if(pullLoadWidgetControl.dataList.length == 0){
//      showRefreshLoading();
//    }
    super.didChangeDependencies();
    //handleRefresh();
  }

  @override
  void dispose() {
    logisticsCompanyController.dispose();
    vehicleCodeController.dispose();
    plateNumberController.dispose();
    carTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              iconSize: 15.0,
              icon: Icon(CustomIcons.BACK, color: Color(0xff4C88FF)),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Text("车辆查询",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Column(
            children: <Widget>[
              ExpansionPanelList(
                children: <ExpansionPanel>[
                  ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Container(
                              decoration:
                                  BoxDecoration(color: Color(0xffE2ECFF)),
                              child: Center(
                                  child: Text(
                                "点击展开查询条件",
                                style: TextStyle(
                                    fontSize: 15.0, color: Color(0xff4C88FF)),
                              ))));
                    },
                    body: Padding(
                      padding: EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              SizedBox(
                                width: 75,
                                height: 30,
                                child: RaisedButton(
                                  padding: EdgeInsets.all(0.0),
                                  child: Image.asset(
                                    CustomIcons.QUERY,
                                    fit: BoxFit.cover,
                                  ),
                                  onPressed: () async {
                                    CommonUtils.showLoadingDialog(context);
                                    await handleRefresh();
                                    _oUDisplayNameNext = _oUDisplayName;
                                    _vehicleCodeNext = _vehicleCode;
                                    _mainVehiclePlateNext = _mainVehiclePlate;
                                    _modelsNext = _models;
                                    _stateNext = _state;
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 10.0)),
                          OutlineButton(
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                child: Text(
                                  _modelsText == "" ? " 车型 " : _modelsText,
                                  style: CustomConstant.hintBlueText,
                                ),
                              ),
                              color: Color(CustomColors.white),
                              borderSide: BorderSide(color: Color(0xff4C88FF)),
                              onPressed: () {
                                VehicleDao.getVehicleModels().then((models) {
                                  List<VehicleModel> modelList = new List();
                                  //车型
                                  if (models != null && models.result) {
                                    print("models: " + models.data.toString());
                                    var itemList = models.data["result"];
                                    print("models's itemList: " +
                                        itemList.toString() +
                                        itemList.length.toString());
                                    print("model itemList length: " +
                                        itemList.length.toString());
                                    for (int i = 0; i < itemList.length; i++) {
                                      var text = itemList[i]["text"].toString();
                                      var value =
                                          itemList[i]["value"].toString();
                                      var selected = itemList[i]["selected"];
                                      modelList.add(new VehicleModel(
                                          value, text, selected));
                                    }
                                  }
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 15.0,
                                                height: 15.0,
                                                child: Image(
                                                    image: AssetImage(
                                                        CustomIcons.VEHICLE_TYPE)),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 6.0, right: 6.0),
                                              ),
                                              Text(
                                                "车型选择",
                                                style: TextStyle(fontSize: 15.0),
                                              ),
                                            ],
                                          ),
                                          content: StatefulBuilder(builder:
                                              (context, StateSetter setState) {
                                            return Column(children: <
                                                Widget>[
                                              Expanded(
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.9,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.9,
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          modelList.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return  OutlineButton(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                            child: Text(
                                                              '${modelList[index].text}',
                                                              style: CustomConstant
                                                                  .placeTextBlack,
                                                            ),
                                                            onPressed: () {
                                                              selected =
                                                                  modelList[
                                                                          index]
                                                                      .text
                                                                      .toString();
                                                              selectedId =
                                                                  modelList[
                                                                          index]
                                                                      .value
                                                                      .toString();

                                                              var callback;
                                                              callback = [
                                                                selected,
                                                                selectedId
                                                              ];
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(
                                                                      callback);
                                                            });
                                                      }),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  FlatButton(
                                                    color: Color(0xff4c88FF),
                                                    child: Text(
                                                      "取消",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(["", ""]),
                                                  ),
                                                ],
                                              ),
                                            ]);
                                          }),
                                          elevation: 20,
                                          // 设置成 圆角
                                          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        );
                                      }).then((value) {
                                    setState(() {
                                      _modelsText = value[0];
                                      if (value[1] != "") {
                                        _models = value[1];
                                      } else {
                                        _models = null;
                                      }
                                    });
                                  });
                                });
                              }),
                          OutlineButton(
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                child: Text(
                                  _stateText == "" ? " 车辆状态 " : _stateText,
                                  style: CustomConstant.hintBlueText,
                                ),
                              ),
                              color: Color(CustomColors.white),
                              borderSide: BorderSide(color: Color(0xff4C88FF)),
                              onPressed: () {
                                VehicleDao.getVehicleState().then((models) {
                                  List<VehicleState> modelList = new List();
                                  //车型
                                  if (models != null && models.result) {
                                    print("models: " + models.data.toString());
                                    var itemList = models.data["result"];
                                    print("models's itemList: " +
                                        itemList.toString() +
                                        itemList.length.toString());
                                    print("model itemList length: " +
                                        itemList.length.toString());
                                    for (int i = 0; i < itemList.length; i++) {
                                      var text = itemList[i]["text"].toString();
                                      var value =
                                          itemList[i]["value"].toString();
                                      var selected = itemList[i]["selected"];
                                      modelList.add(new VehicleState(
                                          value, text, selected));
                                    }
                                  }
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 15.0,
                                                height: 15.0,
                                                child: Image(
                                                    image: AssetImage(
                                                        CustomIcons.VEHICLE_STATUS)),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 6.0, right: 6.0),
                                              ),
                                              Text(
                                                "车辆状态选择",
                                                style: TextStyle(fontSize: 15.0),
                                              ),
                                            ],
                                          ),
                                          content: StatefulBuilder(builder:
                                              (context, StateSetter setState) {
                                            return Column(children: <
                                                Widget>[
                                              Expanded(
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.9,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.9,
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          modelList.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return OutlineButton(
                                                            borderSide:
                                                            BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                            child: Text(
                                                              '${modelList[index].text}',
                                                              style: CustomConstant
                                                                  .placeTextBlack,
                                                            ),
                                                            onPressed: () {
                                                              selectedState =
                                                                  modelList[
                                                                          index]
                                                                      .text
                                                                      .toString();
                                                              selectedIdState =
                                                                  modelList[
                                                                          index]
                                                                      .value
                                                                      .toString();

                                                              var callback;
                                                              callback = [
                                                                selectedState,
                                                                selectedIdState
                                                              ];
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(
                                                                      callback);
                                                            });
                                                      }),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  FlatButton(
                                                    color: Color(0xff4c88FF),
                                                    child: Text(
                                                      "取消",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(["", ""]),
                                                  ),
                                                ],
                                              ),
                                            ]);
                                          }),elevation: 20,
                                          // 设置成 圆角
                                          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        );
                                      }).then((value) {
                                    setState(() {
                                      _stateText = value[0];
                                      if (value[1] != "") {
                                        _state = value[1];
                                      } else {
                                        _state = null;
                                      }
                                    });
                                  });
                                });
                              }),
                          Padding(padding: EdgeInsets.only(top: 4.0)),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 40,
                            ),
                            child: TextField(
                              textAlign: TextAlign.center,
                              onChanged: (String value) {
                                _oUDisplayName = value;
                              },
                              controller: logisticsCompanyController,
                              decoration: InputDecoration(
                                  hintText: '输入业务单位查询',
                                  hintStyle: TextStyle(fontSize: 15.0),
                                  contentPadding: EdgeInsets.all(0.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff4C88FF)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff4C88FF)),
                                  ),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          //buildTextField(_oUDisplayName, '业务单位', logisticsCompanyController)
                          Padding(padding: EdgeInsets.only(top: 8.0)),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 40,
                            ),
                            child: TextField(
                              textAlign: TextAlign.center,
                              onChanged: (String value) {
                                _vehicleCode = value;
                              },
                              controller: vehicleCodeController,
                              decoration: InputDecoration(
                                  hintText: '输入车辆编号查询',
                                  hintStyle: TextStyle(fontSize: 15.0),
                                  contentPadding: EdgeInsets.all(0.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff4C88FF)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff4C88FF)),
                                  ),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          //buildTextField(_vehicleCode, '车辆编号', vehicleCodeController),

                          Padding(padding: EdgeInsets.only(top: 8.0)),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 40,
                            ),
                            child: TextField(
                              textAlign: TextAlign.center,
                              onChanged: (String value) {
                                _mainVehiclePlate = value;
                              },
                              controller: plateNumberController,
                              decoration: InputDecoration(
                                  hintText: '输入车牌号查询',
                                  hintStyle: TextStyle(fontSize: 15.0),
                                  contentPadding: EdgeInsets.all(0.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff4C88FF)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff4C88FF)),
                                  ),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ],
                      ),
                    ),
                    isExpanded: _isExpanded,
                    canTapOnHeader: true,
                  )
                ],
                expansionCallback: (panelIndex, isExpanded) {
                  setState(() {
                    _isExpanded = !isExpanded;
                  });
                },
                animationDuration: Duration(milliseconds: 500),
              ),
              Padding(padding: EdgeInsets.all(2.0)),
              Expanded(
                  child: CustomPullLoadWidget(
                pullLoadWidgetControl,
                (BuildContext context, int index) => renderItem(index, () {
                  _refreshNotify();
                }),
                handleRefresh,
                onLoadMore,
                refreshKey: refreshIndicatorKey,
              )),
            ],
          ),
        ));
  }
}
