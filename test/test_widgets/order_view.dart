import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../models/order_document.dart';
import '../models/order_models.dart';

class OrderDocumentView extends StatelessWidget {
  final OrderDocument doc;

  const OrderDocumentView({Key key, this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Observer(
        builder: (_) {
          // print("OrderDocument oberver build");
          return OrderView(order: doc.root);
        }
      ),
    );
  }
  
}

class OrderView extends StatelessWidget {
  final Order order;

  const OrderView({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text("ID: ${order.id}"),
          CustomerView(customer: order.customer)
        ],
      )
    );
  }
}

class CustomerView extends StatelessWidget {
  final Person customer;

  const CustomerView({Key key, this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (customer ==  null) return Text("No Customer");

    return Container(
      child: Text("Customer Name: ${customer.name}"),
    );
  }
}

class ProductView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


