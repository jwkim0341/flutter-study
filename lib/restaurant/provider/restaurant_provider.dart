import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:section1/common/model/cursor_pagination_model.dart';
import 'package:section1/restaurant/model/restaurant_model.dart';
import 'package:section1/restaurant/repository/restaurant_repository.dart';

final restaurantProvider = StateNotifierProvider<RestaurantStateNotifier,
    CursorPaginationBase>((ref) {
        final repository = ref.watch(restaurantRepositoryProvider);
        final notifier = RestaurantStateNotifier(repository: repository);
        return notifier;
      },
    );

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository,
  }) : super(CursorPaginationLoading()) { // 아직 값이 들어오지 않을 때는 로딩을 시켜준다
    paginate();
  }

  paginate({
    int fetchCount = 20,
    // 추가로 데이터 더 가져오기
    // true - 추가로 데이터 더 가져옴
    // false - 새로고침 (현재 상태를 덮어씌움)
    bool fetchMore = false,
    // 강제로 다시 로딩하기
    // true - CursorPaginationLoading()
    bool forceRefetch = false,
}) async {
    // 5가지 가능성
    // State의 상태

  }
}
