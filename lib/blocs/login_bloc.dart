
import 'package:bloc/bloc.dart';
import 'package:car_free_company/blocs/login_event.dart';
import 'package:car_free_company/repositorys/user_repository.dart';
import 'package:flutter/material.dart';

import 'authentication_bloc.dart';
import 'authentication_event.dart';
import 'login_state.dart';



class LoginBloc extends Bloc<LoginEvent, LoginState>{

  final UserRepository userRepository;

  LoginBloc({@required this.userRepository}) : assert(userRepository != null);

  @override
  // TODO: implement initialState
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // TODO: implement mapEventToState
    if(event is LoginButtonPressed){
      try{
        var res = await userRepository.authenticate(
            username : event.username,
            password : event.password,
            company : event.company);
        print("登录验证：" + res.data.toString());
        //authenticationBloc.add(LoginIn(result: res.result));

        yield LoginSuccess();
      }catch(error){
        LoginFailure(error: error.toString());

      }
    }


  }

}