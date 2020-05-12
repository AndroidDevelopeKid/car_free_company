import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/dao/DriverDao.dart';
import 'package:car_free_company/common/dao/ResultDao.dart';
import 'package:car_free_company/common/model/DriverBrief.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/common/utils/CommonUtils.dart';
import 'package:car_free_company/widget/BaseDriverState.dart';
import 'package:car_free_company/widget/CustomPullLoadWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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

  _refreshNotify() {
    if (isShow) {
      setState(() {
        planColor = Colors.green;
      });
    }
  }

  var _isExpanded = false;

  var _dateBegin =
      DateTime.now().add(new Duration()).toString().substring(0, 10);
  var _dateEnd =
      DateTime.now().add(new Duration(days: 1)).toString().substring(0, 10);
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

  final TextEditingController driverIdNumberController =
      new TextEditingController();
  final TextEditingController driverNameController =
      new TextEditingController();
  final TextEditingController phoneNumberController =
      new TextEditingController();
  final TextEditingController vehicleCodeController =
      new TextEditingController();

  final CustomPullLoadWidgetControl pullLoadWidgetControl =
      new CustomPullLoadWidgetControl();

  ///获取数据
  _getData(joinDateBegin, joinDateEnd, idNumber, name, phone, vehicleCode,
      skipCount) async {
    final List<DriverBrief> driverBriefList = new List();
    var driverBriefs = await DriverDao.getDriverQuery(
        joinDateBegin,
        joinDateEnd,
        idNumber,
        name,
        phone,
        vehicleCode,
        Config.MAX_RESULT,
        skipCount);
    if (driverBriefs != null && driverBriefs.result) {
      print("skipCount : " + skipCountGlobal.toString());
      print("driverBriefs: " + driverBriefs.data.toString());
      var itemList = driverBriefs.data["result"]["items"];
      print("driverBriefs's itemList: " +
          itemList.toString() +
          itemList.length.toString());
      print("driverBriefs itemList length: " + itemList.length.toString());
      for (int i = 0; i < itemList.length; i++) {
        var id = itemList[i]["id"].toString();
        var vehicleCode = itemList[i]["vehicleCode"];
        var driverIDNumber = itemList[i]["driverIDNumber"];
        var driverName = itemList[i]["driverName"];
        var driverPhone = itemList[i]["driverPhone"];
        driverBriefList.add(new DriverBrief(
            id, vehicleCode, driverIDNumber, driverName, driverPhone));
      }
      return new DataResult(driverBriefList, true);
    }
    if (driverBriefs.data == null && !driverBriefs.result) {
      return new DataResult("到底了", false);
    }

//    final List<DriverBrief> test = new List();
//    test.add(new DriverBrief(
//        "03994949", "vehicleCode", "driverIDNumber", "driverName", "driverPhone"));
//    return new DataResult(test, true);
  }

  ///请求刷新
  @override
  requestRefresh() {
    // TODO: implement requestRefresh
    skipCountGlobal = 10;
    return _getData(_dateBegin, _dateEnd, _driverIdNumber, _driverName,
        _phoneNumber, _vehicleCode, skipCountInit);
  }

  ///请求加载更多
  @override
  requestLoadMore() async {
    // TODO: implement requestLoadMore
    var dataLoadMore = await _getData(
        _dateBeginNext.trim(),
        _dateEndNext.trim(),
        _driverIdNumberNext.trim(),
        _driverNameNext.trim(),
        _phoneNumberNext.trim(),
        _vehicleCodeNext.trim(),
        skipCountGlobal);

    if (dataLoadMore.result) {
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
  void didChangeDependencies() {
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
          title: Text("司机查询",
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
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: new OutlineButton(
                                  padding: EdgeInsets.only(
                                      left: 8.0,
                                      right: 8.0,
                                      top: 10.0,
                                      bottom: 10.0),
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
                                        _dateBegin == ""
                                            ? DateTime.now()
                                                .toString()
                                                .substring(0, 10)
                                            : _dateBegin
                                                .toString()
                                                .substring(0, 10),
                                        style: CustomConstant.hintText,
                                      ),
                                    ],
                                  ),
                                  borderSide:
                                      new BorderSide(color: Color(0xff4C88FF)),
                                  //onPressed: () => _showDatePickerBegin(),
                                  onPressed: () {
                                    DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        maxTime: DateTime.now()
                                            .add(Duration(days: 30)),
                                        minTime: DateTime(1900, 1, 1),
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.zh,
                                        onConfirm: (date) {
                                      setState(() {
                                        _dateBegin = date.toString();
                                      });
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                              ),
                              Expanded(
                                  child: new OutlineButton(
                                padding: EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    top: 10.0,
                                    bottom: 10.0),
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
                                        _dateEnd == ""
                                            ? DateTime.now()
                                                .toString()
                                                .substring(0, 10)
                                            : _dateEnd
                                                .toString()
                                                .substring(0, 10),
                                        style: CustomConstant.hintText),
                                  ],
                                ),
                                borderSide:
                                    new BorderSide(color: Color(0xff4C88FF)),
                                //onPressed: () => _showDatePickerEnd(),
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      maxTime: DateTime.now()
                                          .add(Duration(days: 30)),
                                      minTime: DateTime(1900, 1, 1),
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.zh, onConfirm: (date) {
                                    setState(() {
                                      _dateEnd = date.toString();
                                    });
                                  });
                                },
                              )),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                              ),
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
                                    _dateBeginNext = _dateBegin;
                                    _dateEndNext = _dateEnd;
                                    _driverIdNumberNext = _driverIdNumber;
                                    _driverNameNext = _driverName;
                                    _phoneNumberNext = _phoneNumber;
                                    _vehicleCodeNext = _vehicleCode;
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top: 4.0)),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 40,
                            ),
                            child: TextField(
                              textAlign: TextAlign.center,
                              onChanged: (String value) {
                                _driverIdNumber = value;
                              },
                              controller: driverIdNumberController,
                              decoration: InputDecoration(
                                  hintText: '输入身份证号码查询',
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
                          //buildTextField(_driverIdNumber, '身份证', driverIdNumberController)

                          Padding(padding: EdgeInsets.only(top: 8.0)),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 40,
                            ),
                            child: TextField(
                              textAlign: TextAlign.center,
                              onChanged: (String value) {
                                _driverName = value;
                              },
                              controller: driverNameController,
                              decoration: InputDecoration(
                                  hintText: '输入姓名查询',
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

                          Padding(padding: EdgeInsets.only(top: 8.0)),
                          ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 40,
                              ),
                              child: TextField(
                                textAlign: TextAlign.center,
                                onChanged: (String value) {
                                  _phoneNumber = value;
                                },
                                controller: phoneNumberController,
                                decoration: InputDecoration(
                                    hintText: '输入电话号码查询',
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
                              )
                              //buildTextField(_phoneNumber, '电话号码', phoneNumberController)
                              ),
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
                              )
                              //buildTextField(_vehicleCode, '车辆编号', vehicleCodeController),
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
