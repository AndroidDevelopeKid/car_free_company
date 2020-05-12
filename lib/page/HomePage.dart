import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/local/LocalStorage.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/common/utils/CommonUtils.dart';
import 'package:car_free_company/page/HomeHomePage.dart';
import 'package:car_free_company/page/MyPage.dart';
import 'package:car_free_company/page/NoticePage.dart';
import 'package:car_free_company/widget/CustomTabBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class HomePage extends StatelessWidget{
  //static final String sName = "home";
  DateTime lastPopTime;
  _renderTab(icon, text){
    return new Tab(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 15.0,),
          Padding(padding: EdgeInsets.only(top: 1.5, bottom: 1.5),),
          Text(text, style: TextStyle(fontSize: 9.0),)],
      ),
    );
  }


  @override
  Widget build(BuildContext context){
    List<List<Widget>> tabsList = new List<List<Widget>>();
    List<Widget> tabs_0 = [
      _renderTab(CustomIcons.HOME_HOME_ON, "首页"),
      _renderTab(CustomIcons.HOME_MESSAGE, "通知"),
      _renderTab(CustomIcons.HOME_MY, "我的")
    ];
    List<Widget> tabs_1 = [
      _renderTab(CustomIcons.HOME_HOME, "首页"),
       _renderTab(CustomIcons.HOME_MESSAGE_ON, "通知"),
      _renderTab(CustomIcons.HOME_MY, "我的")
    ];
    List<Widget> tabs_2 = [
      _renderTab(CustomIcons.HOME_HOME, "首页"),
      _renderTab(CustomIcons.HOME_MESSAGE, "通知"),
      _renderTab(CustomIcons.HOME_MY_ON, "我的")
    ];
    tabsList.add(tabs_0);
    tabsList.add(tabs_1);
    tabsList.add(tabs_2);
    return WillPopScope(
      onWillPop: () async {
        if(lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: 2)){
          lastPopTime = DateTime.now();
          CommonUtils.showShort('再按一次退出');
          return false;
        }else{
          lastPopTime = DateTime.now();
          ///清空LocalStorage,退出app
          await LocalStorage.remove(Config.USER_ID);
          await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          return true;
        }
      },

      child: new CustomTabBarWidget(
        drawer: null,
        type: CustomTabBarWidget.BOTTOM_TAB,
        tabItemsList: tabsList,
        tabViews: [
          new HomeHomePage(),
          new NoticePage(),
          new MyPage()
        ],
        backgroundColor: Color(CustomColors.white),
        indicatorColor: Color(CustomColors.white),

        ),


    );
  }
}