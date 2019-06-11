import 'package:car_free_company/common/model/TransportPlace.dart';
import 'package:car_free_company/common/model/node.dart';
import 'package:car_free_company/common/model/organ.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/widget/CustomFlexButton.dart';
import 'package:car_free_company/widget/ImageText.dart';
import 'package:car_free_company/widget/SearchBar.dart';
import 'package:flutter/material.dart';

class LoadPlacePickPage extends StatefulWidget{
  static final String name = "LoadPlacePick";

  final List<TransportPlace> places;

  LoadPlacePickPage({Key key, this.places}) : super(key: key);

  _LoadPlacePickPage createState() => _LoadPlacePickPage();
}
class _LoadPlacePickPage extends State<LoadPlacePickPage>{
  ///保存所有数据的List
  List<Node> list = new List();
  ///保存当前展示数据的List
  List<Node> expand = new List();
  ///保存List的下标的List，用来做标记用
  List<int> mark = new List();
  ///第一个节点的index
  int nodeId = 1;
  ///展示搜索结构
  bool showSearch = false;
  List<Node> keep;

  @override
  void initState() {
    super.initState();
    //nodeId = 1;
    _parsePlaces(widget.places);
    _addRoot();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      //backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text("地点选择"),
      ),
      body: Column(
        children: <Widget>[
          SearchBar(list, _onSearch),
          Expanded(child: ListView(
            children: _buildNode(expand),
          ),),
        ],
      ),

    ));
  }

  ///搜索结果
  void _onSearch(List<Node> result){
    setState(() {
      if(result == null){ //如果为空，代表搜索关键字为空
        showSearch = false;
        expand = keep; //将之前保存的状态还原
      }else{
        if(!showSearch){ //如果之前展示的不是搜索的结果，保存状态，为了之后状态还原做准备
          keep = expand;
        }
        showSearch = true; //展示搜索结果
        expand = result;
      }
    });
  }

  ///如果解析的数据是一个list列表，采用这个方法
  void _parsePlaces(List<TransportPlace> places){
    for(TransportPlace place in places){
      _parsePlace(place);
    }
  }

  ///递归解析原始数据，将organ递归，记录其深度，nodeID和fatherID，将根节点的fatherID置为-1，
  ///保存原始数据为泛型T
  void _parsePlace(TransportPlace place, {int depth = 0, int fatherId = -1}) {
    int currentId = place.id;
//    list.add(Node(false, depth, Node.typeOrgan, nodeId++, fatherId, organ));
//
//    List<Node<Member>> members = new List();
//    if (organ.members != null) {
//      for (Member member in organ.members) {
//        members.add(Node(
//            false, depth + 1, Node.typeMember, nodeId++, currentId, member));
//      }
//    }
//    list.addAll(members);
//
//    if (organ.subOrgans != null) {
//      for (Organ organ in organ.subOrgans) {
//        _parseOrgan(organ, depth: depth + 1, fatherId: currentId);
//      }
//    }
  }

  ///扩展机构树：id代表被点击的机构id
  /// 做法是遍历整个list列表，将直接挂在该机构下面的节点增加到一个临时列表中，
  ///然后将临时列表插入到被点击的机构下面
  void _expand(int id) {
    //保存到临时列表
    List<Node> tmp = new List();
    for (Node node in list) {
      if (node.fatherId == id) {
        tmp.add(node);
      }
    }
    //找到插入点
    int index = -1;
    int length = expand.length;
    for(int i=0; i<length; i++){
      if(id == expand[i].nodeId){
        index = i+1;
        break;
      }
    }
    //插入
    expand.insertAll(index, tmp);
  }

  ///收起机构树：id代表被点击的机构id
  /// 做法是遍历整个expand列表，将直接和间接挂在该机构下面的节点标记，
  ///将这些被标记节点删除即可，此处用到的是将没有被标记的节点加入到新的列表中
  void _collect(int id){
    //清楚之前的标记
    mark.clear();
    //标记
    _mark(id);
    //重新对expand赋值
    List<Node> tmp = new List();
    for(Node node in expand){
      if(mark.indexOf(node.nodeId) < 0){
        tmp.add(node);
      }else{
        node.expand = false;
      }
    }
    expand.clear();
    expand.addAll(tmp);
  }

  ///标记，在收起机构树的时候用到
  void _mark(int id) {
    for (Node node in expand) {
      if (id == node.fatherId) {
        if (node.type == Node.typeOrgan) {
          _mark(node.nodeId);
        }
        mark.add(node.nodeId);
      }
    }
  }

  ///增加根
  void _addRoot() {
    for (Node node in list) {
      if (node.fatherId == -1) {
        expand.add(node);
      }
    }
  }

  ///构建元素
  List<Widget> _buildNode(List<Node> nodes) {
    List<Widget> widgets = List();
    if (nodes != null && nodes.length > 0) {
      for (Node node in nodes) {
        widgets.add(GestureDetector(
          child:
          ImageText(
            node.type == Node.typeOrgan
                ? node.expand ? CustomIcons.PARENT_TRANSPORT_PLACE : CustomIcons.PARENT_TRANSPORT_PLACE
                : CustomIcons.TRANSPORT_PLACE,
            node.type == Node.typeOrgan ? (node.object as Organ).text : (node.object as Member).text,
            padding: showSearch ? 0 : node.depth * 20.0, //如果展示搜索结果，那么不缩进
          ),
          onTap: (){
            if(node.type == Node.typeOrgan){
              if(node.expand){ //之前是扩展状态，收起列表
                node.expand = false;
                _collect(node.nodeId);
              }else{ //之前是收起状态，扩展列表
                node.expand = true;
                _expand(node.nodeId);
              }
              setState(() {
              });
            }
          },
        ));
      }
    }
    return widgets;
  }
//  final List<String> items = ["地址1", "地址2","地址2","地址2","地址2"];
//  Widget buildTextField() {
//    // theme设置局部主题
//    return Theme(
//      data: new ThemeData(primaryColor: Colors.grey),
//      child: new TextField(
//        cursorColor: Colors.grey, // 光标颜色
//        // 默认设置
//        decoration: InputDecoration(
//            contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
//            border: InputBorder.none,
//            icon: Icon(Icons.search),
//            hintText: "搜索 装地",
//            hintStyle: new TextStyle(
//                fontSize: 16, color: Color.fromARGB(50, 0, 0, 0))),
//                style: new TextStyle(fontSize: 16, color: Colors.black),
//      ),
//    );
//  }
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return new Scaffold(
//        backgroundColor: CustomColors.listBackground,
//        appBar: new AppBar(
//          title: new Text("装地选择"),
//        ),
//        body:
//        new Column(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            new Padding(padding: EdgeInsets.all(2.0)),
//            new Container(
//              decoration: new BoxDecoration(
//                color: Colors.white,
//                borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
//              ),
//              alignment: Alignment.center,
//              height: 46,
//              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
//              child: buildTextField(),
//            ),
//            new Padding(padding: EdgeInsets.all(2.0)),
//            new CustomFlexButton(text: '返回上一级',
//              onPress: (){
//              //记录当前id，作为下次显示的parentId
//              },
//            ),
//            new Padding(padding: EdgeInsets.all(2.0)),
//            Expanded(
//                child:
//                new ListView.builder(
//                  itemCount: items.length,
//                    itemExtent: 46,
//                    itemBuilder: (context, index) {
//                      return new ListTile(
//                        title: new Text('${items[index]}'),
//                      );
//                    })
//            )
//          ],
//        ),
//
//    );
//  }
}