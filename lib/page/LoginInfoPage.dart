import 'package:car_free_company/common/model/LoginInfo.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:car_free_company/common/local/LocalStorage.dart';
import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/dao/UserDao.dart';
import 'dart:convert';

class LoginInfoPage extends StatefulWidget{
  static final String name = "LoginInfo";

  LoginInfoPage({Key key}) : super(key: key);

  _LoginInfoPage createState() => _LoginInfoPage();
}
class _LoginInfoPage extends State<LoginInfoPage>{


  ///*********************异步获取数据进行页面显示****************************
  Future<LoginInfo> loginInfo;


  Future<LoginInfo> fetchData() async {
    var loginInfoLS = await LocalStorage.get(Config.LOGIN_INFO);
    if(loginInfoLS == null){
      var userId = await LocalStorage.get(Config.USER_ID);
      var resultDataLoginInfo = await UserDao.getLoginInfo();
      return resultDataLoginInfo.data;
    }else{
      LoginInfo loginInfoData = LoginInfo.fromJson(json.decode(loginInfoLS));
      return loginInfoData;
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginInfo = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: CustomColors.listBackground,
      appBar: new AppBar(
        title: new Text("登陆信息"),
      ),
      body:
      new Card(
        color: Color(CustomColors.displayCardBackground),
        //margin: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0, bottom: 30),
        margin: EdgeInsets.only(top: 6.0, bottom: 6.0, left: 4.0, right: 4.0),
        elevation: 8.0,
        child: new Container(
          child: FutureBuilder<LoginInfo>(
            future: loginInfo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //return Text(snapshot.data.vehicleCode);
                return new Table(
                  border: TableBorder.all(color: Color(CustomColors.tableBorderColor), width: 2.0, style: BorderStyle.solid),
                  children: <TableRow>[
                    TableRow(
                        children: <Widget>[
                          Text("用户名：", style: CustomConstant.normalTextBlack),
                          Text(snapshot.data.userName == null ? "无" : snapshot.data.userName, style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("姓名：", style: CustomConstant.normalTextBlack),
                          Text(snapshot.data.name == null ? "无" : snapshot.data.name, style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("电话号码：", style: CustomConstant.normalTextBlack),
                          Text(snapshot.data.phoneNumber == null ? "无" : snapshot.data.phoneNumber, style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("所属组织编码：", style: CustomConstant.normalTextBlack),
                          Text(snapshot.data.orgCode == null ? "无" : snapshot.data.orgCode, style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("所属组织简称：", style: CustomConstant.normalTextBlack),
                          Text(snapshot.data.orgAbbreviation == null ? "无" : snapshot.data.orgAbbreviation, style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("所属组织全称：", style: CustomConstant.normalTextBlack),
                          Text(snapshot.data.orgFullName == null ? "无" : snapshot.data.orgFullName, style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("上级组织：", style: CustomConstant.normalTextBlack),
                          Text(snapshot.data.higherLevelOrg == null ? "无" : snapshot.data.higherLevelOrg, style: CustomConstant.normalTextBlack),
                        ]
                    ),
                    TableRow(
                        children: <Widget>[
                          Text("组织类型：", style: CustomConstant.normalTextBlack),
                          Text(snapshot.data.orgType == null ? "无" : snapshot.data.orgType, style: CustomConstant.normalTextBlack),
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