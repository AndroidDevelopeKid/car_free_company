import 'dart:async';

import 'package:car_free_company/common/event/HttpErrorEvent.dart';
import 'package:car_free_company/common/localization/CustomLocalizationsDelegate.dart';
import 'package:car_free_company/common/net/Code.dart';
import 'package:car_free_company/common/redux/CustomState.dart';
import 'package:car_free_company/common/utils/CommonUtils.dart';
import 'package:car_free_company/page/HomePage.dart';
import 'package:car_free_company/page/LoginPage.dart';
import 'package:car_free_company/page/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_picker/PickerLocalizationsDelegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main(){
  runApp(new FlutterReduxApp());
  PaintingBinding.instance.imageCache.maximumSize = 100;//缓存张数，最大100
}

class FlutterReduxApp extends StatelessWidget {

  FlutterReduxApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
          new MaterialApp(
            ///多语言实现代理
            localizationsDelegates: [
              PickerLocalizationsDelegate.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              CustomLocalizationsDelegate.delegate,
            ],
            supportedLocales: [Locale('zh', 'CH')],
            locale: Locale('zh', 'CH'),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
            ),
            ///路由，声明程序中有哪个通过Navigation.of(context).pushNamed跳转的路由
            ///参数以键值对的形式传递
            ///key：路由名字
            ///value：对应的Widget
            initialRoute: "login",
            routes: {
//              WelcomePage.sName: (context){
//                return WelcomePage();
//              },
              HomePage.sName: (context){
                return new CustomLocalizations(
                  child: new HomePage(),
                );
              },
              LoginPage.sName: (context){
                return new CustomLocalizations(
                  child: new LoginPage(),
                );
              }
            },
          );

  }
}

class CustomLocalizations extends StatefulWidget {
  final Widget child;
  CustomLocalizations({Key key, this.child}) : super(key: key);

  @override
  _CustomLocalizationsState createState() => _CustomLocalizationsState();
}

class _CustomLocalizationsState extends State<CustomLocalizations> {
  StreamSubscription stream;

  @override
  void initState() {
    super.initState();
    stream = Code.eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }
  @override
  Widget build(BuildContext context) {
      return new Localizations.override(
        context: context,
        locale: Locale('zh', 'CH'),
        child: widget.child,
      );
  }


  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
  }

  errorHandleFunction(int code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        Fluttertoast.showToast(msg: CommonUtils
            .getLocale(context)
            .networkError);
        break;
      case 401:
        Fluttertoast.showToast(msg: CommonUtils
            .getLocale(context)
            .networkError_401);
        break;
      case 403:
        Fluttertoast.showToast(msg: CommonUtils
            .getLocale(context)
            .networkError_403);
        break;
      case 404:
        Fluttertoast.showToast(msg: CommonUtils
            .getLocale(context)
            .networkError_404);
        break;
      case Code.NETWORK_TIMEOUT:
      //超时
        Fluttertoast.showToast(msg: CommonUtils
            .getLocale(context)
            .networkErrorTimeout);
        break;
      default:
        Fluttertoast.showToast(msg: CommonUtils
            .getLocale(context)
            .networkErrorUnknown + " " + message);
        break;
    }
  }
}
