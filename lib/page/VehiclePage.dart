import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/dao/ResultDao.dart';
import 'package:car_free_company/common/dao/VehicleDao.dart';
import 'package:car_free_company/common/model/Vehicle.dart';
import 'package:car_free_company/common/model/VehicleModel.dart';
import 'package:car_free_company/common/model/VehicleState.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/widget/BaseVehicleState.dart';
import 'package:car_free_company/widget/CustomFlexButton.dart';
import 'package:car_free_company/widget/CustomInputWidget.dart';
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
  _refreshNotify(){
    if(isShow){
      setState((){
        planColor = Colors.green;
      });
    }

  }
  var _isExpanded = false;
  var selected; //选中的车型的描述
  var selectedId; //选中的车型编号

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
  final TextEditingController logisticsCompanyController = new TextEditingController();
  final TextEditingController vehicleCodeController = new TextEditingController();
  final TextEditingController plateNumberController = new TextEditingController();
  final TextEditingController carTypeController = new TextEditingController();

  final CustomPullLoadWidgetControl pullLoadWidgetControl = new CustomPullLoadWidgetControl();

  ///获取数据
  _getData(originalOUId, vehicleCode, mainVehiclePlate, models, state, skipCount) async {
    final List<Vehicle> vehicleList = new List();
    var vehicles = await VehicleDao.getVehicleQuery(originalOUId, vehicleCode, mainVehiclePlate, models, state, Config.MAX_RESULT, skipCount);
    if(vehicles != null && vehicles.result){
      print("skipCount : " + skipCountGlobal.toString());
      print("vehicles: " + vehicles.data.toString());
      var itemList = vehicles.data["result"]["items"];
      print("vehicles's itemList: " + itemList.toString() + itemList.length.toString());
      print("vehicles itemList length: " + itemList.length.toString());
      for(int i = 0; i < itemList.length; i++){
        var id = itemList[i]["id"].toString();
        var vehicleCode = itemList[i]["vehicleCode"].toString();
        var mainVehiclePlate = itemList[i]["mainVehiclePlate"].toString();
        var originalOUId = itemList[i]["originalOUId"];
        var oUDisplayName = itemList[i]["oUDisplayName"].toString();
        var vehicleType = itemList[i]["vehicleType"];
        var vehicleTypeText = itemList[i]["vehicleTypeText"].toString();
        var vehicleBusinessType = itemList[i]["vehicleBusinessType"];
        var vehicleBusinessTypeText = itemList[i]["vehicleBusinessTypeText"].toString();
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
        vehicleList.add(new Vehicle(id, oUDisplayName, vehicleCode, engineNumber, vehicleTypeText, trailerFrameNumber, vehicleBusinessTypeText, modelsText, joiningDate, mainVehiclePlate, vehicleStateText, ownerName, ownerIDNumber, ownerPhone, originalOUId, models, vehicleBusinessType, vehicleState, vehicleType));
      }
      return new DataResult(vehicleList, true);
    }
    if(vehicles.data == null && !vehicles.result){
      return new DataResult("到底了", false);
    }
  }
  ///请求刷新
  @override
  requestRefresh() {
    // TODO: implement requestRefresh
    //getMessagePush();
    skipCountGlobal = 10;
    return _getData(_oUDisplayName, _vehicleCode, _mainVehiclePlate, _models, _state, skipCountInit);
  }
  ///请求加载更多
  @override
  requestLoadMore() async {
    // TODO: implement requestLoadMore
    var dataLoadMore = await _getData(_oUDisplayNameNext.trim(), _vehicleCodeNext.trim(), _mainVehiclePlateNext.trim(), _modelsNext.trim(), _stateNext.trim(), skipCountGlobal);
    if(dataLoadMore.result){
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
  void didChangeDependencies(){
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
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("车辆查询"),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new ExpansionPanelList(
            children: <ExpansionPanel>[
              ExpansionPanel(
                headerBuilder: (context, isExpanded){
                  return new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Padding(padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                        child: new OutlineButton(
                          child: new Text("查询"),
                          borderSide: new BorderSide(color: Colors.blue),
                          //color: Colors.blueAccent,
                          //text: '查询',
                          onPressed: () {
                            //获取到开始时间，结束时间，装地，卸地
                            handleRefresh();
                            _oUDisplayNameNext = _oUDisplayName;
                            _vehicleCodeNext = _vehicleCode;
                            _mainVehiclePlateNext = _mainVehiclePlate;
                            _modelsNext = _models;
                            _stateNext = _state;

                          },
                        ),
                      ),

                      new Center(child: new Text("点击展开查询条件"),)
                    ],

                  );
                },
                body: new Column(
                  children: <Widget>[
                    //new Padding(padding: EdgeInsets.all(2.0)),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: new TextField(
                            textAlign: TextAlign.center,
                            onChanged: (String value) {
                              _oUDisplayName = value;
                            },
                            controller: logisticsCompanyController,
                            decoration: InputDecoration(
                                hintText: '业务单位',
                                contentPadding: EdgeInsets.all(8.0),
                                border:
                                OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor),)
                            ),
                          ),
                          //buildTextField(_oUDisplayName, '业务单位', logisticsCompanyController)
                        ),
                        new Padding(padding: EdgeInsets.all(5.0)),
                        Expanded(
                          child: new TextField(
                            textAlign: TextAlign.center,
                            onChanged: (String value) {
                              _vehicleCode = value;
                            },
                            controller: vehicleCodeController,
                            decoration: InputDecoration(
                                hintText: '车辆编号',
                                contentPadding: EdgeInsets.all(8.0),
                                border:
                                OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor),)
                            ),
                          ),
                          //buildTextField(_vehicleCode, '车辆编号', vehicleCodeController),
                        ),
                      ],
                    ),
                    new Padding(padding: EdgeInsets.all(2.0)),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: new TextField(
                            textAlign: TextAlign.center,
                            onChanged: (String value) {
                              _mainVehiclePlate = value;
                            },
                            controller: plateNumberController,
                            decoration: InputDecoration(
                                hintText: '车牌号',
                                contentPadding: EdgeInsets.all(8.0),
                                border:
                                OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor),)
                            ),
                          ),
                          //buildTextField(_mainVehiclePlate, '车牌号', plateNumberController)
                        ),
                        new Padding(padding: EdgeInsets.all(5.0)),
//              Expanded(
//                child: new TextField(
//                  textAlign: TextAlign.center,
//                  onChanged: (String value) {
//                    _models = value;
//                  },
//                  controller: carTypeController,
//                  decoration: InputDecoration(
//                      hintText: '车型',
//                      contentPadding: EdgeInsets.all(10.0),
//                      border:
//                      OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor),)
//                  ),
//                ),
//                //buildTextField(_models, '车型', carTypeController),
//              ),
                        Expanded(
                          child:
                          new OutlineButton(
                              child: new Padding(
                                padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                child: new Text(
                                  _modelsText == "" ? " 车型 " : _modelsText,
                                  style: CustomConstant.hintText,
                                ),
                              ),
                              color: Color(CustomColors.white),
                              borderSide: new BorderSide(color: Colors.grey),
                              onPressed: () {
                                VehicleDao.getVehicleModels()
                                    .then((models) {
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
                                      var value = itemList[i]["value"].toString();
                                      var selected = itemList[i]["selected"];
                                      modelList.add(
                                          new VehicleModel(value, text, selected));
                                    }
                                  }
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return new AlertDialog(
                                          title: new Text("车型"),
                                          content: new StatefulBuilder(
                                              builder: (context, StateSetter setState) {
                                                return new Column(children: <Widget>[
                                                  Expanded(
                                                    child: new Container(
                                                      width:
                                                      MediaQuery.of(context).size.width *
                                                          0.9,
                                                      height:
                                                      MediaQuery.of(context).size.height *
                                                          0.9,
                                                      child: new ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: modelList.length,
                                                          itemBuilder: (context, index) {
                                                            return new OutlineButton(
                                                                borderSide: new BorderSide(
                                                                    color: Colors.grey),
                                                                child: Text(
                                                                  '${modelList[index].text}',
                                                                  style: CustomConstant
                                                                      .placeTextBlack,
                                                                ),
                                                                onPressed: () {

                                                                  selected =
                                                                      modelList[index]
                                                                          .text
                                                                          .toString();
                                                                  selectedId =
                                                                      modelList[index]
                                                                          .value
                                                                          .toString();

                                                                  var callback;
                                                                  callback = [
                                                                    selected,
                                                                    selectedId
                                                                  ];
                                                                  Navigator.of(context)
                                                                      .pop(callback);

                                                                });
                                                          }),
                                                    ),
                                                  ),
                                                  new Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                    children: <Widget>[
                                                      new FlatButton(
                                                        child: Text(
                                                          "取消",
                                                          style:
                                                          TextStyle(color: Colors.blue),
                                                        ),
                                                        onPressed: () => Navigator.of(context)
                                                            .pop(["", ""]),
                                                      ),
//                                          new FlatButton(
//                                            child: Text(
//                                              "确定",
//                                              style: TextStyle(
//                                                  color: Colors.blue),
//                                            ),
//                                            onPressed: () {
//                                              Navigator.of(context).pop(
//                                                  selected);
//                                            },
//                                          ),
                                                    ],
                                                  ),
                                                ]);
                                              }),
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
                        ),
                      ],
                    ),
                    new Padding(padding: EdgeInsets.all(2.0)),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(child:
                          new OutlineButton(
                              child: new Padding(
                                padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                child: new Text(
                                  _stateText == "" ? " 车辆状态 " : _stateText,
                                  style: CustomConstant.hintText,
                                ),
                              ),
                              color: Color(CustomColors.white),
                              borderSide: new BorderSide(color: Colors.grey),
                              onPressed: () {
                                VehicleDao.getVehicleState()
                                    .then((models) {
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
                                      var value = itemList[i]["value"].toString();
                                      var selected = itemList[i]["selected"];
                                      modelList.add(
                                          new VehicleState(value, text, selected));
                                    }
                                  }
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return new AlertDialog(
                                          title: new Text("车型"),
                                          content:
                                          new StatefulBuilder(
                                              builder: (context, StateSetter setState) {
                                                return new Column(children: <Widget>[
                                                  Expanded(
                                                    child: new Container(
                                                      width:
                                                      MediaQuery.of(context).size.width *
                                                          0.9,
                                                      height:
                                                      MediaQuery.of(context).size.height *
                                                          0.9,
                                                      child: new ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: modelList.length,
                                                          itemBuilder: (context, index) {
                                                            return new OutlineButton(
                                                                borderSide: new BorderSide(
                                                                    color: Colors.grey),
                                                                child: Text(
                                                                  '${modelList[index].text}',
                                                                  style: CustomConstant
                                                                      .placeTextBlack,
                                                                ),
                                                                onPressed: () {

                                                                  selectedState =
                                                                      modelList[index]
                                                                          .text
                                                                          .toString();
                                                                  selectedIdState =
                                                                      modelList[index]
                                                                          .value
                                                                          .toString();

                                                                  var callback;
                                                                  callback = [
                                                                    selectedState,
                                                                    selectedIdState
                                                                  ];
                                                                  Navigator.of(context)
                                                                      .pop(callback);

                                                                });
                                                          }),
                                                    ),
                                                  ),
                                                  new Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                    children: <Widget>[
                                                      new FlatButton(
                                                        child: Text(
                                                          "取消",
                                                          style:
                                                          TextStyle(color: Colors.blue),
                                                        ),
                                                        onPressed: () => Navigator.of(context)
                                                            .pop(["", ""]),
                                                      ),

                                                    ],
                                                  ),
                                                ]);
                                              }),
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
                              }),),
                        new Padding(padding: EdgeInsets.all(5.0)),
                        new Expanded(child: new Container()),

                      ],
                    ),
                    new Padding(padding: EdgeInsets.all(5.0)),

                  ],
                ),
                isExpanded: _isExpanded,
                canTapOnHeader: true,

              )
            ],
            expansionCallback: (panelIndex, isExpanded){
              setState(() {
                _isExpanded = !isExpanded;
              });
            },
            animationDuration: Duration(milliseconds: 500),
          ),


          new Padding(padding: EdgeInsets.all(2.0)),
          new Expanded(
              child: new CustomPullLoadWidget(
                pullLoadWidgetControl,
                    (BuildContext context, int index) => renderItem(index,(){
                  _refreshNotify();
                }),
                handleRefresh,
                onLoadMore,
                refreshKey: refreshIndicatorKey,
              )
          ),

        ],
      ),
    );
  }

  Widget buildTextField(String data,String text, TextEditingController controller) {
    return TextField(
      textAlign: TextAlign.center,
      onChanged: (String value) {
        data = value;
      },
      controller: controller,
      decoration: InputDecoration(
          hintText: text,
          contentPadding: EdgeInsets.all(10.0),
          border:
          OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor),)
      ),
    );
  }

}
