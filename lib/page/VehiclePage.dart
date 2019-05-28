import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/dao/ResultDao.dart';
import 'package:car_free_company/common/dao/VehicleDao.dart';
import 'package:car_free_company/common/model/Vehicle.dart';
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
  int skipCountGlobal = 5;
  int skipCountInit = 0;
  _refreshNotify(){
    if(isShow){
      setState((){
        planColor = Colors.green;
      });
    }

  }

  String _oUDisplayName = "";
  String _vehicleCode = "";
  String _mainVehiclePlate = "";
  String _models = "";

  String _oUDisplayNameNext = "";
  String _vehicleCodeNext = "";
  String _mainVehiclePlateNext = "";
  String _modelsNext = "";
  final TextEditingController logisticsCompanyController = new TextEditingController();
  final TextEditingController vehicleCodeController = new TextEditingController();
  final TextEditingController plateNumberController = new TextEditingController();
  final TextEditingController carTypeController = new TextEditingController();

  final CustomPullLoadWidgetControl pullLoadWidgetControl = new CustomPullLoadWidgetControl();

  ///获取数据
  _getData(oUDisplayName, vehicleCode, mainVehiclePlate, models, skipCount) async {
    final List<Vehicle> vehicleList = new List();
    var vehicles = await VehicleDao.getVehicleQuery(oUDisplayName, vehicleCode, mainVehiclePlate, models, 5, skipCount);
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
        var oUDisplayName = itemList[i]["oUDisplayName"].toString();
        var vehicleTypeText = itemList[i]["vehicleTypeText"].toString();
        var vehicleBusinessTypeText = itemList[i]["vehicleBusinessTypeText"].toString();
        var modelsText = itemList[i]["modelsText"].toString();
        var vehicleStateText = itemList[i]["vehicleStateText"].toString();
        var ownerName = itemList[i]["ownerName"].toString();
        var ownerIDNumber = itemList[i]["ownerIDNumber"].toString();
        var ownerPhone = itemList[i]["ownerPhone"].toString();
        var frameNumber = itemList[i]["frameNumber"].toString();
        var engineNumber = itemList[i]["engineNumber"].toString();
        var joiningDate = itemList[i]["joiningDate"].toString();
        vehicleList.add(new Vehicle(id, oUDisplayName, vehicleCode, engineNumber, vehicleTypeText, frameNumber, vehicleBusinessTypeText, modelsText, joiningDate, mainVehiclePlate, vehicleStateText, ownerName, ownerIDNumber, ownerPhone));
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
    return _getData(_oUDisplayName, _vehicleCode, _mainVehiclePlate, _models, skipCountInit);
  }
  ///请求加载更多
  @override
  requestLoadMore() async {
    // TODO: implement requestLoadMore
    var dataLoadMore = await _getData(_oUDisplayNameNext.trim(), _vehicleCodeNext.trim(), _mainVehiclePlateNext.trim(), _modelsNext.trim(), skipCountGlobal);
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
          new Padding(padding: EdgeInsets.all(2.0)),
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
                        contentPadding: EdgeInsets.all(10.0),
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
                      contentPadding: EdgeInsets.all(10.0),
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
                        contentPadding: EdgeInsets.all(10.0),
                        border:
                        OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor),)
                    ),
                  ),
                  //buildTextField(_mainVehiclePlate, '车牌号', plateNumberController)
              ),
              new Padding(padding: EdgeInsets.all(5.0)),
              Expanded(
                child: new TextField(
                  textAlign: TextAlign.center,
                  onChanged: (String value) {
                    _models = value;
                  },
                  controller: carTypeController,
                  decoration: InputDecoration(
                      hintText: '车型',
                      contentPadding: EdgeInsets.all(10.0),
                      border:
                      OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor),)
                  ),
                ),
                //buildTextField(_models, '车型', carTypeController),
              ),
            ],
          ),
          new Padding(padding: EdgeInsets.all(2.0)),
          new CustomFlexButton(
            color: Colors.blue,
            text: '查询',
            onPress: (){
              //获取到开始时间，结束时间，装地，卸地
              handleRefresh();
              _oUDisplayNameNext = _oUDisplayName;
              _vehicleCodeNext = _vehicleCode;
              _mainVehiclePlateNext = _mainVehiclePlate;
              _modelsNext = _models;

            },
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
