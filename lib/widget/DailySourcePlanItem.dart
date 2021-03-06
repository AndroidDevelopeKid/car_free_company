import 'package:car_free_company/common/model/DailySourcePlan.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/widget/CustomCardItem.dart';
import 'package:flutter/material.dart';

class DailySourcePlanItem extends StatelessWidget {

  final DailySourcePlanItemViewModel dailySourcePlanItemViewModel;
  final VoidCallback onPressed;

  DailySourcePlanItem(this.dailySourcePlanItemViewModel,{this.onPressed}) : super();

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new CustomCardItem(
        child: new FlatButton(
          onPressed: onPressed,
          child:
          new Container(
            padding: const EdgeInsets.all(10.0),
            child: new Column(
              children: [
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Image.asset(CustomIcons.FORM),
                    new Text(
                      dailySourcePlanItemViewModel.sourceDate == null ? "无" : dailySourcePlanItemViewModel.sourceDate.substring(0,10),
                    ),
                  ],
                ),
                new Padding(padding: EdgeInsets.all(10.0)),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      dailySourcePlanItemViewModel.customerName ?? "客户" ,
                    ),
                    new Text(
                      dailySourcePlanItemViewModel.cargoCategoryText ?? "货物" ,
                    ),
                  ],),
              ],
            ),
          ),
        ),
      ),

    );
  }
}

class DailySourcePlanItemViewModel {
  ///客户
  String customerName;
  ///装地
  String loadPlaceIdName;
  ///卸地
  String unloadPlaceIdName;
  ///货物
  String cargoCategoryText;
  ///预计总吨数
  String expectedTotalTon;
  ///预计总车数
  String expectedTruckAmount;
  ///计划日期
  String sourceDate;

  DailySourcePlanItemViewModel.fromMap(DailySourcePlan dailySourcePlan) {
    customerName = dailySourcePlan.customerName;
    loadPlaceIdName = dailySourcePlan.loadPlaceIdName;
    unloadPlaceIdName = dailySourcePlan.unloadPlaceIdName;
    cargoCategoryText = dailySourcePlan.cargoCategoryText;
    expectedTotalTon = dailySourcePlan.expectedTotalTon;
    expectedTruckAmount = dailySourcePlan.expectedTruckAmount;
    sourceDate = dailySourcePlan.sourceDate;
  }


}