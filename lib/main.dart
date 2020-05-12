
import 'package:car_free_company/page/HomePage.dart';
import 'package:car_free_company/page/LoginPage.dart';
import 'package:car_free_company/repositorys/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication_bloc.dart';
import 'blocs/authentication_event.dart';
import 'blocs/authentication_state.dart';
import 'blocs/bloc_delegate.dart';
import 'package:bloc/bloc.dart';

void main(){
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();
  runApp(
      BlocProvider<AuthenticationBloc>(create: (context){
        return AuthenticationBloc(userRepository: userRepository)
            ..add(AppStarted());

  },
      child: MyApp(userRepository: userRepository),
  )
  );
  PaintingBinding.instance.imageCache.maximumSize = 100;//缓存张数，最大100
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  // 强制竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
}

class MyApp extends StatelessWidget {

  final UserRepository userRepository;
  MyApp({Key key, @required this.userRepository}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
           MaterialApp(
             debugShowCheckedModeBanner: false,
             home:
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state){
                  if(state is AuthenticationAuthenticated){
                    return HomePage();
                  }
                  if(state is AuthenticationUnauthenticated){
                    return LoginPage(userRepository: userRepository);
                  }
                  return null;
                }),
          );
  }
}