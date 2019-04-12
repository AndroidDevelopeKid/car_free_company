class Address{
  static const String host = "http://10.1.9.167/api/";
  static const String hostGit = "https://api.github.com/";
  static const String updateUrl = "";

  ///获取授权 post
  static getAuthorization(){
    return "${host}TokenAuth/Authenticate";
  }
}