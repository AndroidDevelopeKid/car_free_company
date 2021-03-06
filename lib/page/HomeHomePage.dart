import 'dart:async';

import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/dao/NoticeDao.dart';
import 'package:car_free_company/common/dao/ReposDao.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/common/utils/CommonUtils.dart';
import 'package:car_free_company/common/utils/NavigatorUtils.dart';
import 'package:car_free_company/widget/BannerItemFactory.dart';
import 'package:car_free_company/widget/Pair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:banner_view/banner_view.dart';

class HomeHomePage extends StatefulWidget {
  @override
  _HomeHomePageState createState() => _HomeHomePageState();
}

class _HomeHomePageState extends State<HomeHomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  //var platform = MethodChannel('message.io/notice');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //检查版本更新
    //ReposDao.getNewsVersion(context, false);
    //初始化本地通知
    var initializationSettingsAndroid = new AndroidInitializationSettings('icon_msg');
    //var initializationSettingsIOS = new IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, null);
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: null); //onSelectNotification
    var timer = new Timer.periodic(const Duration(seconds: 60), (Void) async {
      //这里调用消息接口
      var notifications = await NoticeDao.getPagedUserNotifications(0, 0);
      if (notifications != null &&
          notifications.result &&
          notifications.data["result"]["unreadCount"] != 0) {
        //有未读消息，提示
        _showNotification();
      }

      print("timer notifications: " + notifications.data.toString());
    });
  }
  Future onDidRecieveLocalNotification(
      int id, String title, String body, String payload) async {
    // 展示通知内容的 dialog.
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text(title),
        content: new Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: new Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
            },
          )
        ],
      ),
    );
  }
//  Future onSelectNotification(String payload) async {
//    if (payload != null) {
//      debugPrint('notification payload: ' + payload);
//    }
//    //payload 可作为通知的一个标记，区分点击的通知。
//    if(payload != null && payload == "complete") {
//      await Navigator.push(
//        context,
//        new MaterialPageRoute(builder: (context) => new NoticePage()),
//      );
//    }
//  }
  Future _showNotification() async {
    //安卓的通知配置，必填参数是渠道id, 名称, 和描述, 可选填通知的图标，重要度等等。
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    //IOS的通知配置
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    //显示通知，其中 0 代表通知的 id，用于区分通知。
    await flutterLocalNotificationsPlugin
        .show(0, '您有新的消息', '', platformChannelSpecifics, payload: 'complete');
  }

  //删除单个通知
  Future _cancelNotification() async {
    //参数 0 为需要删除的通知的id
    await flutterLocalNotificationsPlugin.cancel(0);
  }

//删除所有通知
  Future _cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  BannerView _bannerView(){
    // 盛放图片的 List
    List<Pair<String, Color>> param = [
      Pair.create(CustomIcons.BANNER, null),
      ];

    return new BannerView(
      BannerItemFactory.banners(param),
      intervalDuration: new Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 15.0, top: 30.0, bottom: 9.0),
          child: SizedBox(height: 20.0, child:Image.asset(CustomIcons.LOGO),),
        ),
         Container(
          height: 185.0,
          child: this._bannerView(),
          padding: EdgeInsets.all(10.0),
        ),
        Expanded(child: new GridView.count(
          crossAxisCount: 4,
          padding: EdgeInsets.all(20.0),
          children: _buildWidgetList(),
        ),
        )
      ],),
    );
  }

  List<Widget> _buildWidgetList() {
    List<Widget> widgetList = new List();
    widgetList.add(
      new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            child: new IconButton(
              icon: new Image.asset(CustomIcons.HISTORY_BILL),
              iconSize: Config.ICON_SIZE,
              //new Icon(CustomIcons.HISTORY_BILL, size: Config.ICON_SIZE),
              onPressed: () {
                NavigatorUtils.goHistoryBill(context);
              },
              tooltip: "历史提货单",
              //padding: EdgeInsets.only(right: Config.ICON_RIGHT_PADDING),
            ),
          ),
          new Text("历史提货单", style: TextStyle(fontSize: 12.0,), overflow: TextOverflow.fade,),
        ],
      ),
    );
    widgetList.add(
      new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            child: new IconButton(
              icon: new Image.asset(CustomIcons.FREIGHT_QUERY),
              iconSize: Config.ICON_SIZE,
              //new Icon(CustomIcons.FREIGHT_INQUIRY, size: Config.ICON_SIZE),
              onPressed: () {
                CommonUtils.showShort("敬请期待...");
                //NavigatorUtils.goDailySourcePlan(context);
              },
              tooltip: "货源计划",
              //padding: EdgeInsets.only(right: Config.ICON_RIGHT_PADDING),
            ),
          ),
          new Text("货源计划", style: TextStyle(fontSize: 12.0,), overflow: TextOverflow.fade,),
        ],
      ),
    );
    widgetList.add(
      new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            child: new IconButton(
              icon: new Image.asset(CustomIcons.DRIVER),
              iconSize: Config.ICON_SIZE,
              //new Icon(CustomIcons.REFUEL_INQUIRY, size: Config.ICON_SIZE),
              onPressed: () {
                //CommonUtils.showShort("敬请期待...");
                NavigatorUtils.goDriver(context);
              },
              tooltip: "司机查询",
              //padding: EdgeInsets.only(right: Config.ICON_RIGHT_PADDING),
            ),
          ),
          new Text("司机查询", style: TextStyle(fontSize: 12.0,), overflow: TextOverflow.fade,),
        ],
      ),
    );
    widgetList.add(
      new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            child: new IconButton(
              icon: new Image.asset(CustomIcons.VEHICLE_QUERY),
              iconSize: Config.ICON_SIZE,
              //new Icon(CustomIcons.TOLL_INQUIRY, size: Config.ICON_SIZE),
              onPressed: () {
                //CommonUtils.showShort("敬请期待...");
                NavigatorUtils.goVehicle(context);
              },
              tooltip: "车辆查询",
              //padding: EdgeInsets.only(right: Config.ICON_RIGHT_PADDING),
            ),
          ),
          new Text("车辆查询", style: TextStyle(fontSize: 12.0,), overflow: TextOverflow.fade,),
        ],
      ),
    );
    widgetList.add(
      new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            child: new IconButton(
              icon: new Image.asset(CustomIcons.SEND_BILL_EXCEPTION),
              iconSize: Config.ICON_SIZE,
              //new Icon(CustomIcons.MAINTENANCE_FEE_INQUIRY, size: Config.ICON_SIZE),
              onPressed: () {
                CommonUtils.showShort("敬请期待...");
                //NavigatorUtils.goMaintenanceFeeInquiry(context);
              },
              tooltip: "派单异常处理",
              //padding: EdgeInsets.only(right: Config.ICON_RIGHT_PADDING),
            ),
          ),
          new Text("派单异常处理", style: TextStyle(fontSize: 12.0,), overflow: TextOverflow.fade,),
        ],
      ),
    );
    widgetList.add(
      new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            child: new IconButton(
              icon: new Image.asset(CustomIcons.CUSTOMER),
              iconSize: Config.ICON_SIZE,
              //new Icon(CustomIcons.OTHER_COST_INQUIRY, size: Config.ICON_SIZE),
              onPressed: () {
                //CommonUtils.showShort("敬请期待...");
                NavigatorUtils.goVehicleInsteadQueue(context);
              },
              tooltip: "车辆代排队",
              //padding: EdgeInsets.only(right: Config.ICON_RIGHT_PADDING),
            ),
          ),
          new Text("车辆代排队", style: TextStyle(fontSize: 12.0,), overflow: TextOverflow.fade,),
        ],
      ),
    );
    widgetList.add(
      new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            child: new IconButton(
              icon: new Image.asset(CustomIcons.CANCEL),
              iconSize: Config.ICON_SIZE,
              //new Icon(CustomIcons.CURRENT_ASSIGN_CUSTOMER, size: Config.ICON_SIZE),
              onPressed: () {
                //CommonUtils.showShort("敬请期待...");
                NavigatorUtils.goVehicleCancelQueue(context);
              },
              tooltip: "取消排队",
              //padding: EdgeInsets.only(right: Config.ICON_RIGHT_PADDING),
            ),
          ),
          new Text("取消排队", style: TextStyle(fontSize: 12.0,), overflow: TextOverflow.fade,),
        ],
      ),
    );
    return widgetList;
  }
}
