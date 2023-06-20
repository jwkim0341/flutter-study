class ShoppingItemModel {
  // 이름
  final String name;

  // 객수
  final int quantity;

  // 구매헀는지
  final bool hasBought;

  // 매운지
  final bool isSpicy;

  ShoppingItemModel({
    required this.name,
    required this.quantity,
    required this.hasBought,
    required this.isSpicy,
  });

  //옵션 파라미터 - ?붙임(null허용)
  // 받아온 값이 null 이라면 '??'
  ShoppingItemModel copyWith({
    String? name,
    int? quantity,
    bool? hasBought,
    bool? isSpicy,
  }) {
    return ShoppingItemModel(
      name: name ?? this.name ,
      quantity: quantity ?? this.quantity,
      hasBought: hasBought ?? this.hasBought,
      isSpicy: isSpicy ?? this.isSpicy,
    );
  }
}
