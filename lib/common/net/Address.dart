import 'package:car_free_company/common/config/Config.dart';

class Address{
  static const String host = "http://10.1.9.167/api/";
  static const String hostGit = "https://api.github.com/";
  static const String updateUrl = "";

  ///获取授权 post
  static getAuthorization(){
    return "${host}TokenAuth/Authenticate";
  }
  ///获取分页后的通知
  static getPagedUserNotifications(){
    return "${host}services/app/Notifications/GetPagedUserNotificationsAsync";
  }
  ///设置所有消息为已读--post
  static makeAllUserNotificationsAsRead(){
    return "${host}services/app/Notifications/MakeAllUserNotificationsAsRead";
  }
  ///设置单条信息为已读--post
  static makeNotificationAsRead(){
    return "${host}services/app/Notifications/MakeNotificationAsRead";
  }

  ///个人设置
  static getPersonalSettings(){
    return "${host}services/app/User/GetUserByMobile";
  }
  ///我的登陆信息
  static getLoginInformation(){
    return "${host}services/app/User/GetUserOrganizationUnit";
  }
  ///车辆锁定
  static setVehicleLocking(){
    return "${host}services/app/VehicleArchives/ToStopVehicleArchives";
  }
  ///车辆解锁
  static setVehicleUnlocking(){
    return "${host}services/app/VehicleArchives/ToNomanlVehicleArchives";
  }
  ///司机锁定
  static setDriverLocking(){
    return "${host}services/app/VehicleDriverArchive/TempStopVehicleDriverArchive";
  }
  ///司机解锁
  static setDriverUnlocking(){
    return "${host}services/app/VehicleDriverArchive/ReturnVehicleDriverArchive";
  }
  ///车辆查询
  static getVehicleQuery(){
    return "${host}services/app/VehicleArchives/GetVehicleArchivess";
  }
  ///司机查询
  static getDriverQuery(){
    return "${host}services/app/VehicleDriverArchive/GetVehicleDriverArchives";
  }

  ///仓release get
  static getReposRelease(reposOwner, reposName) {
    return "${hostGit}repos/$reposOwner/$reposName/releases";
  }

  ///仓Tag get
  static getReposTag(reposOwner, reposName) {
    return "${hostGit}repos/$reposOwner/$reposName/tags";
  }
  ///处理分页参数
  static getPageParams(tab, page, [pageSize = Config.PAGE_SIZE]){
    if(page != null){
      if(pageSize != null){
        return "${tab}page=$page&per_page=$pageSize";
      }else{
        return "${tab}page=$page";
      }
    }else{
      return "";
    }
  }
}