import 'package:car_free_company/common/net/Address.dart';
import 'package:car_free_company/common/net/HttpApi.dart';
import 'package:car_free_company/repositorys/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{

  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository}) : assert(userRepository != null);


  @override
  // TODO: implement initialState
  AuthenticationState get initialState => AuthenticationUnauthenticated();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    // TODO: implement mapEventToState
    if(event is AppStarted){
      //获取登录状态，判断是否登录状态，如果是登录状态则结果为已授权，不是登录状态则为未授权
      ///登陆信息
      var res = await HttpManager.netFetch(Address.getTenant() + "?MaxResultCount=100&SkipCount=0", null, null, null);
      print("getTenants result :" + res.toString());

    }

    if(event is LoginIn){

    }
  }


}