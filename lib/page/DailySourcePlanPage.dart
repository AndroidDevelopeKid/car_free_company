import 'dart:convert';

import 'package:car_free_company/common/config/CompanyConfig.dart';
import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/widget/BaseDailySourcePlanState.dart';
import 'package:car_free_company/widget/CustomFlexButton.dart';
import 'package:car_free_company/widget/CustomPullLoadWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';

class DailySourcePlanPage extends StatefulWidget {
  static final String name = "DailySourcePlan";

  DailySourcePlanPage({Key key}) : super(key: key);

  _DailySourcePlanPage createState() => _DailySourcePlanPage();
}

class _DailySourcePlanPage extends BaseDailySourcePlanState<DailySourcePlanPage> {
  var _dateBegin;
  var _dateEnd;
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

  String _loadPlace = "";
  String _unloadPlace = "";
  final TextEditingController loadPlaceController = new TextEditingController();
  final TextEditingController unloadPlaceController = new TextEditingController();

  final CustomPullLoadWidgetControl pullLoadWidgetControl = new CustomPullLoadWidgetControl();

  _showDatePickerBegin() async {
    DateTime _picker = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now().subtract(new Duration(days: 3000)), // 减 30 天
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
      firstDate: new DateTime.now().subtract(new Duration(days: 3000)), // 减 30 天
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
          pickerdata: new JsonDecoder().convert(loadPlaceEnum),
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
        }
    ).showDialog(context);

  }
  ///卸地选择器
  showUnloadPlacePickerArray(BuildContext context) {
    new Picker(
        adapter: PickerDataAdapter<String>(
          pickerdata: new JsonDecoder().convert(unloadPlaceEnum),
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
        }
    ).showDialog(context);

  }
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
    loadPlaceController.value = new TextEditingValue(text: "");
    unloadPlaceController.value = new TextEditingValue(text: "");
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
    loadPlaceController.dispose();
    unloadPlaceController.dispose();
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
                  child: new Padding(padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child:new Text( _dateBegin == null
                      ? " 开始日期 "
                      : _dateBegin.toString().substring(0, 10),
                    style: CustomConstant.hintText,),
                  ),
                  color: Color(CustomColors.white),
                  borderSide: new BorderSide(color: Colors.grey),
                  onPressed: () => _showDatePickerBegin(),
                ),
              ),
              //new Text("-->"),
              new Padding(padding: EdgeInsets.all(5.0)),
              Expanded(
                child:
                new OutlineButton(
                  child: new Padding(padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: new Text(_dateEnd == null ? " 结束日期 " : _dateEnd.toString().substring(0, 10),
                    style: CustomConstant.hintText),
                  ),
                  borderSide: new BorderSide(color: Colors.grey),
                  onPressed: () => _showDatePickerEnd(),
                )
              )
            ],
          ),
          new Padding(padding: EdgeInsets.all(2.0)),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: new OutlineButton(
                  child: new Padding(padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child:new Text( _loadPlace == ""
                        ? " 装地 "
                        : _loadPlace,
                      style: CustomConstant.hintText,),
                  ),
                  color: Color(CustomColors.white),
                  borderSide: new BorderSide(color: Colors.grey),
                  onPressed: () => showLoadPlacePickerArray(context),
                ),
              ),
              new Padding(padding: EdgeInsets.all(5.0)),
              Expanded(
                child: new OutlineButton(
                  child: new Padding(padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child:new Text( _unloadPlace == ""
                        ? " 卸地 "
                        : _unloadPlace,
                      style: CustomConstant.hintText,),
                  ),
                  color: Color(CustomColors.white),
                  borderSide: new BorderSide(color: Colors.grey),
                  onPressed: () => showUnloadPlacePickerArray(context),
                ),
              ),
            ],
          ),
          new Padding(padding: EdgeInsets.all(2.0)),
          new CustomFlexButton(
            color: Colors.blue,
            text: '查询',
            onPress: ()=>{
              //获取到开始时间，结束时间，装地，卸地
              //DailySourcePlanDao

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
          OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor))
      ),
    );
  }
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

}
