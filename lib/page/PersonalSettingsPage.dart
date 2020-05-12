import 'package:car_free_company/common/model/User.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/widget/CustomErrorReturnWidget.dart';
import 'package:car_free_company/widget/CustomTableRowWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:car_free_company/common/local/LocalStorage.dart';
import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/dao/UserDao.dart';
import 'dart:convert';

class PersonalSettingsPage extends StatefulWidget {
  static final String name = "PersonalSettings";

  PersonalSettingsPage({Key key}) : super(key: key);

  _PersonalSettingsPage createState() => _PersonalSettingsPage();
}

class _PersonalSettingsPage extends State<PersonalSettingsPage> {
  ///*********************异步获取数据进行页面显示****************************
  Future<User> userInfo;

  Future<User> fetchData() async {
    var userInfoLS = await LocalStorage.get(Config.USER_INFO);
    if (userInfoLS == null) {
      var userId = await LocalStorage.get(Config.USER_ID);
      var resultDataUserInfo = await UserDao.getPersonalSettings(userId);
      if (resultDataUserInfo.data == null) {
        var dataNull =
            new User(null, null, null, null, null, null, null, null, null);
        return dataNull;
      }
      if (resultDataUserInfo.data != null && !resultDataUserInfo.result) {
        var dataNull =
            new User(null, null, null, null, null, null, null, null, null);
        return dataNull;
      }
      return resultDataUserInfo.data;
    } else {
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            iconSize: 15.0,
            icon: Icon(CustomIcons.BACK, color: Color(0xff4C88FF)),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title:
            Text("个人设置", style: TextStyle(fontSize: 18.0, color: Colors.black)),
      ),
      body: FutureBuilder<User>(
        future: userInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //return Text(snapshot.data.vehicleCode);
            return Container(
              child: Padding(
                  padding: EdgeInsets.only(
                      top: 15.0, left: 25.0, right: 25.0, bottom: 15.0),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      TableRow(children: <Widget>[
                        CustomTableRowWidget(
                            "用户名", snapshot.data.userName ?? "无"),
                      ]),
                      TableRow(children: <Widget>[
                        CustomTableRowWidget(
                            "全称", snapshot.data.fullName ?? "无"),
                      ]),
                      TableRow(children: <Widget>[
                        CustomTableRowWidget(
                            "电话号码", snapshot.data.phoneNumber ?? "无"),
                      ]),
                      TableRow(children: <Widget>[
                        CustomTableRowWidget(
                            "所属组织机构编码", snapshot.data.organizationCode ?? "无"),
                      ]),
                      TableRow(children: <Widget>[
                        CustomTableRowWidget("所属组织机构名称",
                            snapshot.data.organizationDisplayName ?? "无"),
                      ]),
                      TableRow(children: <Widget>[
                        CustomTableRowWidget("所属组织机构全称",
                            snapshot.data.organizationFullName ?? "无"),
                      ]),
                      TableRow(children: <Widget>[
                        CustomTableRowWidget("所属组织机构类型",
                            snapshot.data.organizationTypeText ?? "无"),
                      ]),
                    ],
                  )),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                border: Border.all(
                  color: Color(0xffF9FBFF),
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return CustomErrorReturnWidget();
          }
          return SizedBox(height: 2.0, child: LinearProgressIndicator());
        },
      ),
    );
  }
}
