import 'package:mobx/mobx.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer extends _Customer with _$Customer {
  static Customer fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}

// The store-class
abstract class _Customer with Store {
  @observable
  String id;

  @observable
  String title;
}

class CustomerListConverter  implements JsonConverter<ObservableList<Customer>, List<Map<String, dynamic>>> {
  const CustomerListConverter();

  @override
  ObservableList<Customer> fromJson(List<Map<String, dynamic>> json) =>
      ObservableList.of(json.map(Customer.fromJson));

  @override
  List<Map<String, dynamic>> toJson(ObservableList<Customer> list) =>
      list.map( (p) => p.toJson()).toList();
}