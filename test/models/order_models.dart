/// Basic Model classes to use in Unit Tests

class Order {
  String id;
  Person customer;
  List<Product> products = new List<Product>();

  Order({this.id, this.customer});

  factory Order.fromJson(Map<String, dynamic> json) {
    return new Order(
      id: json['id'],
      customer: Person.fromJson(json['customer']),
    );
  }

  Map<String, dynamic> toJson() {
    return  {
      "id": id,
      "customer": customer?.toJson(),
    };
  }
}

class Product {
  String name;
  double amount;
  int quantity;

  Product({this.name, this.amount, this.quantity});

  factory Product.fromJson(Map<String, dynamic> json) {
    return new Product(
      name: json['name'],
      amount: json['amount'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return  {
      "name": name,
      "amount": amount,
      "quantity": quantity,
    };
  }
}

class Person {
  String name;
  int age;

  Person({this.name, this.age});

  factory Person.fromJson(Map<String, dynamic> json) {
    if (json == null) { return null; }
    return new Person(
      name: json['name'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() {
    return  {
      "name": name,
      "age": age,
    };
  }

}