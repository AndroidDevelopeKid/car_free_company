import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/widget/CustomFlexButton.dart';
import 'package:flutter/material.dart';

class CustomPickDialog extends Dialog {
  var placeData;
  Function onChooseEvent;
  CustomPickDialog({Key key, @required placeData, @required onChooseEvent}) : super(key: key);
  var items = ["地址1", "地址2", "地址2", "地址2", "地址2","地址1", "地址2", "地址2", "地址2", "地址2","地址1", "地址2", "地址2", "地址2", "地址2","地址1", "地址2", "地址2", "地址2", "地址2"];

  @override
  Widget build(BuildContext context) {
     //TODO: implement build
    return new Padding(
        padding: const EdgeInsets.fromLTRB(30.0,120.0,30.0,120.0),
        child: new Material(
          type: MaterialType.transparency,
          child: new Container(
              decoration: ShapeDecoration(
                  color: Color(0xFFFFFFFF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ))),
              margin: const EdgeInsets.all(12.0),
              child: new Column(children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                  child: new Container(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(5.0)),
                    ),
                    alignment: Alignment.center,
                    //height: 30,
                    //padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    child: buildTextField(),
                  ),
                ),
                new Expanded(
                    child: new ListView.builder(
                        itemCount: items.length * 2,
                        itemBuilder: (context, index) {
                           if (index.isOdd) {//是奇数
                             return new Divider( //返回分割线
                                 //height: 1.0,
                             );
                           } else {
                             index = index ~/ 2;
                             return new InkWell(
                                 child: new Center(child: new Text('${items[index]}', style: CustomConstant.placeTextBlack,)),
                                 onTap: this.onChooseEvent,
                                 );
                             //返回item 布局
                           }
                        })),
                new Padding(padding: const EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
                  child:
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new FlatButton(child: Text("上一级", style: TextStyle(color: Colors.blue),), onPressed: (){
                        //获取当前选中id，更新列表为选中id下级
                          },
                      ),
                      new FlatButton(child: Text("取消", style: TextStyle(color: Colors.blue),), onPressed: () => Navigator.pop(context),),

                      new FlatButton(child: Text("确定", style: TextStyle(color: Colors.blue),), onPressed: () {
                        //获取选中数据，退出当前widget，重绘上级widget

                      })
                    ],
                  ),
                )
              ])),
        ));
  }

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
}
