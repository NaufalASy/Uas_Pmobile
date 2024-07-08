class Stock {
  final String id;
  final String name;
  final int qty;
  final int createdAt;
  final int updatedAt;
  final String attr;
  final num weight;
  final String issuer;

  Stock(
      {required this.id,
      required this.name,
      required this.qty,
      required this.createdAt,
      required this.updatedAt,
      required this.attr,
      required this.weight,
      required this.issuer});

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
        id: json['id'],
        name: json['name'],
        qty: json['qty'],
        attr: json['attr'],
        weight: json['weight'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        issuer: json['issuer']);
  }
}
