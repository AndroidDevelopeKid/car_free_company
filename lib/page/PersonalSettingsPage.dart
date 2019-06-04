import 'package:car_free_company/common/model/LoginInfo.dart';
import 'package:car_free_company/common/model/User.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:car_free_company/common/local/LocalStorage.dart';
import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/dao/UserDao.dart';
import 'dart:convert';

class PersonalSettingsPage extends StatefulWidget{
  static final String name = "PersonalSettings";

  PersonalSettingsPage({Key key}) : super(key: key);

  _PersonalSettingsPage createState() => _PersonalSettingsPage();
}
class _PersonalSettingsPage extends State<PersonalSettingsPage>{


  ///*********************异步获取数据进行页面显示****************************
  Future<User> userInfo;


  Future<User> fetchData() async {
    var userInfoLS = await LocalStorage.get(Config.USER_INFO);
    if(userInfoLS == null){
      var userId = await LocalStorage.get(Config.USER_ID);
      var resultDataUserInfo = await UserDao.getPersonalSettings(userId);
      if(resultDataUserInfo.data == null){
        var dataNull = new User("无", "无", "无", "无", "无", "无", 0, false, "无", "无");
        return dataNull;
      }else{
        return resultDataUserInfo.data;
      }

    }else{
      User userInfoData = User.fromJson(json.decode(userInfoLS));
      return userInfoData;
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userInfo = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: CustomColors.listBackground,
      appBar: new AppBar(
        title: new Text("个人设置"),
      ),
      body:
      new Card(
        color: Color(CustomColors.displayCardBackground),
        //margin: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0, bottom: 30),
        margin: EdgeInsets.only(top: 6.0, bottom: 6.0, left: 4.0, right: 4.0),
        elevation: 8.0,
        child: new Container(
          child: FutureBuilder<User>(
            future: userInfo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //return Text(snapshot.data.vehicleCode);
                return new Table(
                  border: TableBorder.all(color: Color(CustomColors.tableBorderColor), width: 2.0, style: BorderStyle.solid),
                  children: <TableRow>[
                    TableRow(
                        children: <Widget>[
                          Text("用户名：", style: CustomConstant.normalTextBlack),
                          Text(snapshot.data.userName ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("全称：", style: CustomConstant.normalTextBlack),
                          Text(snapshot.data.fullName ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("电子邮件：", style: CustomConstant.normalTextBlack),
                          Text(snapshot.data.emailAddress ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("电话号码：", style: CustomConstant.normalTextBlack),
                          Text(snapshot.data.phoneNumber ?? "无", style: CustomConstant.normalTextBlack),
                        ]
                    ),


                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: CustomColors.listBackground,
              width: 0.7,
              style: BorderStyle.solid,
            ),
          ),
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
        ),

      ),
    );

  }
}