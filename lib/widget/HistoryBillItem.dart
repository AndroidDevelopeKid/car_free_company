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
                    new Text(
                      historyBillItemViewModel.deliveryOrderStateText ?? "提货单状态",
                    ),
                  ],
                ),
                new Padding(padding: EdgeInsets.all(10.0)),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      historyBillItemViewModel.deliveryOrderCode ?? "提货单号",
                    ),
                    new Text(
                      historyBillItemViewModel.mainVehiclePlate ?? "车牌号",
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
  String id;
  String vehicleCode;//车辆编号
  String mainVehiclePlate;//车牌号
  String deliveryOrderCode;//提货单号
  String deliveryOrderStateText;//提货单状态
  String generateDate;//提货单生成日期
  String loadPlaceName;//装地-提货点
  String unloadPlaceName;//卸地-采购方
  String goodsName;//货物名-煤种
  String outStockGenerateDate;//提货点称重时间
  double outStockNetWeigh;//提货点净重
  String weighDate;//采购方称重时间
  String skinbackDate;//采购方回皮时间
  double inStockGrossWeigh;//采购方毛重
  double inStockNetWeigh;//采购方净重


  HistoryBillItemViewModel.fromMap(HistoryBill historyBill) {
    this.vehicleCode = historyBill.vehicleCode;
    this.deliveryOrderCode = historyBill.deliveryOrderCode;
    this.deliveryOrderStateText = historyBill.deliveryOrderStateText;
    this.generateDate = historyBill.generateDate;
    this.goodsName = historyBill.goodsName;
    this.id = historyBill.id;
    this.inStockGrossWeigh = historyBill.inStockGrossWeigh;
    this.inStockNetWeigh = historyBill.inStockNetWeigh;
    this.loadPlaceName = historyBill.loadPlaceName;
    this.mainVehiclePlate = historyBill.mainVehiclePlate;
    this.outStockGenerateDate = historyBill.outStockGenerateDate;
    this.outStockNetWeigh = historyBill.outStockNetWeigh;
    this.skinbackDate = historyBill.skinbackDate;
    this.unloadPlaceName = historyBill.unloadPlaceName;
    this.weighDate = historyBill.weighDate;

  }

}