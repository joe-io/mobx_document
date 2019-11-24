import 'dart:math';

import 'package:example_app/models/order.dart';
import 'package:example_app/models/order_document.dart';
import 'package:example_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class OrderSummary extends StatelessWidget {
  final Order order;

  const OrderSummary({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doc = Provider.of<OrderDocument>(context);

    return Observer(
      builder: (_) => Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Text(order.title),
              padding: EdgeInsets.all(50.0),
            ),
            Row(
              children: <Widget>[
                Spacer(),
                RaisedButton(
                  child: Text("Change Title"),
                  onPressed: () => doc.changeTitle(),
                ),
                Spacer(),
                RaisedButton(
                    child: Text("Add Products"),
                    onPressed: () {
                      doc.addProduct(Product()..title = "Hi");
                    }),
                Spacer(),
                RaisedButton(
                  child: Text("Undo (${doc.undoStack.length})"),
                  onPressed: () => doc.undo(),
                ),
                Spacer(),
                RaisedButton(
                  child: Text("Redo (${doc.redoStack.length})"),
                  onPressed: () => doc.redo(),
                ),
                Spacer(),
              ],
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Products (${order.products.length})",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  for (var product in order.products.sublist(0, min(10, order.products.length)))
                    Text("${product.title}"),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Undo Stack",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  for (var item in doc.undoStack)
                    Text("${item.name}: ${item.before['title']} : ${item.after['title']}"),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Redo Stack",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  for (var item in doc.redoStack)
                    Text("${item.name}: ${item.before['title']} : ${item.after['title']}"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
