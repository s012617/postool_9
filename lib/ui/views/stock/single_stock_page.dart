import 'package:flutter/material.dart';
import 'package:postool_9/enums/view_state.dart';
import 'package:postool_9/model/purchase.dart';
import 'package:postool_9/scope_model/stock_model.dart';
import 'package:postool_9/ui/shared/bar_code_scan_view.dart';
import 'package:postool_9/ui/shared/pruduct_list_tile.dart';
import 'package:postool_9/ui/views/stock/stock_tile.dart';
import 'package:postool_9/ui/views/widgets/busy_overlay.dart';
import 'package:postool_9/utils/barcode_scanner.dart';
import '../base_view.dart';

class SingleStock extends StatefulWidget {
  @override
  _SingleStockState createState() => _SingleStockState();
}

class _SingleStockState extends State<SingleStock> {
  StockModel _model;

  @override
  Widget build(BuildContext context) {
    return BaseView<StockModel>(
      builder: (context, child, model) {
        _model = model;
        return BusyOverlay(
          show: _model.state == ViewState.Busy,
          title: '查詢中...',
          child: _buildSingleStockView(),
        );
      },
    );
  }

  Widget _buildSingleStockView() => ListView(
        children: <Widget>[
          BarCodeView("庫存 條碼 掃描", _model),
          PruductTile(PurchaseData(_model.barCode, 0)),
          ..._buildBodyList(),
        ],
      );

  List _buildBodyList() {
    List<StockTile> _list = [];
    _model.stockList.forEach((it) => _list.add(StockTile(it)));
    return _list;
  }
}
