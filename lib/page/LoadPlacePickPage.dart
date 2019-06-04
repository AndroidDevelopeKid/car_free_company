import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/widget/CustomFlexButton.dart';
import 'package:flutter/material.dart';

class LoadPlacePickPage extends StatefulWidget{
  static final String name = "LoadPlacePick";

  LoadPlacePickPage({Key key}) : super(key: key);

  _LoadPlacePickPage createState() => _LoadPlacePickPage();
}
class _LoadPlacePickPage extends State<LoadPlacePickPage>{
  final List<String> items = ["地址1", "地址2","地址2","地址2","地址2"];
  Widget buildTextField() {
    // theme设置局部主题
    return Theme(
      data: new ThemeData(primaryColor: Colors.grey),
      child: new TextField(
        cursorColor: Colors.grey, // 光标颜色
        // 默认设置
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
            border: InputBorder.none,
            icon: Icon(Icons.search),
            hintText: "搜索 装地",
            hintStyle: new TextStyle(
                fontSize: 16, color: Color.fromARGB(50, 0, 0, 0))),
                style: new TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        backgroundColor: CustomColors.listBackground,
        appBar: new AppBar(
          title: new Text("装地选择"),
        ),
        body:
        new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Padding(padding: EdgeInsets.all(2.0)),
            new Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
              ),
              alignment: Alignment.center,
              height: 46,
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: buildTextField(),
            ),
            new Padding(padding: EdgeInsets.all(2.0)),
            new CustomFlexButton(text: '返回上一级',
              onPress: (){
              //记录当前id，作为下次显示的parentId
              },
            ),
            new Padding(padding: EdgeInsets.all(2.0)),
            Expanded(
                child:
                new ListView.builder(
                  itemCount: items.length,
                    itemExtent: 46,
                    itemBuilder: (context, index) {
                      return new ListTile(
                        title: new Text('${items[index]}'),
                      );
                    })
            )
          ],
        ),

    );
  }
}