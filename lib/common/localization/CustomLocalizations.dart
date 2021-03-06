import 'package:car_free_company/common/style/CustomStringBase.dart';
import 'package:car_free_company/common/style/CustomStringEn.dart';
import 'package:car_free_company/common/style/CustomStringZh.dart';
import 'package:flutter/material.dart';

///自定义本地化
class CustomLocalizations{

  final Locale locale;

  CustomLocalizations(this.locale);
  ///根据不同locale.languageCode加载不同语言对应
  ///CustomStringEn和CustomStringZh都继承了CustomStringBase
  static Map<String, CustomStringBase> _localizedValues = {
    'en': new CustomStringEn(),
    'zh': new CustomStringZh(),
  };
  CustomStringBase get currentLocalized{
    return _localizedValues[locale.languageCode];
  }
  ///通过Localizations 加载当前的 CustomLocalizations
  ///获取对应的CustomStringBase
  static CustomLocalizations of(BuildContext context){
    return Localizations.of(context, CustomLocalizations);
  }
}