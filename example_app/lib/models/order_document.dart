import 'package:example_app/models/customer.dart';
import 'package:example_app/models/order.dart';
import 'package:example_app/models/product.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_document/document_mixin.dart';

part 'order_document.g.dart';

class OrderDocument extends _OrderDocument with _$OrderDocument {

  OrderDocument(Order order) {
    this.root = order;
  }

  @override
  Order rootFromJson(Map<String, dynamic> json) {
    return Order.fromJson(json);
  }

  @override
  Map<String, dynamic> rootToJson(Order obj) {
    return obj.toJson();
  }

}

// The store-class
abstract class _OrderDocument with Store, DocumentMixin<Order> {

  int count = 0;

  changeTitle() => undoableAction('Change Title', (){
    count++;
    root.title = "Custom Title" + count.toString();
  });

  setCustomer(Customer customer) => undoableAction('Set Customer', (){
    root.customer = customer;
  });

  addProduct(Product product)  => undoableAction('Add Product', (){
    root.products.add(product);
  });

  removeProduct(Product product)  => undoableAction('Remove Product', (){
    root.products.remove(product);
  });

  updateCustomer(Customer customer, Function(Customer) update)  => undoableAction('Update Customer', (){
    update(customer);
  });

  updateProduct(Product product, Function(Product) update)  => undoableAction('Update Product', (){
    update(product);
  });

}
