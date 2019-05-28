import 'package:car_free_company/widget/CustomListState.dart';
import 'package:car_free_company/widget/HistoryBillItem.dart';
import 'package:flutter/material.dart';

abstract class BaseHistoryBillState<T extends StatefulWidget> extends State<T> with AutomaticKeepAliveClientMixin<T>, CustomListState<T>{
  ///渲染item
  @protected
  renderItem(index, VoidCallback refreshCallBack){
    return new HistoryBillItem(HistoryBillItemViewModel.fromMap(pullLoadWidgetControl.dataList[index]), onPressed: () async{
      //历史提货单不跳转详情，直接列表显示

    },);

  }

  @override
  bool get wantKeepAlive => true;

  @override
  bool get isRefreshFirst => true;

  @override
  bool get needHeader => false;

}