import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/dao/VehicleDao.dart';
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
  int skipCountGlobal = 0;
  int readState = null;
  int skipCountInit = 0;
  _refreshNotify(){
    if(isShow){
      setState((){
        planColor = Colors.green;
      });
    }

  }

  String _logisticsCompany = "";
  String _vehicleCode = "";
  String _plateNumber = "";
  String _carType = "";
  final TextEditingController logisticsCompanyController = new TextEditingController();
  final TextEditingController vehicleCodeController = new TextEditingController();
  final TextEditingController plateNumberController = new TextEditingController();
  final TextEditingController carTypeController = new TextEditingController();

  final CustomPullLoadWidgetControl pullLoadWidgetControl = new CustomPullLoadWidgetControl();

  ///获取数据
  _getData(state, skipCount) async {

  }
  ///请求刷新
  @override
  requestRefresh() {
    // TODO: implement requestRefresh
    //getMessagePush();
    return _getData(readState,skipCountInit);
  }
  ///请求加载更多
  @override
  requestLoadMore() {
    // TODO: implement requestLoadMore
    var dataLoadMore = _getData(readState,skipCountGlobal);
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
    handleRefresh();
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
                  child: buildTextField(_logisticsCompany, '业务单位', logisticsCompanyController)
              ),
              new Padding(padding: EdgeInsets.all(5.0)),
              Expanded(
                child: buildTextField(_vehicleCode, '车辆编号', vehicleCodeController),
              ),
            ],
          ),
          new Padding(padding: EdgeInsets.all(2.0)),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                  child: buildTextField(_plateNumber, '车牌号', plateNumberController)
              ),
              new Padding(padding: EdgeInsets.all(5.0)),
              Expanded(
                child: buildTextField(_carType, '车型', carTypeController),
              ),
            ],
          ),
          new Padding(padding: EdgeInsets.all(2.0)),
          new CustomFlexButton(
            color: Colors.blue,
            text: '查询',
            onPress: ()=>{
              //获取到开始时间，结束时间，装地，卸地
              //VehicleDao

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
