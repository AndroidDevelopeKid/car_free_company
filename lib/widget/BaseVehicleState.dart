import 'package:car_free_company/page/VehicleDetailPage.dart';
import 'package:car_free_company/widget/CustomListState.dart';
import 'package:car_free_company/widget/VehicleItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BaseVehicleState<T extends StatefulWidget> extends State<T> with AutomaticKeepAliveClientMixin<T>, CustomListState<T>{
  ///渲染item
  @protected
  renderItem(index, VoidCallback refreshCallBack){
    return new VehicleItem(VehicleItemViewModel.fromMap(pullLoadWidgetControl.dataList[index]), onPressed: () async{
      //跳转车辆界面，显示详情
      Navigator.push(context, new CupertinoPageRoute(builder: (context){
        return new VehicleDetailPage(VehicleItemViewModel.fromMap(pullLoadWidgetControl.dataList[index]));
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