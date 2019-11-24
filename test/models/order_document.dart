import 'order_models.dart';
import 'package:mobx_document/document_mixin.dart';

class OrderDocument with DocumentMixin<Order> {

  OrderDocument() {
    root = new Order(id: "123");
  }

  // Undoable Actions //

  newOrder() => undoableAction('New Order', () {
    root = new Order();
  });

  setCustomer(Person customer) => undoableAction('Add Customer', () {
    root.customer = customer;
  });

  updateCustomerName(String name) => undoableAction('Update Customer Name', () {
    root.customer.name = name;
  });

  @override
  Order rootFromJson(Map<String, dynamic> json) {
    return Order.fromJson(json);
  }

  @override
  Map<String, dynamic> rootToJson(Order obj) {
    return obj.toJson();
  }

}