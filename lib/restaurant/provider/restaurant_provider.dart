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

  paginate() async {
    final resp = await repository.paginate();
    //state 안에 저장
    state = resp;
  }
}
