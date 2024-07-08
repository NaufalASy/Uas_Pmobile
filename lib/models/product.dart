class Product {
  final String id;
  final String name;
  final int price;
  final int qty;
  final String attr;
  final num weight;
  final int createdAt;
  final int updatedAt;
  final String issuer;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.qty,
      required this.attr,
      required this.weight,
      required this.createdAt,
      required this.updatedAt,
      required this.issuer});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        qty: json['qty'],
        attr: json['attr'],
        weight: json['weight'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        issuer: json['issuer']);
  }
}
