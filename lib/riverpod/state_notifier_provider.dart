import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:section0/model/shopping_item_model.dart';

// 위젯에서 사용하기 위해 프로바이더로 만들어 준다
// ShoppingListNotifier를 관리할 수 있는 프로바이더
// 어디에서든이 프로바이더를 불러오게 되면 ShoppingListNotifier 인스턴스가 반환이 된다
final shoppingListProvider =
    StateNotifierProvider<ShoppingListNotifier, List<ShoppingItemModel>>(
        (ref) => ShoppingListNotifier());

// 상태를 관리할 수 있는 클래스
class ShoppingListNotifier extends StateNotifier<List<ShoppingItemModel>> {
  ShoppingListNotifier()
      : super(
          [
            ShoppingItemModel(
              name: "김치",
              quantity: 3,
              hasBought: false,
              isSpicy: true,
            ),
            ShoppingItemModel(
              name: "라면",
              quantity: 5,
              hasBought: false,
              isSpicy: true,
            ),
            ShoppingItemModel(
              name: "삼겹살",
              quantity: 10,
              hasBought: false,
              isSpicy: false,
            ),
            ShoppingItemModel(
              name: "수박",
              quantity: 2,
              hasBought: false,
              isSpicy: true,
            ),
            ShoppingItemModel(
              name: "카스테라",
              quantity: 5,
              hasBought: false,
              isSpicy: false,
            ),
          ],
        );

  //hasbought 상태 변경하는 함수
  void toggleHasBought({required String name}) {
    state = state
        .map((e) => e.name == name
            ? ShoppingItemModel(
                name: e.name,
                quantity: e.quantity,
                hasBought: !e.hasBought,
                isSpicy: e.isSpicy)
            : e)
        .toList();
  }
}
