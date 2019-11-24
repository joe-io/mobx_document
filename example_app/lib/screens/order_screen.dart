import 'package:example_app/components/order_summary.dart';
import 'package:example_app/models/order.dart';
import 'package:example_app/models/order_document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  final String title = "Orders";

  const OrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doc = OrderDocument(new Order(title: "First Order"));
    return Provider<OrderDocument>.value(
      value: doc,
      child: Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(title),
          ),
          body: Observer(
            builder: (_) => Center(
              child: OrderSummary(order: doc.root),
            ),
          )),
    );
  }
}
