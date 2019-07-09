import 'package:car_free_company/page/DailySourcePlanDetailPage.dart';
import 'package:car_free_company/widget/CustomListState.dart';
import 'package:car_free_company/widget/DailySourcePlanItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BaseDailySourcePlanState<T extends StatefulWidget> extends State<T> with AutomaticKeepAliveClientMixin<T>, CustomListState<T>{
  ///渲染item
  @protected
  renderItem(index, VoidCallback refreshCallBack){
    return new DailySourcePlanItem(DailySourcePlanItemViewModel.fromMap(pullLoadWidgetControl.dataList[index]), onPressed: () async{
     //日计划跳转详情
      //跳转详情
      Navigator.push(context, new CupertinoPageRoute(builder: (context){
        return new DailySourcePlanDetailPage(DailySourcePlanItemViewModel.fromMap(pullLoadWidgetControl.dataList[index]));
      }));

    },);

  }

  @override
  bool get wantKeepAlive => true;

  @override
  bool get isRefreshFirst => false;

  @override
  bool get needHeader => false;


}