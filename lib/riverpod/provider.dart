import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:section0/model/shopping_item_model.dart';
import 'package:section0/riverpod/state_notifier_provider.dart';

final filteredShoppingListProvider = Provider<List<ShoppingItemModel>>((ref) {
  final filterState = ref.watch(filterProvider);
  final shoppingListState = ref.watch(shoppingListProvider);

  if (filterState == FilterState.all) {
    return shoppingListState;
  }

  // 매운거, 안매운거 나누기
  return shoppingListState
      .where((element) =>
          filterState == FilterState.spicy ? element.isSpicy : !element.isSpicy)
      .toList();
});

enum FilterState {
  // 안매움
  notSpicy,
  // 매움
  spicy,
  //전부
  all,
}

final filterProvider = StateProvider<FilterState>((ref) => FilterState.all);
