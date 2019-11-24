import 'package:mobx/mobx.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends _Product with _$Product {
  static Product fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

// The store-class
abstract class _Product with Store {
  @observable
  String id;

  @observable
  String title;

  @observable
  double price;
}

class ProductListConverter  implements JsonConverter<ObservableList<Product>, List<Map<String, dynamic>>> {
  const ProductListConverter();

  @override
  ObservableList<Product> fromJson(List<Map<String, dynamic>> json) =>
      ObservableList.of(json.map(Product.fromJson));

  @override
  List<Map<String, dynamic>> toJson(ObservableList<Product> list) =>
      list.map( (p) => p.toJson()).toList();
}