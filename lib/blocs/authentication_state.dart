import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable{
  const AuthenticationState();

  @override
  List<Object> get props => [];

}
///未初始化
class AuthenticationUninitialized extends AuthenticationState{}
///已授权
class AuthenticationAuthenticated extends AuthenticationState{}
///未授权
class AuthenticationUnauthenticated extends AuthenticationState{}
///授权加载中
class AuthenticationLoading extends AuthenticationState{}



