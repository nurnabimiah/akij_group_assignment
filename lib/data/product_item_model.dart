


class Item {
  final String itemName;
  final int quantity;

  Item({
    required this.itemName,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'quantity': quantity,
    };
  }
}