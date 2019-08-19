import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/dao/HistoryBillDao.dart';
import 'package:car_free_company/common/dao/ResultDao.dart';
import 'package:car_free_company/common/dao/TransportPlaceDao.dart';
import 'package:car_free_company/common/local/LocalStorage.dart';
import 'package:car_free_company/common/model/HistoryBill.dart';
import 'package:car_free_company/common/model/TransportPlace.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/common/utils/CommonUtils.dart';
import 'package:car_free_company/widget/BaseHistoryBillState.dart';
import 'package:car_free_company/widget/CustomFlexButton.dart';
import 'package:car_free_company/widget/CustomPullLoadWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';

class HistoryBillPage extends StatefulWidget {
  static final String name = "HistoryBill";

  HistoryBillPage({Key key}) : super(key: key);

  _HistoryBillPage createState() => _HistoryBillPage();
}

class _HistoryBillPage extends BaseHistoryBillState<HistoryBillPage> {
//  List<TransportPlace> items = [
//    TransportPlace(1, 0, "中国", "01"),
//    TransportPlace(2, 0, "美国", "02"),
//    TransportPlace(3, 0, "澳大利亚", "03"),
//    TransportPlace(4, 1, "内蒙古", "001"),
//    TransportPlace(5, 1, "四川", "002"),
//    TransportPlace(6, 4, "呼和浩特", "0001"),
//    TransportPlace(7, 4, "包头", "0002"),
//  ];
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

  var _dateBegin = DateTime.now().toString().substring(0, 10);
  var _dateEnd = DateTime.now().add(new Duration(days: 1)).toString().substring(0, 10);

  List<TransportPlace> items;

  var selected; //选中的地址描述
  var selectedId; //选中的地址id

  bool _delOff = true; //是否展示删除按钮
  String _key = ""; //搜索的关键字
  String _loadPlace = "";
  String _unloadPlace = "";
  String _vehicleCode = "";
  String _mainVehiclePlate = "";

  var _dateBeginNext = "";
  var _dateEndNext = "";

  String _vehicleCodeNext = "";
  String _mainVehiclePlateNext = "";

  int _loadPlaceId;
  int _unloadPlaceId;
  int _loadPlaceNextId;
  int _unloadPlaceNextId;
  final TextEditingController vehicleCodeController =
      new TextEditingController();
  final TextEditingController plateNumberController =
      new TextEditingController();

//  final TextEditingController loadPlaceController = new TextEditingController();
//  final TextEditingController unloadPlaceController = new TextEditingController();
  final CustomPullLoadWidgetControl pullLoadWidgetControl =
      new CustomPullLoadWidgetControl();

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
      _dateBegin = _picker.toString().substring(0, 10);
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
      _dateEnd = _picker.toString().substring(0, 10);
    });
  }

  ///装地选择器
  showLoadPlacePickerArray(BuildContext context) {
    new Picker(
        adapter: PickerDataAdapter<String>(
          //pickerdata: items,//new JsonDecoder().convert(transportPlaces),
          isArray: false,
        ),
        hideHeader: true,
        selecteds: [0],
        title: new Text("请选择"),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
          setState(() {
            _loadPlace = picker.getSelectedValues()[0];
          });
        }).showDialog(context);
  }

  ///卸地选择器
  showUnloadPlacePickerArray(BuildContext context) {
    new Picker(
        adapter: PickerDataAdapter<String>(
          //pickerdata: items,//new JsonDecoder().convert(transportPlaces),
          isArray: false,
        ),
        hideHeader: true,
        selecteds: [0],
        title: new Text("请选择"),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
          setState(() {
            _unloadPlace = picker.getSelectedValues()[0];
          });
        }).showDialog(context);
  }

  ///获取数据
  _getData(dateBegin, dateEnd, loadPlace, unloadPlace, vehicleCode,
      mainVehiclePlate, skipCount) async {
    if(loadPlace == null){
      loadPlace = "";
    }
    if(unloadPlace == null){
      unloadPlace = "";
    }
    final List<HistoryBill> historyBillList = new List();
    var historyBills = await HistoryBillDao.getHistoryBills(
        dateBegin,
        dateEnd,
        loadPlace,
        unloadPlace,
        vehicleCode,
        mainVehiclePlate,
        Config.MAX_RESULT,
        skipCount);
    if (historyBills != null && historyBills.result) {
      print("skipCount : " + skipCountGlobal.toString());
      print("historyBills: " + historyBills.data.toString());
      var itemList = historyBills.data["result"]["items"];
      print("historyBills's itemList: " +
          itemList.toString() +
          itemList.length.toString());
      print("historyBills itemList length: " + itemList.length.toString());
      for (int i = 0; i < itemList.length; i++) {
        var id = itemList[i]["id"].toString();
        var vehicleCode = itemList[i]["vehicleCode"].toString();
        var mainVehiclePlate = itemList[i]["mainVehiclePlate"].toString();
        var deliveryOrderCode = itemList[i]["deliveryOrderCode"].toString();
        var deliveryOrderState = itemList[i]["deliveryOrderState"];
        var deliveryOrderStateText = itemList[i]["deliveryOrderStateText"];
        var generateDate = itemList[i]["generateDate"].toString();
        var loadPlaceId = itemList[i]["loadPlaceId"];
        var loadPlaceName = itemList[i]["loadPlaceName"].toString();
        var unloadPlaceId = itemList[i]["unloadPlaceId"];
        var unloadPlaceName = itemList[i]["unloadPlaceName"].toString();
        var goodsId = itemList[i]["goodsId"];
        var goodsName = itemList[i]["goodsName"].toString();
        var outStockGenerateDate =
            itemList[i]["outStockGenerateDate"].toString();
        var outStockNetWeigh = itemList[i]["outStockNetWeigh"];
        var weighDate = itemList[i]["weighDate"].toString();
        var skinbackDate = itemList[i]["skinbackDate"].toString();
        var inStockGrossWeigh = itemList[i]["inStockGrossWeigh"];
        var inStockNetWeigh = itemList[i]["inStockNetWeigh"];
        historyBillList.add(new HistoryBill(id, unloadPlaceName, skinbackDate, outStockNetWeigh, outStockGenerateDate, loadPlaceName, inStockNetWeigh, inStockGrossWeigh, goodsName, deliveryOrderCode, deliveryOrderState, generateDate, vehicleCode, mainVehiclePlate, weighDate, unloadPlaceId, loadPlaceId, goodsId, deliveryOrderStateText));
      }
      return new DataResult(historyBillList, true);
    }
    if (historyBills.data == null && !historyBills.result) {
      return new DataResult("到底了", false);
    }
  }

  ///请求刷新
  @override
  requestRefresh() {
    // TODO: implement requestRefresh
    //getMessagePush();
    skipCountGlobal = 10;
    //print("parameters: " + skipCountInit.toString());
    return _getData(_dateBegin, _dateEnd, _loadPlaceId, _unloadPlaceId,
        _vehicleCode, _mainVehiclePlate, skipCountInit);
  }

  ///请求加载更多
  @override
  requestLoadMore() async {
    // TODO: implement requestLoadMore
    var dataLoadMore = await _getData(
        _dateBeginNext.trim(),
        _dateEndNext.trim(),
        _loadPlaceNextId,
        _unloadPlaceNextId,
        _vehicleCodeNext.trim(),
        _mainVehiclePlateNext.trim(),
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

    //items =  _getTransportPlaceData();
//    loadPlaceController.value = new TextEditingValue(text: "");
//    unloadPlaceController.value = new TextEditingValue(text: "");
    vehicleCodeController.value = new TextEditingValue(text: "");
    plateNumberController.value = new TextEditingValue(text: "");
  }

  ///initState后调用，在didChangeDependencies中，可以跨组件拿到数据。
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
//    loadPlaceController.dispose();
//    unloadPlaceController.dispose();
    vehicleCodeController.dispose();
    plateNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //backgroundColor: CustomColors.listBackground,
      appBar: new AppBar(
        title: new Text("历史提货单"),
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
                              handleRefresh();
                              _dateBeginNext = _dateBegin;
                              _dateEndNext = _dateEnd;
                              _loadPlaceNextId = _loadPlaceId;
                              _unloadPlaceNextId = _unloadPlaceId;
                              _vehicleCodeNext = _vehicleCode;
                              _mainVehiclePlateNext = _mainVehiclePlate;
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
                          child: new OutlineButton(
                              child: new Padding(
                                padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                child: new Text(
                                  _loadPlace == "" ? " 装地 " : _loadPlace,
                                  style: CustomConstant.hintText,
                                ),
                              ),
                              color: Color(CustomColors.white),
                              borderSide: new BorderSide(color: Colors.grey),
                              onPressed:
                                  () {
                                TransportPlaceDao.getTransportPlace()
                                    .then((futurePlaces) {
                                  List<TransportPlace> placeList = new List();
                                  //装卸地
                                  if (futurePlaces != null && futurePlaces.result) {
                                    print("places: " + futurePlaces.data.toString());
                                    var itemList = futurePlaces.data["result"]["items"];
                                    print("plans's itemList: " +
                                        itemList.toString() +
                                        itemList.length.toString());
                                    print("plans itemList length: " +
                                        itemList.length.toString());
                                    for (int i = 0; i < itemList.length; i++) {
                                      var text = itemList[i]["text"].toString();
                                      var value = itemList[i]["value"].toString();
                                      var id = itemList[i]["id"];
                                      var parentId = itemList[i]["parentId"];
                                      placeList.add(
                                          new TransportPlace(id, parentId, text, value));
                                    }
                                  }
                                  items = placeList;

                                  _key = "";
                                  _delOff = true;
                                  var currentParentId = -1;
                                  List<TransportPlace> firstLevel = new List();
                                  for (int i = 0; i < items.length; i++) {
                                    if (items[i].parentId == null) {
                                      firstLevel.add(items[i]);
                                    }
                                  }
                                  var itemstemp = firstLevel;
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return new AlertDialog(
                                          title: new Text("地址选择"),
                                          content: new StatefulBuilder(
                                              builder: (context, StateSetter setState) {
                                                return new Column(children: <Widget>[
                                                  new TextField(
                                                      cursorColor: Colors.blue,
                                                      // 光标颜色
                                                      // 默认设置
                                                      decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets.symmetric(
                                                              vertical: 10.0),
                                                          border: InputBorder.none,
                                                          icon: Icon(Icons.search),
                                                          suffixIcon: GestureDetector(
                                                            child: Offstage(
                                                              offstage: _delOff,
                                                              child: Icon(
                                                                Icons.highlight_off,
                                                                color: Colors.blue,
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              setState(() {
                                                                _key = "";
                                                                itemstemp = search(_key);
                                                              });
                                                            },
                                                          ),
                                                          hintText: "搜索 装地",
                                                          hintStyle: new TextStyle(
                                                              fontSize: 16,
                                                              color: Color.fromARGB(
                                                                  50, 0, 0, 0))),
                                                      controller:
                                                      TextEditingController.fromValue(
                                                        TextEditingValue(
                                                          text: _key,
                                                          selection:
                                                          TextSelection.fromPosition(
                                                            TextPosition(
                                                              offset: _key == null
                                                                  ? 0
                                                                  : _key.length, //保证光标在最后
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      style: new TextStyle(
                                                          fontSize: 16, color: Colors.black),
                                                      onChanged: (str) {
                                                        setState(() {
                                                          itemstemp = search(str);
                                                        });
                                                      }),
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
                                                          itemCount: itemstemp.length,
                                                          itemBuilder: (context, index) {
                                                            return new OutlineButton(
                                                                borderSide: new BorderSide(
                                                                    color: Colors.grey),
                                                                child: Text(
                                                                  '${itemstemp[index].text}',
                                                                  style: CustomConstant
                                                                      .placeTextBlack,
                                                                ),
                                                                onPressed: () {
                                                                  List<TransportPlace>
                                                                  subLevel = new List();
                                                                  for (int i = 0;
                                                                  i < items.length;
                                                                  i++) {
                                                                    if (itemstemp[index].id ==
                                                                        items[i].parentId) {
                                                                      subLevel.add(items[i]);
                                                                    }
                                                                  }
                                                                  if (subLevel.length != 0) {
                                                                    currentParentId =
                                                                        subLevel[0].parentId;
                                                                    setState(() {
                                                                      itemstemp = subLevel;
                                                                    });
                                                                  } else {
                                                                    selected =
                                                                        itemstemp[index]
                                                                            .text
                                                                            .toString();
                                                                    selectedId =
                                                                        itemstemp[index]
                                                                            .id
                                                                            .toString();
                                                                    currentParentId =
                                                                        itemstemp[index]
                                                                            .parentId;
                                                                    var callback;
                                                                    callback = [
                                                                      selected,
                                                                      selectedId
                                                                    ];
                                                                    Navigator.of(context)
                                                                        .pop(callback);
                                                                  }
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
                                                          "上一级",
                                                          style:
                                                          TextStyle(color: Colors.blue),
                                                        ),
                                                        onPressed: () {
                                                          //获取当前选中id，更新列表为选中id上级
                                                          List<TransportPlace> highLevel =
                                                          new List();
                                                          var highParentId;
                                                          for (int i = 0;
                                                          i < items.length;
                                                          i++) {
                                                            if (items[i].id ==
                                                                currentParentId) {
                                                              highParentId =
                                                                  items[i].parentId;
                                                            }
                                                          }
                                                          for (int i = 0;
                                                          i < items.length;
                                                          i++) {
                                                            if (items[i].parentId ==
                                                                highParentId) {
                                                              highLevel.add(items[i]);
                                                            }
                                                          }
                                                          if (highLevel.length != 0) {
                                                            currentParentId =
                                                                highLevel[0].parentId;
                                                            setState(() {
                                                              itemstemp = highLevel;
                                                            });
                                                          } else {}
                                                        },
                                                      ),
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
                                      _loadPlace = value[0];
                                      if (value[1] != "") {
                                        _loadPlaceId = int.parse(value[1]);
                                      } else {
                                        _loadPlaceId = null;
                                      }
                                    });
                                  });
                                });
                              }),
                        ),
                        new Padding(padding: EdgeInsets.all(5.0)),
                        Expanded(
                          child: new OutlineButton(
                              child: new Padding(
                                padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                child: new Text(
                                  _unloadPlace == "" ? " 卸地 " : _unloadPlace,
                                  style: CustomConstant.hintText,
                                ),
                              ),
                              color: Color(CustomColors.white),
                              borderSide: new BorderSide(color: Colors.grey),
                              onPressed: //() => showUnloadPlacePickerArray(context),
                                  () {
                                TransportPlaceDao.getTransportPlace()
                                    .then((futurePlaces) {
                                  List<TransportPlace> placeList = new List();
                                  //装卸地
                                  if (futurePlaces != null && futurePlaces.result) {
                                    print("places: " + futurePlaces.data.toString());
                                    var itemList = futurePlaces.data["result"]["items"];
                                    print("plans's itemList: " +
                                        itemList.toString() +
                                        itemList.length.toString());
                                    print("plans itemList length: " +
                                        itemList.length.toString());
                                    for (int i = 0; i < itemList.length; i++) {
                                      var text = itemList[i]["text"].toString();
                                      var value = itemList[i]["value"].toString();
                                      var id = itemList[i]["id"];
                                      var parentId = itemList[i]["parentId"];
                                      placeList.add(
                                          new TransportPlace(id, parentId, text, value));
                                    }
                                  }
                                  items = placeList;

                                  _key = "";
                                  _delOff = true;
                                  var currentParentId = -1;
                                  List<TransportPlace> firstLevel = new List();
                                  for (int i = 0; i < items.length; i++) {
                                    if (items[i].parentId == null) {
                                      firstLevel.add(items[i]);
                                    }
                                  }
                                  var itemstemp = firstLevel;
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return new AlertDialog(
                                          title: new Text("地址选择"),
                                          content: new StatefulBuilder(
                                              builder: (context, StateSetter setState) {
                                                return new Column(children: <Widget>[
                                                  new TextField(
                                                      cursorColor: Colors.blue,
                                                      // 光标颜色
                                                      // 默认设置
                                                      decoration: InputDecoration(
                                                          contentPadding:
                                                          const EdgeInsets.symmetric(
                                                              vertical: 10.0),
                                                          border: InputBorder.none,
                                                          icon: Icon(Icons.search),
                                                          suffixIcon: GestureDetector(
                                                            child: Offstage(
                                                              offstage: _delOff,
                                                              child: Icon(
                                                                Icons.highlight_off,
                                                                color: Colors.blue,
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              setState(() {
                                                                _key = "";
                                                                itemstemp = search(_key);
                                                              });
                                                            },
                                                          ),
                                                          hintText: "搜索 卸地",
                                                          hintStyle: new TextStyle(
                                                              fontSize: 16,
                                                              color: Color.fromARGB(
                                                                  50, 0, 0, 0))),
                                                      controller:
                                                      TextEditingController.fromValue(
                                                        TextEditingValue(
                                                          text: _key,
                                                          selection:
                                                          TextSelection.fromPosition(
                                                            TextPosition(
                                                              offset: _key == null
                                                                  ? 0
                                                                  : _key.length, //保证光标在最后
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      style: new TextStyle(
                                                          fontSize: 16, color: Colors.black),
                                                      onChanged: (str) {
                                                        setState(() {
                                                          itemstemp = search(str);
                                                        });
                                                      }),
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
                                                          itemCount: itemstemp.length,
                                                          itemBuilder: (context, index) {
                                                            return new OutlineButton(
                                                                borderSide: new BorderSide(
                                                                    color: Colors.grey),
                                                                child: Text(
                                                                  '${itemstemp[index].text}',
                                                                  style: CustomConstant
                                                                      .placeTextBlack,
                                                                ),
                                                                onPressed: () {
                                                                  List<TransportPlace>
                                                                  subLevel = new List();
                                                                  for (int i = 0;
                                                                  i < items.length;
                                                                  i++) {
                                                                    if (itemstemp[index].id ==
                                                                        items[i].parentId) {
                                                                      subLevel.add(items[i]);
                                                                    }
                                                                  }
                                                                  if (subLevel.length != 0) {
                                                                    currentParentId =
                                                                        subLevel[0].parentId;
                                                                    setState(() {
                                                                      itemstemp = subLevel;
                                                                    });
                                                                  } else {
                                                                    selected =
                                                                        itemstemp[index]
                                                                            .text
                                                                            .toString();
                                                                    selectedId =
                                                                        itemstemp[index]
                                                                            .id
                                                                            .toString();
                                                                    currentParentId =
                                                                        itemstemp[index]
                                                                            .parentId;
                                                                    var callback;
                                                                    callback = [
                                                                      selected,
                                                                      selectedId
                                                                    ];
                                                                    Navigator.of(context)
                                                                        .pop(callback);
                                                                  }
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
                                                          "上一级",
                                                          style:
                                                          TextStyle(color: Colors.blue),
                                                        ),
                                                        onPressed: () {
                                                          //获取当前选中id，更新列表为选中id上级
                                                          List<TransportPlace> highLevel =
                                                          new List();
                                                          var highParentId;
                                                          for (int i = 0;
                                                          i < items.length;
                                                          i++) {
                                                            if (items[i].id ==
                                                                currentParentId) {
                                                              highParentId =
                                                                  items[i].parentId;
                                                            }
                                                          }
                                                          for (int i = 0;
                                                          i < items.length;
                                                          i++) {
                                                            if (items[i].parentId ==
                                                                highParentId) {
                                                              highLevel.add(items[i]);
                                                            }
                                                          }
                                                          if (highLevel.length != 0) {
                                                            currentParentId =
                                                                highLevel[0].parentId;
                                                            setState(() {
                                                              itemstemp = highLevel;
                                                            });
                                                          } else {}
                                                        },
                                                      ),
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
                                      _unloadPlace = value[0];
                                      if (value[1] != "") {
                                        _unloadPlaceId = int.parse(value[1]);
                                      } else {
                                        _unloadPlaceId = null;
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
                                border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Theme.of(context).primaryColor),
                                )),
                          ),
                          //buildTextField(_mainVehiclePlate, '车牌号', plateNumberController)
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
                                border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Theme.of(context).primaryColor),
                                )),
                          ),
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
            (BuildContext context, int index) => renderItem(index, () {
                  _refreshNotify();
                }),
            handleRefresh,
            onLoadMore,
            refreshKey: refreshIndicatorKey,
          )),
        ],
      ),
    );
  }

  List<TransportPlace> search(String value) {
    _key = value;
    if (value.isEmpty) {
      _delOff = true;
      return items;
    } else {
      _delOff = false;
      List<TransportPlace> searchResult = new List();
      for (int i = 0; i < items.length; i++) {
        if (items[i].text.toLowerCase().contains(value.toLowerCase())) {
          searchResult.add(items[i]);
        }
      }
      return searchResult;
    }
  }
}
