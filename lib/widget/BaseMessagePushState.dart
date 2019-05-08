
import 'package:car_free_company/common/dao/NoticeDao.dart';
import 'package:car_free_company/common/utils/CommonUtils.dart';
import 'package:car_free_company/page/MessageDetailPage.dart';
import 'package:car_free_company/widget/CustomListState.dart';
import 'package:car_free_company/widget/MessageItem.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

abstract class BaseMessagePushState<T extends StatefulWidget> extends State<T> with AutomaticKeepAliveClientMixin<T>, CustomListState<T>{
  ///定义消息推送的列表数组
  //final List<MessagePush> messagePushList = new List();

  ///渲染item
  @protected
  renderItem(index, VoidCallback refreshCallBack){
      return new MessageItem(MessageItemViewModel.fromMap(pullLoadWidgetControl.dataList[index]), onPressed: () async{
        //设置此消息为已读
        var res = await NoticeDao.makeNotificationAsRead(MessageItemViewModel.fromMap(pullLoadWidgetControl.dataList[index]).id);
        if(res != null && res.result){
          //跳转详情
          Navigator.push(context, new CupertinoPageRoute(builder: (context){
            return new MessageDetailPage(MessageItemViewModel.fromMap(pullLoadWidgetControl.dataList[index]));
          },
          ),).then((isRefresh){
            print("tiaozhuan shua xin: " + isRefresh.toString());
            if(isRefresh){
              handleRefresh();
            }
          }
          );

        }
        if(res != null && !res.result){
          CommonUtils.showShort("显示信息详情失败");
        }

      },);
//    }

  }

  @override
  bool get wantKeepAlive => true;

  @override
  bool get isRefreshFirst => true;

  @override
  bool get needHeader => true;



}