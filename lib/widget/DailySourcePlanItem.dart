import 'package:car_free_company/common/model/DailySourcePlan.dart';
import 'package:car_free_company/common/model/MessagePush.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/widget/CustomCardItem.dart';
import 'package:common_utils/common_utils.dart';
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
                    new Image.asset(CustomIcons.DAILY_PLAN_IMAGE),
                    new Text(
                      dailySourcePlanItemViewModel.planDate == null ? "0000-00-00" : dailySourcePlanItemViewModel.planDate.substring(0,10),
                    ),
                  ],
                ),
                new Padding(padding: EdgeInsets.all(10.0)),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      dailySourcePlanItemViewModel.loadPlace == null ? "装地" : dailySourcePlanItemViewModel.loadPlace,
                    ),
                    new Text(
                      dailySourcePlanItemViewModel.unloadPlace == null ? "卸地" : dailySourcePlanItemViewModel.unloadPlace,
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
  String customer;
  String loadPlace;
  String unloadPlace;
  String goods;
  String estimatedTotalTon;
  String estimatedTotalVehicles;
  String planDate;

  DailySourcePlanItemViewModel.fromMap(DailySourcePlan dailySourcePlan) {
    customer = dailySourcePlan.customer;
    loadPlace = dailySourcePlan.loadPlace;
    unloadPlace = dailySourcePlan.unloadPlace;
    goods = dailySourcePlan.goods;
    estimatedTotalTon = dailySourcePlan.estimatedTotalTon;
    estimatedTotalVehicles = dailySourcePlan.estimatedTotalVehicles;
    planDate = dailySourcePlan.planDate;
  }


}