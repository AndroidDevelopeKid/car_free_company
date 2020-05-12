import 'package:car_free_company/blocs/login_bloc.dart';
import 'package:car_free_company/blocs/login_event.dart';
import 'package:car_free_company/blocs/login_state.dart';
import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/dao/UserDao.dart';
import 'package:car_free_company/common/local/LocalStorage.dart';
import 'package:car_free_company/common/model/Tenant.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/common/utils/CommonUtils.dart';
import 'package:car_free_company/common/utils/NavigatorUtils.dart';
import 'package:car_free_company/widget/CustomDropDownWidget.dart';
import 'package:car_free_company/widget/CustomFlexButton.dart';
import 'package:car_free_company/widget/CustomInputWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'CompanyPage.dart';

class LoginForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginFormState();
  }

}

class _LoginFormState extends State<LoginForm>{
  ///物流公司，用户名和密码
  Tenant tenant;
  String _companyText;
  var _userName;
  var _password;


  final TextEditingController userController = new TextEditingController();
  final TextEditingController pwController = new TextEditingController();

  ///构造方法
  _LoginFormState() : super();
//
//  Future<List<Tenant>> tenants;
//
//  Future<List<Tenant>> fetchData(skipCount) async {
//    final List<Tenant> tenantList = new List();
//    var tenants = await UserDao.getTenants(100, skipCount);
//
//    if (tenants.data != null && tenants.result) {
//      var itemList = tenants.data["result"]["items"];
//      print("tenants's itemList: " +
//          itemList.toString() +
//          itemList.length.toString());
//      print("tenants itemList length: " + itemList.length.toString());
//      for (int i = 0; i < itemList.length; i++) {
//        var id = itemList[i]["id"];
//        var tenancyName = itemList[i]["tenancyName"];
//        var name = itemList[i]["name"];
//        var isActive = itemList[i]["isActive"];
//        tenantList.add(new Tenant(isActive, id, name, tenancyName));
//      }
//      return tenantList;
//    }
//  }
  @override
  void initState() {
    super.initState();
    initParams();
  }

  @override
  void dispose() {
    userController.dispose();
    pwController.dispose();
    super.dispose();
  }
  initParams() async {
    _userName = await LocalStorage.get(Config.USER_NAME_KEY)??"";
    _password = await LocalStorage.get(Config.PW_KEY)??"";
    _companyText = await LocalStorage.get(Config.TENANT_KEY_NAME)??"选择物流公司";
    setState(() {});
    print("company text :" + _companyText);
    var res = await LocalStorage.get(Config.TENANT_KEY)??"";
    if(res != ""){
      print("res int:" + res);
      tenant = new Tenant(null, int.parse(res), "", "");
    }
    userController.value = new TextEditingValue(text: _userName ?? "");
    pwController.value = new TextEditingValue(text: _password ?? "");
  }

//  void _onCompanySelected(String value) {
//    setState(() => _company = value);
//  }

  DecorationImage loginBackgroundImage = new DecorationImage(
    image: AssetImage(CustomIcons.LOGIN_BACKGROUND),
    fit: BoxFit.fill,
  );

  @override
  Widget build(BuildContext context) {

    _onLoginButtonPressed(){
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          username: userController.text,
          password: pwController.text,
          company: _companyText,

        ),
      );
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,

      ///点击空白处触发弹出收回键盘事件
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child:
      BlocListener<LoginBloc, LoginState>(
        listener: (context, state){
          if(state is LoginFailure){
            CommonUtils.showShort("登录失败");
          }

        },
        child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state){
              return
                Container(
                  decoration: new BoxDecoration(
                    image: loginBackgroundImage,
//渐变色
//                  gradient: new LinearGradient(
//                      colors: [Color(0xffFFFFFF), Color(0xff0872EA)],
//                      begin: Alignment.topLeft,
//                      end: Alignment.bottomRight)
                  ),
                  //color: Theme.of(context).primaryColor
                  child:
                    Padding(padding: EdgeInsets.only(left: 39.0, top: 271.0, right: 35.0),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            //跳转页面选择物流公司
                            Navigator.push<Tenant>(context, new MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return CompanyPage();
                                })).then((Tenant t) {
                              if (t != null) {
                                LocalStorage.save(Config.TENANT_KEY, t.id.toString());
                                LocalStorage.save(Config.TENANT_KEY_NAME, t.name);
                                _companyText = t.name;
                                setState(() {
                                  tenant = t;
                                });
                              }
                            });
                          },
                          child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.0),
                              child: Text(
                                _companyText??"选择物流公司",
                                style: TextStyle(
                                    fontSize: 17.0, color: Colors.white),
                              )),
                          color: Color(0xffB4CDFF),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 39.0, right: 35.0, top: 5.0, bottom: 5.0),
                        ),
                        TextField(
                          controller: userController,
                          onChanged: (String value){
                            _userName = value;
                          },
                          decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 19.0),
                              fillColor: Color(0xffF0F3FF),
                              filled: true,
                              border: InputBorder.none,
                              hintText: "用户名",
                              prefixIcon: Icon(
                                CustomIcons.USER_NAME,
                                color: Color(0xff4C88FF),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 39.0, right: 35.0, top: 5.0, bottom: 5.0),
                        ),
                        TextField(
                          obscureText: true,
                          controller: pwController,
                          onChanged: (String value){
                            _password = value;
                          },
                          decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 19.0),
                              fillColor: Color(0xffF0F3FF),
                              filled: true,
                              border: InputBorder.none,
                              hintText: "密码",
                              prefixIcon: Icon(
                                CustomIcons.PASSWORD,
                                color: Color(0xff4C88FF),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 39.0, right: 35.0, top: 13.5, bottom: 13.5),
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          onPressed: () async {
                            print("bug: " + _userName.toString() + "--" + _password.toString());
                            if (tenant == null) {
                              CommonUtils.showShort("请先选择物流公司！");
                              return false;
                            }
                            if (_userName == null || _userName.length == 0) {
                              CommonUtils.showShort("用户名或密码不可为空！");
                              return false;
                            }
                            if (_password == null || _password.length == 0) {
                              CommonUtils.showShort("用户名或密码不可为空！");
                              return false;
                            }

                            CommonUtils.showLoadingDialog(context);
                            var res = await UserDao.login(tenant.id.toString().trim(),
                                _userName.trim(), _password.trim());
                            if (res != null && res.result) {
                              new Future.delayed(const Duration(seconds: 1), () {
                                NavigatorUtils.goHome(context);
                                return true;
                              });
                            }
                            Navigator.pop(context);

                            if (!res.result) {
                              if (Config.DEBUG) {
                                print("返回结果：" + res.data.toString());
                              }
                              CommonUtils.showShort("登录失败 用户名密码错误！");
                            }
                            return true;
                          },
                          child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.0),
                              child: Text(
                                "登录",
                                style: TextStyle(
                                    fontSize: 17.0, color: Colors.white),
                              )),
                          color: Color(0xff4C88FF),
                        ),
                      ],
                    )
                    )
//                  new Center(
//                      child: FutureBuilder<List<Tenant>>(
//                          future: tenants,
//                          builder: (context, snapshot) {
//                            if (snapshot.hasData) {
//
//                              List<String> tArray = List();
//                              List<int> tIdArray = List();
//                              for (int i = 0; i < snapshot.data.length; i++) {
//                                tArray.insert(i, snapshot.data[i].name);
//                                tIdArray.insert(i, snapshot.data[i].id);
//                              }
//                              if (_company == null) {
//                                _company = tArray[0];
//                              }
//                              return new Card(
//                                ///阴影大小，默认2.0
//                                elevation: 5.0,
//                                shape: new RoundedRectangleBorder(
//                                    borderRadius:
//                                    BorderRadius.all(Radius.circular(10.0))),
//
//                                ///背景色
//                                color: Color(CustomColors.cardWhite),
//                                margin: const EdgeInsets.only(left: 50.0, right: 50.0),
//                                child: new Padding(
//                                  padding: new EdgeInsets.only(
//                                      left: 30.0, top: 10.0, right: 30.0, bottom: 0.0),
//                                  child: new Column(
//                                    ///主轴方向上的对齐方式，默认start，center是将children放置在主轴中心
//                                    mainAxisAlignment: MainAxisAlignment.center,
//
//                                    ///在主轴方向占有空间的值，默认是max，最大化主轴方向的可用空间，min相反
//                                    mainAxisSize: MainAxisSize.min,
//                                    children: <Widget>[
//                                      //new Image.asset(CustomIcons.DEFAULT_USER_ICON, width: 80.0, height: 80.0),
//
//                                      new Padding(padding: new EdgeInsets.all(10.0)),
//                                      new CustomDropDownWidget(
//                                        items: tArray,
//                                        value: _company,
//                                        onChanged: _onCompanySelected,
//                                        isExpanded: true,
//                                      ),
//                                      new Padding(padding: new EdgeInsets.all(10.0)),
//                                      new CustomInputWidget(
//                                        hintText: "用户名",
//                                        iconData: CustomIcons.LOGIN_USER,
//                                        onChanged: (String value) {
//                                          _userName = value;
//                                        },
//                                        controller: userController,
//                                      ),
//                                      new Padding(padding: new EdgeInsets.all(10.0)),
//                                      new CustomInputWidget(
//                                        hintText: "密码",
//                                        iconData: CustomIcons.LOGIN_PW,
//                                        obscureText: true,
//                                        onChanged: (String value) {
//                                          _password = value;
//                                        },
//                                        controller: pwController,
//                                      ),
//                                      new Padding(padding: new EdgeInsets.all(25.0)),
//                                      new CustomFlexButton(
//                                        text: "登录",
//                                        color: Theme.of(context).primaryColor,
//                                        textColor: Color(CustomColors.textWhite),
//                                        onPress: () async {
//                                          if (_company == null ||
//                                              _company.length == 0) {
//                                            return;
//                                          }
//                                          if (_userName == null ||
//                                              _userName.length == 0) {
//                                            return;
//                                          }
//                                          if (_password == null ||
//                                              _password.length == 0) {
//                                            return;
//                                          }
//                                          int id;
//                                          for (int i = 0; i < tArray.length; i++) {
//                                            if (_company == tArray[i]) {
//                                              id = tIdArray[i];
//                                            }
//                                          }
//                                          CommonUtils.showLoadingDialog(context);
//
//                                          UserDao.login(id.toString().trim(),
//                                              _userName.trim(), _password.trim())
//                                              .then((res) {
//                                            if (res != null && res.result) {
//                                              new Future.delayed(
//                                                  const Duration(seconds: 1), () {
//                                                NavigatorUtils.goHome(context);
//                                              });
//                                            }
//                                            Navigator.pop(context);
//                                            if (!res.result) {
//                                              if (res.data == null) {
//                                                CommonUtils.showShort("访问异常");
//                                              } else {
//                                                CommonUtils.showShort(res.data["error"]
//                                                ["details"]
//                                                    .toString());
//                                              }
//                                            }
//                                          });
//
//                                        },
//                                      ),
//                                      new Padding(padding: new EdgeInsets.all(20.0)),
//                                    ],
//                                  ),
//                                ),
//                              );
//                            } else if (snapshot.hasError) {
//                              return Text("${snapshot.error}");
//                            }
//                            return CircularProgressIndicator();
//                          })),
                );
            }
        ),
      ));

    // TODO: implement build

  }

}