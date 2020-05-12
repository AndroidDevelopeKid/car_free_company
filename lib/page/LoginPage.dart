import 'dart:convert';

import 'package:car_free_company/blocs/login_bloc.dart';
import 'package:car_free_company/common/config/CompanyConfig.dart';
import 'package:car_free_company/common/config/Config.dart';
import 'package:car_free_company/common/dao/UserDao.dart';
import 'package:car_free_company/common/local/LocalStorage.dart';
import 'package:car_free_company/common/model/Tenant.dart';
import 'package:car_free_company/common/redux/CustomState.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/common/utils/CommonUtils.dart';
import 'package:car_free_company/common/utils/NavigatorUtils.dart';
import 'package:car_free_company/repositorys/user_repository.dart';
import 'package:car_free_company/widget/CustomDropDownWidget.dart';
import 'package:car_free_company/widget/CustomFlexButton.dart';
import 'package:car_free_company/widget/CustomInputWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'LoginForm.dart';

class LoginPage extends StatelessWidget {

  final UserRepository userRepository;
  LoginPage({Key key, @required this.userRepository}) : assert( userRepository != null ), super(key: key);


  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      behavior: HitTestBehavior.translucent,

      ///点击空白处触发弹出收回键盘事件
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false, //键盘弹出覆盖，不重新布局
        body: BlocProvider(
         create:(context){
           return LoginBloc(
             userRepository: userRepository
           );
         },
          child: LoginForm(),

        )
      ),
    );
  }
}
