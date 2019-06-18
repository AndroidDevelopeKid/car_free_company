import 'dart:convert';

import 'package:car_free_company/common/config/CompanyConfig.dart';
import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/dao/DailySourcePlanDao.dart';
import 'package:car_free_company/common/dao/ResultDao.dart';
import 'package:car_free_company/common/dao/TransportPlaceDao.dart';
import 'package:car_free_company/common/model/DailySourcePlan.dart';
import 'package:car_free_company/common/model/TransportPlace.dart';
import 'package:car_free_company/common/model/organ.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/common/utils/NavigatorUtils.dart';
import 'package:car_free_company/widget/BaseDailySourcePlanState.dart';
import 'package:car_free_company/widget/CustomFlexButton.dart';
import 'package:car_free_company/widget/CustomPickDialog.dart';
import 'package:car_free_company/widget/CustomPullLoadWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';

class DailySourcePlanPage extends StatefulWidget {
  static final String name = "DailySourcePlan";

  DailySourcePlanPage({Key key}) : super(key: key);

  _DailySourcePlanPage createState() => _DailySourcePlanPage();
}

class _DailySourcePlanPage
    extends BaseDailySourcePlanState<DailySourcePlanPage> {
//  List<TransportPlace> items = [
//    TransportPlace(1, 0, "中国", "01"),
//    TransportPlace(2, 0, "美国", "02"),
//    TransportPlace(3, 0, "澳大利亚", "03"),
//    TransportPlace(4, 1, "内蒙古", "001"),
//    TransportPlace(5, 1, "四川", "002"),
//    TransportPlace(6, 4, "呼和浩特", "0001"),
//    TransportPlace(7, 4, "包头", "0002"),
//  ];
  var _dateBegin;
  var _dateEnd;
  var _dateBeginNext;
  var _dateEndNext;
  List<TransportPlace> items;

  var selected; //选中的地址描述
  var selectedId; //选中的地址id

  bool _delOff = true; //是否展示删除按钮
  String _key = ""; //搜索的关键字

  ///消息颜色
  Color planColor = const Color(CustomColors.subLightTextColor);
  int skipCountGlobal = 5;
  int skipCountInit = 0;

  _refreshNotify() {
    if (isShow) {
      setState(() {
        planColor = Colors.green;
      });
    }
  }

  String _loadPlace = "";
  String _unloadPlace = "";
  String _loadPlaceNext = "";
  String _unloadPlaceNext = "";

  int _loadPlaceId = null;
  int _unloadPlaceId = null;
  int _loadPlaceNextId = null;
  int _unloadPlaceNextId = null;

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

  ///装地选择器
  showLoadPlacePickerArray(BuildContext context) {
    new Picker(
        adapter: PickerDataAdapter<String>(
          pickerdata: items,
          //new JsonDecoder().convert(transportPlaces),
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
          pickerdata: items,
          //new JsonDecoder().convert(transportPlaces),
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

  ///获取装卸地数据
  _getTransportPlaceData() async {
    final List<TransportPlace> placeList = new List();
    var places = await TransportPlaceDao.getTransportPlace();

    //装卸地
    if (places != null && places.result) {
      print("places: " + places.data.toString());
      var itemList = places.data["result"]["items"];
      print("plans's itemList: " +
          itemList.toString() +
          itemList.length.toString());
      print("plans itemList length: " + itemList.length.toString());
      for (int i = 0; i < itemList.length; i++) {
        var text = itemList[i]["text"].toString();
        var value = itemList[i]["value"].toString();
        var id = itemList[i]["id"];
        var parentId = itemList[i]["parentId"];
        placeList.add(new TransportPlace(id, parentId, text, value));
      }
      items = placeList;
    }
  }

  ///获取数据
  _getData(dateBegin, dateEnd, loadPlace, unloadPlace, skipCount) async {
    //获取日计划
    final List<DailySourcePlan> dailyPlanList = new List();
    var plans = await DailySourcePlanDao.getDailySourcePlans(dateBegin, dateEnd,
        loadPlace, unloadPlace, Config.MAX_RESULT, skipCount);
    //日计划
    if (plans != null && plans.result) {
      print("skipCount : " + skipCountGlobal.toString());
      print("plans: " + plans.data.toString());
      var itemList = plans.data["result"]["items"];
      print("plans's itemList: " +
          itemList.toString() +
          itemList.length.toString());
      print("plans itemList length: " + itemList.length.toString());
      for (int i = 0; i < itemList.length; i++) {
        var id = itemList[i]["id"].toString();
        var customerName = itemList[i]["customerName"].toString();
        var loadPlaceIdName = itemList[i]["loadPlaceIdName"].toString();
        var unloadPlaceIdName = itemList[i]["unloadPlaceIdName"].toString();
        var cargoCategoryText = itemList[i]["cargoCategoryText"].toString();
        var expectedTotalTon = itemList[i]["expectedTotalTon"].toString();
        var expectedTruckAmount = itemList[i]["expectedTruckAmount"].toString();
        var sourceDate = itemList[i]["sourceDate"].toString();
        dailyPlanList.add(new DailySourcePlan(
            cargoCategoryText,
            customerName,
            expectedTotalTon,
            expectedTruckAmount,
            loadPlaceIdName,
            sourceDate,
            unloadPlaceIdName,
            id));
      }
      return new DataResult(dailyPlanList, true);
    }
    if (plans != null && !plans.result) {
      return new DataResult("到底了", false);
    }
  }

  ///请求刷新
  @override
  requestRefresh() {
    // TODO: implement requestRefresh
    //getMessagePush();
    skipCountGlobal = 5;
    print("查询参数： " +
        _dateBegin.toString() +
        "--" +
        _dateEnd.toString() +
        "--" +
        _loadPlaceId.toString() +
        "--" +
        _unloadPlaceId.toString());
    return _getData(
        _dateBegin, _dateEnd, _loadPlaceId, _unloadPlaceId, skipCountInit);
  }

  ///请求加载更多
  @override
  requestLoadMore() {
    // TODO: implement requestLoadMore
    var dataLoadMore = _getData(_dateBeginNext.trim(), _dateEndNext.trim(),
        _loadPlaceNextId, _unloadPlaceNextId, skipCountGlobal);
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
    //_getTransportPlaceData();
//    loadPlaceController.value = new TextEditingValue(text: "");
//    unloadPlaceController.value = new TextEditingValue(text: "");
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("每日货源计划查询"),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Padding(padding: EdgeInsets.all(2.0)),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: new OutlineButton(
                  child: new Padding(
                    padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: new Text(
                      _dateBegin == null
                          ? " 开始日期 "
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
                      _dateEnd == null
                          ? " 结束日期 "
                          : _dateEnd.toString().substring(0, 10),
                      style: CustomConstant.hintText),
                ),
                borderSide: new BorderSide(color: Colors.grey),
                onPressed: () => _showDatePickerEnd(),
              ))
            ],
          ),
          new Padding(padding: EdgeInsets.all(2.0)),
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
                    onPressed: () {
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
                    onPressed:
                        //() => showUnloadPlacePickerArray(context),
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
          new CustomFlexButton(
            color: Colors.blue,
            text: '查询',
            onPress: () {
              handleRefresh();
              _dateBeginNext = _dateBegin;
              _dateEndNext = _dateEnd;
              _loadPlaceNextId = _loadPlaceId;
              _unloadPlaceNextId = _unloadPlaceId;
            },
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

//  List<TransportPlace> _buildData() {
//    return [
//      TransportPlace(1, 0, "西召", "101"),
//    ];
//  }
//      new MaterialButton(
//        child: new Container(
//            decoration: new BoxDecoration(
//              color: Colors.white,
//              borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
//            ),
//            alignment: Alignment.center,
//            height: 36,
//            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
//            child: buildTextField(),
//        ),
//        onPressed: () {
//          // 调用函数打开
//          showDatePicker(
//            context: context,
//            initialDate: new DateTime.now(),
//            firstDate: new DateTime.now().subtract(new Duration(days: 30)), // 减 30 天
//            lastDate: new DateTime.now().add(new Duration(days: 30)),       // 加 30 天
//            locale: Locale('zh', 'CH'),
//          ).then((DateTime val) {
//            print(val);
//          }).catchError((err) {
//            print(err);
//          });
//        },
//      ),
//  Widget buildTextField() {
//    // theme设置局部主题
//    return Theme(
//      data: new ThemeData(primaryColor: Colors.grey),
//      child: new TextField(
//        cursorColor: Colors.grey, // 光标颜色
//        // 默认设置
//        decoration: InputDecoration(
//            contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
//            border: InputBorder.none,
//            //icon: Icon(Icons.search),
//            hintText: "日期选择",
//            hintStyle: new TextStyle(
//                fontSize: 14, color: Color.fromARGB(50, 0, 0, 0))),
//        style: new TextStyle(fontSize: 14, color: Colors.black),
//      ),
//    );
//  }

//                            return CustomPickDialog(
//                             );

//() => showLoadPlacePickerArray(context),
//                      (){
//                    NavigatorUtils.goLoadPlacePick(context, _buildData());
//                  }
}
