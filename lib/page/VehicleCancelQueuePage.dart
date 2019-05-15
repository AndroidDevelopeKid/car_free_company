
import 'package:car_free_company/widget/CustomFlexButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class VehicleCancelQueuePage extends StatefulWidget{
  static final String name = "VehicleCancelQueue";

  VehicleCancelQueuePage({Key key}) : super(key: key);

  _VehicleCancelQueuePage createState() => _VehicleCancelQueuePage();
}

class _VehicleCancelQueuePage extends State<VehicleCancelQueuePage> {
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
        title: new Text("取消排队"),
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
            text: '取消排队',
            onPress: ()=>{
              //获取到开始时间，结束时间，装地，卸地
              //VehicleDao

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