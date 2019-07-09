


import 'package:car_free_company/common/dao/DailySourcePlanDao.dart';
import 'package:car_free_company/common/model/DailySourcePlan.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/common/utils/CommonUtils.dart';
import 'package:car_free_company/widget/CustomFlexButton.dart';
import 'package:car_free_company/widget/DailySourcePlanItem.dart';
import 'package:car_free_company/widget/DailySourcePlanItem.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

class DailySourcePlanDetailPage extends StatefulWidget{
  static final String name = "dailySourcePlanDetail";

  final DailySourcePlanItemViewModel model;

  DailySourcePlanDetailPage(this.model, {Key key}) : super(key:key);

  _DailySourcePlanDetailPage createState() => _DailySourcePlanDetailPage(model);
}

class _DailySourcePlanDetailPage extends State<DailySourcePlanDetailPage>{

  final DailySourcePlanItemViewModel model;
  _DailySourcePlanDetailPage(this.model);


  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        //resizeToAvoidBottomPadding: false, //键盘弹出覆盖，不重新布局
          backgroundColor: CustomColors.listBackground,
          appBar: new AppBar(
            title: new Text("货源日计划详情"),
          ),

          body:new SingleChildScrollView(child: new Card(
            color: Color(CustomColors.displayCardBackground),
            //margin: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0, bottom: 30),
            margin: EdgeInsets.only(top: 6.0, bottom: 6.0, left: 4.0, right: 4.0),
            elevation: 8.0,
            child: new Container(
              child:new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //new Expanded(child:
                  new Table(
                    border: TableBorder.all(color: Color(CustomColors.tableBorderColor), width: 2.0, style: BorderStyle.solid),
                    children:
                    <TableRow>[
                      TableRow(
                          children: <Widget>[
                            Text("客户：", style: CustomConstant.normalTextBlack),
                            Text(model.customerName ?? "无", style: CustomConstant.normalTextBlack),
                          ]
                      ),
                      TableRow(
                          children: <Widget>[
                            Text("装地：", style: CustomConstant.normalTextBlack),
                            Text(model.loadPlaceIdName ?? "无", style: CustomConstant.normalTextBlack),
                          ]
                      ),
                      TableRow(
                          children: <Widget>[
                            Text("卸地：", style: CustomConstant.normalTextBlack),
                            Text(model.unloadPlaceIdName ?? "无", style: CustomConstant.normalTextBlack),
                          ]
                      ),
                      TableRow(
                          children: <Widget>[
                            Text("货物：", style: CustomConstant.normalTextBlack),
                            Text(model.cargoCategoryText ?? "无", style: CustomConstant.normalTextBlack),
                          ]
                      ),
                      TableRow(
                          children: <Widget>[
                            Text("预计总吨数：", style: CustomConstant.normalTextBlack),
                            Text(model.expectedTotalTon ?? "无", style: CustomConstant.normalTextBlack),
                          ]
                      ),
                      TableRow(
                          children: <Widget>[
                            Text("预计总车数：", style: CustomConstant.normalTextBlack),
                            Text(model.expectedTruckAmount ?? "无", style: CustomConstant.normalTextBlack),
                          ]
                      ),
                      TableRow(
                          children: <Widget>[
                            Text("计划时间：", style: CustomConstant.normalTextBlack),
                            Text(model.sourceDate ?? "无", style: CustomConstant.normalTextBlack),
                          ]
                      ),

                    ],
                  ),



                ],
              ),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: CustomColors.listBackground,
                  width: 0.7,
                  style: BorderStyle.solid,
                ),
              ),
              padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
            ),

          ),)


      ),
      onWillPop: _onBack,
    );
  }
  Future<bool> _onBack(){
    try{}catch(e){}finally{}
    Navigator.pop(context, true);
    return Future.value(false);
  }
}