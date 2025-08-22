class Customer {
  int id;
  String name;

  Customer.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

class Order {
  int orderId;
  double total;
  Customer customer;
  
  Order.fromJson(Map<String, dynamic> json)
      : orderId = json['orderId'],
        total = json['total'],
        customer = Customer.fromJson(json['customer']);

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'total': total,
        'costumer': customer.toJson(),
      };
}

void main() {
  Map<String, dynamic> json = {
    "orderId": 101,
    "customer": {
      "id": 5,
      "name": "Bob"
    },
    "total": 99.99
  };

  Order order = Order.fromJson(json);

  print(order.toJson());
}
