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
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10.0,
                            top: 15.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 13.0,
                                height: 14.0,
                                child: Image.asset(CustomIcons.FORM),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Text(
                                  historyBillItemViewModel.mainVehiclePlate ??
                                      "车牌号",
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, top: 13.0),
                          child: Text(
                            historyBillItemViewModel.deliveryOrderCode ??
                                "提货单号",
                            style: TextStyle(fontSize: 13.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 26.0),
                    child: Text(
                      historyBillItemViewModel.deliveryOrderStateText ??
                          "提货单状态",
                      style:
                      TextStyle(color: Color(0xff5AC426), fontSize: 13.0),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 9.0, bottom: 9.0),
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            border: Border.all(
              color: Color(0xffefefef),
              width: 1.0,
              style: BorderStyle.solid,
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
  String coalCode;
  String coalText;//煤种
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
    this.coalCode = historyBill.coalCode;
    this.coalText = historyBill.coalText;
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