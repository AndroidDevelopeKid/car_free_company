import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthenticationEvent extends Equatable{
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent{}

class LoginIn extends AuthenticationEvent{
  final bool result;

  const LoginIn({@required this.result});

  @override
  List<Object> get props => [result];

  @override
  String toString() {
    // TODO: implement toString
    return 'LoginIn { result: $result }';
  }
}

class LoginOut extends AuthenticationEvent{}