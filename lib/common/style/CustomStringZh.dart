import 'package:car_free_company/common/style/CustomStringBase.dart';

class CustomStringZh extends CustomStringBase{
  @override
  String loginText = "登录";

  @override
  String loadingText = "加载中...";

  @override
  String loadMoreText = "加载更多";

  @override
  String appEmpty = "什么也没有";

  ///登录时联网出错提醒
  @override
  String networkError = "网络错误";
  @override
  String networkError_401 = "401错误可能: 未授权 \\ 授权登录失败 \\ 登录过期";
  @override
  String networkError_403 = "403权限错误";
  @override
  String networkError_404 = "404错误";
  @override
  String networkErrorTimeout = "请求超时";
  @override
  String networkErrorUnknown = "其他异常:";

  ///登录
  @override
  String loginUsernameHintText = "用户名";
  @override
  String loginPasswordHintText = "密码";

  ///主页tab
  @override
  String homeHome = "首页";
  @override
  String homeNotice = "消息";
  @override
  String homeMy = "我的";
}