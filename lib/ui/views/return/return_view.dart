import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:postool_9/model/purchase.dart';
import 'package:postool_9/scope_model/return_model.dart';
import 'package:postool_9/ui/shared/bar_code_scan_view.dart';
import 'package:postool_9/ui/shared/page_app_bar.dart';
import 'package:postool_9/ui/shared/pruduct_list_tile.dart';
import 'package:intl/intl.dart';

import '../base_view.dart';

class Return extends StatefulWidget {
  @override
  _ReturnState createState() => _ReturnState();
}

class _ReturnState extends State<Return> {
  ReturnViewModel _model;

  @override
  Widget build(BuildContext context) {
    String _today = DateFormat('yyyy/MM/dd').format(DateTime.now());
    return BaseView<ReturnViewModel>(
      builder: (context, child, model) {
        _model = model;
        return Scaffold(
          appBar: PageAppBar("退貨系統  $_today"),
          body: _buildReturnView(context),
        );
      },
    );
  }

  Widget _buildReturnView(BuildContext context) => ListView(
        children: <Widget>[
          BarCodeView("退貨 條碼 掃描", _model),
          ..._buildBodyList(),
          _confirmButton(context),
        ],
      );

  List _buildBodyList() {
    List _list = _model.productList
        .map((e) => _slidableListTile(e, _model.productList.indexOf(e)))
        .toList();
    return _list;
  }

  Widget _slidableListTile(PurchaseData data, int index) => Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.2,
        secondaryActions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
            child: IconSlideAction(
              caption: '刪除',
              color: Colors.red,
              icon: Icons.delete_outline,
              onTap: () => _model.deleteSlidablelistTile(index),
            ),
          ),
        ],
        child: PruductTile(data),
      );

  Widget _confirmButton(BuildContext context) => Padding(
        padding: const EdgeInsets.all(32.0),
        child: Container(
          width: 300,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.orange[900],
            borderRadius: BorderRadius.circular(20),
          ),
          child: FlatButton(
            onPressed: () => _model.confirmOnTap(context),
            child: Text(
              "退貨確認",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      );
}
