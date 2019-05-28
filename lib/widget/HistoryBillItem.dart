import 'package:car_free_company/common/model/HistoryBill.dart';
import 'package:car_free_company/common/style/CustomStyle.dart';
import 'package:car_free_company/widget/CustomCardItem.dart';
import 'package:flutter/material.dart';

class HistoryBillItem extends StatelessWidget{
  final HistoryBillItemViewModel historyBillItemViewModel;
  final VoidCallback onPressed;

  HistoryBillItem(this.historyBillItemViewModel,{this.onPressed}) : super();

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new CustomCardItem(
        child: new FlatButton(
          onPressed: onPressed,
          child:
          new Container(
            padding: const EdgeInsets.all(10.0),
            child: new Column(
              children: [
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Image.asset(CustomIcons.HISTORY_BILL_SUB),
                    new Text(''
                      //vehicleItemViewModel.vehicleCode ?? "车辆编号",
                    ),
                  ],
                ),
                new Padding(padding: EdgeInsets.all(10.0)),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(''
                      //vehicleItemViewModel.vehicleStateText ?? "车辆状态",
                    ),
                    new Text(''
                      //vehicleItemViewModel.mainVehiclePlate ?? "车牌号",
                    ),
                  ],),
              ],
            ),
          ),
        ),
      ),

    );
  }
}

class HistoryBillItemViewModel {


  HistoryBillItemViewModel.fromMap(HistoryBill historyBill) {

  }

}