


import 'package:flutter/material.dart';

///全局Redux store 对象，保存state数据
class CustomState{

  ///语言
  Locale locale;
  ///当前手机平台默认语言
  Locale platformLocale;
  ///构造方法
  CustomState({this.locale});
}
///创建 Reducer
///源码中 Reducer 是一个方法 typedef State Reducer<State>(State state, dynamic action);
///我们自定义了 appReducer 用于创建 store
CustomState appReducer(CustomState state, action){
  return CustomState(


  );
}