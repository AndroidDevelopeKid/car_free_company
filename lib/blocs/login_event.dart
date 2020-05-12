import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable{
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent{

  final String username;
  final String password;
  final String company;

  const LoginButtonPressed({
    @required this.username,
    @required this.password,
    @required this.company
  });
  @override
  // TODO: implement props
  List<Object> get props => [username, password, company];

  @override
  String toString() {
    // TODO: implement toString
    return 'LoginButtonPressed { username: $username, password: $password, company: $company}';
  }

}