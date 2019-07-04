import 'package:car_free_company/common/dao/VehicleDao.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/common/utils/CommonUtils.dart';
import 'package:car_free_company/widget/CustomFlexButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class VehicleInsteadQueuePage extends StatefulWidget{
  static final String name = "VehicleInsteadQueue";

  VehicleInsteadQueuePage({Key key}) : super(key: key);

  _VehicleInsteadQueuePage createState() => _VehicleInsteadQueuePage();
}

class _VehicleInsteadQueuePage extends State<VehicleInsteadQueuePage> {
  String _vehicleSmall = "";
  final TextEditingController vehicleSmallController = new TextEditingController();
  @override
  void initState(){
    super.initState();
    vehicleSmallController.value = new TextEditingValue(text: "");
  }
  @override
  void dispose(){
    vehicleSmallController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("车辆代排队"),
      ),

      body:new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Padding(padding: EdgeInsets.all(2.0)),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                  child: buildTextField(_vehicleSmall, '车辆小号', vehicleSmallController)
              ),
            ],
          ),
          new Padding(padding: EdgeInsets.all(2.0)),
          new CustomFlexButton(
            color: Colors.blue,
            text: '代排队',
            onPress: (){
              //VehicleDao
              if(_vehicleSmall == null || _vehicleSmall.length == 0){
                return;
              }
              CommonUtils.showLoadingDialog(context);
              VehicleDao.setReplaceQueue(_vehicleSmall.trim()).then((res){
                if(res != null && res.result){
                  //代排队成功
                  CommonUtils.showShort("代排队成功");
                }
                if(res != null && !res.result){
                  CommonUtils.showShort(res.data['error']['message'].toString() + "-" + res.data["error"]["details"].toString());
                }
              });

            },
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String data,String text, TextEditingController controller) {
    return TextField(
      textAlign: TextAlign.center,
      onChanged: (String value) {
        data = value;
      },
      controller: controller,
      decoration: InputDecoration(
          hintText: text,
          contentPadding: EdgeInsets.all(10.0),
          border:
          OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor),)
      ),
    );
  }
}