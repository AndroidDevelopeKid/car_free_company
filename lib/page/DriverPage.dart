import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/dao/DriverDao.dart';
import 'package:car_free_company/common/dao/ResultDao.dart';
import 'package:car_free_company/common/model/Driver.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/widget/BaseDriverState.dart';
import 'package:car_free_company/widget/CustomFlexButton.dart';
import 'package:car_free_company/widget/CustomInputWidget.dart';
import 'package:car_free_company/widget/CustomPullLoadWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DriverPage extends StatefulWidget {
  static final String name = "Driver";

  DriverPage({Key key}) : super(key: key);

  _DriverPage createState() => _DriverPage();
}

class _DriverPage extends BaseDriverState<DriverPage> {
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

  String _driverIdNumber = "";
  String _driverName = "";
  String _phoneNumber = "";
  String _vehicleCode = "";

  String _driverIdNumberNext = "";
  String _driverNameNext = "";
  String _phoneNumberNext = "";
  String _vehicleCodeNext = "";

  final TextEditingController driverIdNumberController = new TextEditingController();
  final TextEditingController driverNameController = new TextEditingController();
  final TextEditingController phoneNumberController = new TextEditingController();
  final TextEditingController vehicleCodeController = new TextEditingController();

  final CustomPullLoadWidgetControl pullLoadWidgetControl = new CustomPullLoadWidgetControl();

  ///获取数据
  _getData(idNumber, name, phone, vehicleCode, skipCount) async {
    final List<Driver> driverList = new List();
    var drivers = await DriverDao.getDriverQuery(idNumber, name, phone, vehicleCode, 5, skipCount);
    if(drivers != null && drivers.result){
      print("skipCount : " + skipCountGlobal.toString());
      print("drivers: " + drivers.data.toString());
      var itemList = drivers.data["result"]["items"];
      print("drivers's itemList: " + itemList.toString() + itemList.length.toString());
      print("drivers itemList length: " + itemList.length.toString());
      for(int i = 0; i < itemList.length; i++){
        var id = itemList[i]["id"].toString();
        var ouDisplayName = itemList[i]["ouDisplayName"].toString();
        var vehicleCode = itemList[i]["vehicleCode"].toString();
        var driverIDNumber = itemList[i]["driverIDNumber"].toString();
        var driverName = itemList[i]["driverName"].toString();
        var driverPhone = itemList[i]["driverPhone"].toString();
        var personTypeText = itemList[i]["personTypeText"].toString();
        var personStateText = itemList[i]["personStateText"].toString();
        var buckupContactPerson = itemList[i]["buckupContactPerson"].toString();
        var buckupContactPersonAddress = itemList[i]["buckupContactPersonAddress"].toString();
        var buckupContactPersonPhone = itemList[i]["buckupContactPersonPhone"].toString();
        var driverLicenseID = itemList[i]["driverLicenseID"].toString();
        var certificateEndDate = itemList[i]["certificateEndDate"].toString();
        var dlCertificateEndDate = itemList[i]["dlCertificateEndDate"].toString();
        driverList.add(new Driver(id, ouDisplayName, vehicleCode, driverIDNumber, driverName, driverPhone, personTypeText, personStateText, buckupContactPerson, buckupContactPersonAddress, buckupContactPersonPhone, driverLicenseID, certificateEndDate, dlCertificateEndDate));
      }
      return new DataResult(driverList, true);
    }
    if(drivers.data == null && !drivers.result){
      return new DataResult("到底了", false);
    }
  }
  ///请求刷新
  @override
  requestRefresh() {
    // TODO: implement requestRefresh
    //getMessagePush();
    print("parameters: " + _driverIdNumber.toString() + "-" + _driverName.toString() + "-" + _phoneNumber.toString() + "-" + _vehicleCode.toString() + "-" + skipCountInit.toString());
    return _getData(_driverIdNumber, _driverName, _phoneNumber, _vehicleCode, skipCountInit);
  }
  ///请求加载更多
  @override
  requestLoadMore() async {
    // TODO: implement requestLoadMore
    var dataLoadMore = await _getData(_driverIdNumberNext.trim(), _driverNameNext.trim(), _phoneNumberNext.trim(), _vehicleCodeNext.trim(), skipCountGlobal);
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
    driverIdNumberController.value = new TextEditingValue(text: "");
    driverNameController.value = new TextEditingValue(text: "");
    phoneNumberController.value = new TextEditingValue(text: "");
    vehicleCodeController.value = new TextEditingValue(text: "");
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
    driverIdNumberController.dispose();
    driverNameController.dispose();
    phoneNumberController.dispose();
    vehicleCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("司机查询"),
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
                      _driverIdNumber = value;
                    },
                    controller: driverIdNumberController,
                    decoration: InputDecoration(
                        hintText: '身份证',
                        contentPadding: EdgeInsets.all(10.0),
                        border:
                        OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor),)
                    ),
                  )
                  //buildTextField(_driverIdNumber, '身份证', driverIdNumberController)
              ),
              new Padding(padding: EdgeInsets.all(5.0)),
              Expanded(
                child:
                new TextField(
                  textAlign: TextAlign.center,
                  onChanged: (String value) {
                    _driverName = value;
                  },
                  controller: driverNameController,
                  decoration: InputDecoration(
                      hintText: '姓名',
                      contentPadding: EdgeInsets.all(10.0),
                      border:
                      OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor),)
                  ),
                )
                //buildTextField(_driverName, '姓名', driverNameController),
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
                      _phoneNumber = value;
                    },
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                        hintText: '电话号码',
                        contentPadding: EdgeInsets.all(10.0),
                        border:
                        OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor),)
                    ),
                  )
                  //buildTextField(_phoneNumber, '电话号码', phoneNumberController)
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
                )
                //buildTextField(_vehicleCode, '车辆编号', vehicleCodeController),
              ),
            ],
          ),
          new Padding(padding: EdgeInsets.all(2.0)),
          new CustomFlexButton(
            color: Colors.blue,
            text: '查询',
            onPress:(){
              //获取到开始时间，结束时间，装地，卸地
              handleRefresh();
              //_getData(_driverIdNumber.trim(), _driverName.trim(), _phoneNumber.trim(), _vehicleCode.trim(), skipCountInit);
              //requestRefresh();
              _driverIdNumberNext = _driverIdNumber;
              _driverNameNext = _driverName;
              _phoneNumberNext = _phoneNumber;
              _vehicleCodeNext = _vehicleCode;
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
