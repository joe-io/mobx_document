import 'package:mobx/mobx.dart';
import 'package:json_annotation/json_annotation.dart';

import 'customer.dart';
import 'product.dart';

part 'order.g.dart';

@JsonSerializable()
class Order extends _Order with _$Order {

  Order({String id, String title, Customer customer}) {
    this.id = id;
    this.title = title;
    this.customer = customer;
  }

  static Order fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

// The store-class
abstract class _Order with Store {
  @observable
  String id;

  @observable
  String title;

  @observable
  Customer customer;

  @observable
  @ProductListConverter()
  ObservableList<Product> products = ObservableList<Product>();
}

class OrderListConverter  implements JsonConverter<ObservableList<Order>, List<Map<String, dynamic>>> {
  const OrderListConverter();

  @override
  ObservableList<Order> fromJson(List<Map<String, dynamic>> json) =>
      ObservableList.of(json.map(Order.fromJson));

  @override
  List<Map<String, dynamic>> toJson(ObservableList<Order> list) =>
      list.map( (p) => p.toJson()).toList();
}