import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/dao/DriverDao.dart';
import 'package:car_free_company/common/dao/ResultDao.dart';
import 'package:car_free_company/common/model/Driver.dart';
import 'package:car_free_company/common/model/DriverBrief.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/widget/BaseDriverState.dart';
import 'package:car_free_company/widget/CustomFlexButton.dart';
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

  var _dateBegin = "";
  var _dateEnd = "";
  var _dateBeginNext = "";
  var _dateEndNext = "";

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
  _getData(joinDateBegin, joinDateEnd, idNumber, name, phone, vehicleCode, skipCount) async {
    final List<DriverBrief> driverBriefList = new List();
    var driverBriefs = await DriverDao.getDriverQuery(joinDateBegin, joinDateEnd, idNumber, name, phone, vehicleCode, Config.MAX_RESULT, skipCount);
    if(driverBriefs != null && driverBriefs.result){
      print("skipCount : " + skipCountGlobal.toString());
      print("driverBriefs: " + driverBriefs.data.toString());
      var itemList = driverBriefs.data["result"]["items"];
      print("driverBriefs's itemList: " + itemList.toString() + itemList.length.toString());
      print("driverBriefs itemList length: " + itemList.length.toString());
      for(int i = 0; i < itemList.length; i++){
        var id = itemList[i]["id"].toString();
        var vehicleCode = itemList[i]["vehicleCode"];
        var driverIDNumber = itemList[i]["driverIDNumber"];
        var driverName = itemList[i]["driverName"];
        var driverPhone = itemList[i]["driverPhone"];
        driverBriefList.add(new DriverBrief(id, vehicleCode, driverIDNumber, driverName, driverPhone));
      }
      return new DataResult(driverBriefList, true);
    }
    if(driverBriefs.data == null && !driverBriefs.result){
      return new DataResult("到底了", false);
    }
  }

  _showDatePickerBegin() async {
    DateTime _picker = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now().subtract(new Duration(days: 3000)),
      // 减 30 天
      lastDate: new DateTime.now().add(new Duration(days: 30)), // 加 30 天
    );
    if (_picker == null) return;
    setState(() {
      _dateBegin = _picker.toString();
    });
  }

  _showDatePickerEnd() async {
    DateTime _picker = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now().subtract(new Duration(days: 3000)),
      // 减 30 天
      lastDate: new DateTime.now().add(new Duration(days: 30)), // 加 30 天
    );
    if (_picker == null) return;
    setState(() {
      _dateEnd = _picker.toString();
    });
  }

  ///请求刷新
  @override
  requestRefresh() {
    // TODO: implement requestRefresh
    //getMessagePush();
    skipCountGlobal = 10;
    //print("parameters: " + _driverIdNumber.toString() + "-" + _driverName.toString() + "-" + _phoneNumber.toString() + "-" + _vehicleCode.toString() + "-" + skipCountInit.toString());
    return _getData(_dateBegin, _dateEnd, _driverIdNumber, _driverName, _phoneNumber, _vehicleCode, skipCountInit);
  }
  ///请求加载更多
  @override
  requestLoadMore() async {
    // TODO: implement requestLoadMore
    var dataLoadMore = await _getData(_dateBeginNext.trim(), _dateEndNext.trim(), _driverIdNumberNext.trim(), _driverNameNext.trim(), _phoneNumberNext.trim(), _vehicleCodeNext.trim(), skipCountGlobal);

    if(dataLoadMore.result){
      skipCountGlobal = skipCountGlobal + Config.PAGE_SIZE;
      print("skipCountGlobal : " + skipCountGlobal.toString());
    }
    return dataLoadMore;
  }
  ///tab切换防止页面重置
  @override
  bool get wantKeepAlive => false;
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
                            _dateBeginNext = _dateBegin;
                            _dateEndNext = _dateEnd;
                            _driverIdNumberNext = _driverIdNumber;
                            _driverNameNext = _driverName;
                            _phoneNumberNext = _phoneNumber;
                            _vehicleCodeNext = _vehicleCode;
                          },
                        ),
                      ),

                      new Center(child: new Text("点击展开查询条件"),)
                    ],

                  );
                },
                body: new Column(
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: new OutlineButton(
                            child: new Padding(
                              padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              child: new Text(
                                _dateBegin == ""
                                    ? DateTime.now().toString().substring(0,10)
                                    : _dateBegin.toString().substring(0, 10),
                                style: CustomConstant.hintText,
                              ),
                            ),
                            color: Color(CustomColors.white),
                            borderSide: new BorderSide(color: Colors.grey),
                            onPressed: () => _showDatePickerBegin(),
                          ),
                        ),
                        //new Text("-->"),
                        new Padding(padding: EdgeInsets.all(5.0)),
                        Expanded(
                            child: new OutlineButton(
                              child: new Padding(
                                padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                child: new Text(
                                    _dateEnd == ""
                                        ? DateTime.now().toString().substring(0,10)
                                        : _dateEnd.toString().substring(0, 10),
                                    style: CustomConstant.hintText),
                              ),
                              borderSide: new BorderSide(color: Colors.grey),
                              onPressed: () => _showDatePickerEnd(),
                            ))
                      ],
                    ),
                    //new Padding(padding: EdgeInsets.all(2.0)),
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
                                  contentPadding: EdgeInsets.all(8.0),
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
                                  contentPadding: EdgeInsets.all(8.0),
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
                                  contentPadding: EdgeInsets.all(8.0),
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
                                  contentPadding: EdgeInsets.all(8.0),
                                  border:
                                  OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor),)
                              ),
                            )
                          //buildTextField(_vehicleCode, '车辆编号', vehicleCodeController),
                        ),
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
