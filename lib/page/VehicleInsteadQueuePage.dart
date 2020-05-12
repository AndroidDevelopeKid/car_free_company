import 'package:car_free_company/common/dao/VehicleDao.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/common/utils/CommonUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class VehicleInsteadQueuePage extends StatefulWidget {
  static final String name = "VehicleInsteadQueue";

  VehicleInsteadQueuePage({Key key}) : super(key: key);

  _VehicleInsteadQueuePage createState() => _VehicleInsteadQueuePage();
}

class _VehicleInsteadQueuePage extends State<VehicleInsteadQueuePage> {
  String _vehicleSmall = "";
  final TextEditingController vehicleSmallController =
      new TextEditingController();

  @override
  void initState() {
    super.initState();
    vehicleSmallController.value = new TextEditingValue(text: "");
  }

  @override
  void dispose() {
    vehicleSmallController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              iconSize: 15.0,
              icon: Icon(CustomIcons.BACK, color: Color(0xff4C88FF)),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Text("车辆代排队",
              style: TextStyle(fontSize: 18.0, color: Colors.black)),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                textAlign: TextAlign.center,
                onChanged: (String value) {
                  _vehicleSmall = value;
                },
                controller: vehicleSmallController,
                decoration: InputDecoration(
                    hintText: '车辆小号',
                    contentPadding: EdgeInsets.all(8.0),
                  enabledBorder:
                  OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(
                            0xff82ACFF)),
                  ),
                  focusedBorder:
                  OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(
                            0xff82ACFF)),
                  ),
                  border:
                  OutlineInputBorder(),
                    ),
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              FlatButton(
                color: Color(0xff45C950),
                child: Padding(padding: EdgeInsets.only(top: 37.0, bottom: 37.0),child:Text('代排队', style: TextStyle(color: Colors.white, fontSize: 15.0),),),
                onPressed: () {
                  //VehicleDao
                  print("vehicleSmall:" + _vehicleSmall.toString());
                  if (_vehicleSmall == null || _vehicleSmall.length == 0) {
                    return;
                  }

                  CommonUtils.showLoadingDialog(context);
                  VehicleDao.setReplaceQueue(_vehicleSmall.trim()).then((res) {
                    if (res != null && res.result) {
                      //代排队成功
                      CommonUtils.showShort("代排队成功");
                    }
                    Navigator.pop(context);
                    if (res != null && !res.result) {
                      if (res.data == null) {
                        CommonUtils.showShort("访问异常");
                      } else {
                        CommonUtils.showShort(
                            res.data["error"]["details"].toString());
                      }
                      return false;
                    }
                    return true;
                  });
                },
              ),
            ],
          ),
        ));
  }
}
