import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/dao/HistoryBillDao.dart';
import 'package:car_free_company/common/dao/ResultDao.dart';
import 'package:car_free_company/common/dao/TransportPlaceDao.dart';
import 'package:car_free_company/common/model/HistoryBill.dart';
import 'package:car_free_company/common/model/TransportPlace.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/common/utils/CommonUtils.dart';
import 'package:car_free_company/widget/BaseHistoryBillState.dart';
import 'package:car_free_company/widget/CustomPullLoadWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_picker/Picker.dart';

class HistoryBillPage extends StatefulWidget {
  static final String name = "HistoryBill";

  HistoryBillPage({Key key}) : super(key: key);

  _HistoryBillPage createState() => _HistoryBillPage();
}

class _HistoryBillPage extends BaseHistoryBillState<HistoryBillPage> {
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
  var _dateEnd =
      DateTime.now().add(new Duration(days: 1)).toString().substring(0, 10);

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
    if (loadPlace == null) {
      loadPlace = "";
    }
    if (unloadPlace == null) {
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
        var coalCode = itemList[i]["coalCode"];
        var coalText = itemList[i]["coalText"];
        var outStockGenerateDate =
            itemList[i]["outStockGenerateDate"].toString();
        var outStockNetWeigh = itemList[i]["outStockNetWeigh"];
        var weighDate = itemList[i]["weighDate"].toString();
        var skinbackDate = itemList[i]["skinbackDate"].toString();
        var inStockGrossWeigh = itemList[i]["inStockGrossWeigh"];
        var inStockNetWeigh = itemList[i]["inStockNetWeigh"];
        historyBillList.add(new HistoryBill(
            id,
            unloadPlaceName,
            skinbackDate,
            outStockNetWeigh,
            outStockGenerateDate,
            loadPlaceName,
            inStockNetWeigh,
            inStockGrossWeigh,
            goodsName,
            deliveryOrderCode,
            deliveryOrderState,
            generateDate,
            vehicleCode,
            mainVehiclePlate,
            weighDate,
            unloadPlaceId,
            loadPlaceId,
            goodsId,
            deliveryOrderStateText,
            coalCode,
            coalText,
        ));
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
    super.build(context);
    return Scaffold(
      //backgroundColor: CustomColors.listBackground,
      appBar: AppBar(
        leading: IconButton(
            iconSize: 15.0,
            icon: Icon(CustomIcons.BACK, color: Color(0xff4C88FF)),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text("历史提货单",
            style: TextStyle(fontSize: 18.0, color: Colors.black)),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ExpansionPanelList(
              children: <ExpansionPanel>[
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Container(
                            decoration: BoxDecoration(color: Color(0xffE2ECFF)),
                            child: Center(
                                child: Text(
                              "点击展开查询条件",
                              style: TextStyle(
                                  fontSize: 15.0, color: Color(0xff4C88FF)),
                            ))));
                  },
                  body: Padding(
                    padding:
                        EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child:  OutlineButton(
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
                                      locale: LocaleType.zh, onConfirm: (date) {
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
                                child: OutlineButton(
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
                                    maxTime:
                                        DateTime.now().add(Duration(days: 30)),
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
                                  _loadPlaceNextId = _loadPlaceId;
                                  _unloadPlaceNextId = _unloadPlaceId;
                                  _vehicleCodeNext = _vehicleCode;
                                  _mainVehiclePlateNext = _mainVehiclePlate;
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                        OutlineButton(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              child: Text(
                                _loadPlace == "" ? " 请选择装地 " : _loadPlace,
                                style: CustomConstant.hintBlueText,
                              ),
                            ),
                            color: Color(CustomColors.white),
                            borderSide: BorderSide(color: Color(0xff4C88FF)),
                            onPressed: () {
                              TransportPlaceDao.getTransportPlace()
                                  .then((futurePlaces) {
                                List<TransportPlace> placeList = new List();
                                //装卸地
                                if (futurePlaces != null &&
                                    futurePlaces.result) {
                                  print("places: " +
                                      futurePlaces.data.toString());
                                  var itemList =
                                      futurePlaces.data["result"]["items"];
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
                                    placeList.add(new TransportPlace(
                                        id, parentId, text, value));
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
                                      return AlertDialog(
                                        title: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 15.0,
                                              height: 15.0,
                                              child: Image(
                                                  image: AssetImage(
                                                      CustomIcons.DI_ZHI)),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 6.0, right: 6.0),
                                            ),
                                            Text(
                                              "地址选择",
                                              style: TextStyle(fontSize: 15.0),
                                            ),
                                          ],
                                        ),
                                        content: StatefulBuilder(builder:
                                            (context, StateSetter setState) {
                                          return Column(children: <Widget>[
                                            ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxHeight: 28,
                                              ),
                                              child: TextField(
                                                  cursorColor: Colors.blue,
                                                  // 光标颜色
                                                  // 默认设置
                                                  decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.all(0.0),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xffEEEEEE)),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xffEEEEEE)),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(),
                                                      prefixIcon: Icon(
                                                        CustomIcons.SOU,
                                                        size: 14.0,
                                                        color:
                                                            Color(0xff4C88FF),
                                                      ),
                                                      //icon: Icon(Icons.search),
//                                                        suffixIcon: GestureDetector(
//                                                          child: Offstage(
//                                                            offstage: _delOff,
//                                                            child: SizedBox(
//                                                              //Icons.highlight_off,
//                                                              child:Image.asset(CustomIcons.SOU_SUO),
//                                                              width: 14.0,
//                                                              height: 14.0,
//                                                            ),
//                                                          ),
//                                                          onTap: () {
//                                                            setState(() {
//                                                              _key = "";
//                                                              itemstemp = search(_key);
//                                                            });
//                                                          },
//                                                        ),
                                                      hintText: "| 搜索装地",
                                                      hintStyle: TextStyle(
                                                          fontSize: 15.0,
                                                          color: Color(
                                                              0xffEEEEEE))),
                                                  controller:
                                                      TextEditingController
                                                          .fromValue(
                                                    TextEditingValue(
                                                      text: _key,
                                                      selection: TextSelection
                                                          .fromPosition(
                                                        TextPosition(
                                                          offset: _key == null
                                                              ? 0
                                                              : _key
                                                                  .length, //保证光标在最后
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                  onChanged: (str) {
                                                    setState(() {
                                                      itemstemp = search(str);
                                                    });
                                                  }),
                                            ),
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
                                                child:  ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: itemstemp.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return OutlineButton(
                                                          borderSide:
                                                          BorderSide(
                                                                  color: Color(
                                                                      0xff4C88FF)),
                                                          child: Text(
                                                            '${itemstemp[index].text}',
                                                            style: CustomConstant
                                                                .placeTextBlack,
                                                          ),
                                                          onPressed: () {
                                                            List<TransportPlace>
                                                                subLevel =
                                                                new List();
                                                            for (int i = 0;
                                                                i <
                                                                    items
                                                                        .length;
                                                                i++) {
                                                              if (itemstemp[
                                                                          index]
                                                                      .id ==
                                                                  items[i]
                                                                      .parentId) {
                                                                subLevel.add(
                                                                    items[i]);
                                                              }
                                                            }
                                                            if (subLevel
                                                                    .length !=
                                                                0) {
                                                              currentParentId =
                                                                  subLevel[0]
                                                                      .parentId;
                                                              setState(() {
                                                                itemstemp =
                                                                    subLevel;
                                                              });
                                                            } else {
                                                              selected =
                                                                  itemstemp[
                                                                          index]
                                                                      .text
                                                                      .toString();
                                                              selectedId =
                                                                  itemstemp[
                                                                          index]
                                                                      .id
                                                                      .toString();
                                                              currentParentId =
                                                                  itemstemp[
                                                                          index]
                                                                      .parentId;
                                                              var callback;
                                                              callback = [
                                                                selected,
                                                                selectedId
                                                              ];
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(
                                                                      callback);
                                                            }
                                                          });
                                                    }),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                OutlineButton(
                                                  borderSide: BorderSide(
                                                      color: Color(0xff4C88FF)),
                                                  child: Text(
                                                    "上一级",
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ),
                                                  onPressed: () {
                                                    //获取当前选中id，更新列表为选中id上级
                                                    List<TransportPlace>
                                                        highLevel = new List();
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
                                        elevation: 20,
                                        // 设置成 圆角
                                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                        OutlineButton(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                _unloadPlace == "" ? " 请选择卸地 " : _unloadPlace,
                                style: CustomConstant.hintBlueText,
                              ),
                            ),
                            color: Color(CustomColors.white),
                            borderSide: BorderSide(color: Color(0xff4C88FF)),
                            onPressed: //() => showUnloadPlacePickerArray(context),
                                () {
                              TransportPlaceDao.getTransportPlace()
                                  .then((futurePlaces) {
                                List<TransportPlace> placeList = new List();
                                //装卸地
                                if (futurePlaces != null &&
                                    futurePlaces.result) {
                                  print("places: " +
                                      futurePlaces.data.toString());
                                  var itemList =
                                      futurePlaces.data["result"]["items"];
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
                                    placeList.add(new TransportPlace(
                                        id, parentId, text, value));
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
                                      return AlertDialog(
                                        title: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 15.0,
                                              height: 15.0,
                                              child: Image(
                                                  image: AssetImage(
                                                      CustomIcons.DI_ZHI)),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 6.0, right: 6.0),
                                            ),
                                            Text(
                                              "地址选择",
                                              style: TextStyle(fontSize: 15.0),
                                            ),
                                          ],
                                        ),
                                        content: StatefulBuilder(builder:
                                            (context, StateSetter setState) {
                                          return Column(children: <Widget>[
                                            ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxHeight: 28,
                                              ),
                                              child: TextField(
                                                  cursorColor: Colors.blue,
                                                  // 光标颜色
                                                  // 默认设置
                                                  decoration: InputDecoration(
                                                      contentPadding:EdgeInsets.all(0.0),
                                                      //: Icon(Icons.search),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xffEEEEEE)),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xffEEEEEE)),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(),
                                                      prefixIcon: Icon(
                                                        CustomIcons.SOU,
                                                        size: 14.0,
                                                        color:
                                                            Color(0xff4C88FF),
                                                      ),

//                                                        suffixIcon: GestureDetector(
//                                                          child: Offstage(
//                                                            offstage: _delOff,
//                                                            child: Icon(
//                                                              Icons.highlight_off,
//                                                              color: Colors.blue,
//                                                            ),
//                                                          ),
//                                                          onTap: () {
//                                                            setState(() {
//                                                              _key = "";
//                                                              itemstemp = search(_key);
//                                                            });
//                                                          },
//                                                        ),
                                                      hintText: "| 搜索卸地",
                                                      hintStyle: TextStyle(
                                                          fontSize: 15,
                                                          color: Color(
                                                              0xffEEEEEE))),
                                                  controller:
                                                      TextEditingController
                                                          .fromValue(
                                                    TextEditingValue(
                                                      text: _key,
                                                      selection: TextSelection
                                                          .fromPosition(
                                                        TextPosition(
                                                          offset: _key == null
                                                              ? 0
                                                              : _key
                                                                  .length, //保证光标在最后
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                  onChanged: (str) {
                                                    setState(() {
                                                      itemstemp = search(str);
                                                    });
                                                  }),
                                            ),
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
                                                    itemCount: itemstemp.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return OutlineButton(
                                                          borderSide:
                                                          BorderSide(
                                                                  color: Color(
                                                                      0xff4C88FF)),
                                                          child: Text(
                                                            '${itemstemp[index].text}',
                                                            style: CustomConstant
                                                                .placeTextBlack,
                                                          ),
                                                          onPressed: () {
                                                            List<TransportPlace>
                                                                subLevel =
                                                                new List();
                                                            for (int i = 0;
                                                                i <
                                                                    items
                                                                        .length;
                                                                i++) {
                                                              if (itemstemp[
                                                                          index]
                                                                      .id ==
                                                                  items[i]
                                                                      .parentId) {
                                                                subLevel.add(
                                                                    items[i]);
                                                              }
                                                            }
                                                            if (subLevel
                                                                    .length !=
                                                                0) {
                                                              currentParentId =
                                                                  subLevel[0]
                                                                      .parentId;
                                                              setState(() {
                                                                itemstemp =
                                                                    subLevel;
                                                              });
                                                            } else {
                                                              selected =
                                                                  itemstemp[
                                                                          index]
                                                                      .text
                                                                      .toString();
                                                              selectedId =
                                                                  itemstemp[
                                                                          index]
                                                                      .id
                                                                      .toString();
                                                              currentParentId =
                                                                  itemstemp[
                                                                          index]
                                                                      .parentId;
                                                              var callback;
                                                              callback = [
                                                                selected,
                                                                selectedId
                                                              ];
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(
                                                                      callback);
                                                            }
                                                          });
                                                    }),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                OutlineButton(
                                                  borderSide: BorderSide(
                                                      color: Color(0xff4C88FF)),
                                                  child: Text(
                                                    "上一级",
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ),
                                                  onPressed: () {
                                                    //获取当前选中id，更新列表为选中id上级
                                                    List<TransportPlace>
                                                        highLevel = new List();
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
                        Padding(
                          padding: EdgeInsets.only(top: 4.0),
                        ),
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
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                        ),
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
