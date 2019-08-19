
import 'package:car_free_company/common/dao/VehicleDao.dart';
import 'package:car_free_company/common/utils/CommonUtils.dart';
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
                  child:
                  new TextField(
                    textAlign: TextAlign.center,
                    onChanged: (String value) {
                      _vehicleSmall = value;
                    },
                    controller: vehicleSmallController,
                    decoration: InputDecoration(
                        hintText: '车辆小号',
                        contentPadding: EdgeInsets.all(8.0),
                        border:
                        OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor),)
                    ),
                  )
                  //buildTextField(_vehicleSmall, '车辆小号', vehicleSmallController)
              ),
            ],
          ),
          new Padding(padding: EdgeInsets.all(2.0)),
          new CustomFlexButton(
            color: Colors.blue,
            text: '取消排队',
            onPress: (){
              print("vehicleSmall:" + _vehicleSmall.toString());
              if(_vehicleSmall == null || _vehicleSmall.length == 0){
                return;
              }
              CommonUtils.showLoadingDialog(context);
              VehicleDao.setCancelQueue(_vehicleSmall.trim()).then((res){
                if(res != null && res.result){
                  //取消排队成功
                  CommonUtils.showShort("取消排队成功");
                }
                Navigator.pop(context);
                if(res != null && !res.result){
                  //CommonUtils.showShort(res.data['error']['message'].toString() + "-" + res.data["error"]["details"].toString());

                  if(res.data == null){
                    CommonUtils.showShort("访问异常");
                  }else{
                    CommonUtils.showShort(res.data["error"]["details"].toString());
                  }
                  return false;

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