class Cart {
  String? id;
  String? title;
    int? quantity;
   double? price;
  Cart(
      this.id,
      this.title,
      this.quantity,
      this.price,
      );
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'title': title,
      'quantity': quantity,
      'price':price,
      };
    return map;
  }

  Cart.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    quantity = map['quantity'];
    price = map['price'];

  }
}
