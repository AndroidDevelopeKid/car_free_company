import 'package:car_free_company/page/DriverDetailPage.dart';
import 'package:car_free_company/widget/CustomListState.dart';
import 'package:car_free_company/widget/CustomListStateWithParameter.dart';
import 'package:car_free_company/widget/DailySourcePlanItem.dart';
import 'package:car_free_company/widget/DriverItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BaseDriverState<T extends StatefulWidget> extends State<T> with AutomaticKeepAliveClientMixin<T>, CustomListState<T>{
  ///渲染item
  @protected
  renderItem(index, VoidCallback refreshCallBack){
    return new DriverItem(DriverItemViewModel.fromMap(pullLoadWidgetControl.dataList[index]), onPressed: () async{
      //司机跳转详情页，进行司机锁定，解锁，换车操作
      //跳转详情
      Navigator.push(context, new CupertinoPageRoute(builder: (context){
        return new DriverDetailPage(DriverItemViewModel.fromMap(pullLoadWidgetControl.dataList[index]));
      }));

    },);

  }

  @override
  bool get wantKeepAlive => false;

  @override
  bool get isRefreshFirst => false;

  @override
  bool get needHeader => false;


}