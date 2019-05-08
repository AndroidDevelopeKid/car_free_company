import 'package:car_free_company/common/style/CustomStringBase.dart';

class CustomStringEn extends CustomStringBase{
  @override
  String loginText = "Login";

  @override
  String loadingText = "Loading...";

  @override
  String loadMoreText = "Load More";

  @override
  String appEmpty = "Empty";

  ///登录时联网出错提醒
  @override
  String networkError = "network error";
  @override
  String networkError_401 = "Http 401";
  @override
  String networkError_403 = "Http 403";
  @override
  String networkError_404 = "Http 404";
  @override
  String networkErrorTimeout = "Http timeout";
  @override
  String networkErrorUnknown = "Http unknown error";

  ///登录
  @override
  String loginUsernameHintText = "username";
  @override
  String loginPasswordHintText = "password";

  ///主页tab
  @override
  String homehome = "Home";
  @override
  String homeNotice = "Notice";
  @override
  String homeMy = "My";
}