import 'package:car_free_company/page/HistoryBillDetailPage.dart';
import 'package:car_free_company/widget/CustomListState.dart';
import 'package:car_free_company/widget/HistoryBillItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BaseHistoryBillState<T extends StatefulWidget> extends State<T> with AutomaticKeepAliveClientMixin<T>, CustomListState<T>{
  ///渲染item
  @protected
  renderItem(index, VoidCallback refreshCallBack){
    return new HistoryBillItem(HistoryBillItemViewModel.fromMap(pullLoadWidgetControl.dataList[index]), onPressed: () async{
      //历史提货单跳转详情
      //跳转详情
      Navigator.push(context, new CupertinoPageRoute(builder: (context){
        return new HistoryBillDetailPage(HistoryBillItemViewModel.fromMap(pullLoadWidgetControl.dataList[index]));
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