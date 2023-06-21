import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:section1/common/model/cursor_pagination_model.dart';
import 'package:section1/restaurant/model/restaurant_model.dart';
import 'package:section1/restaurant/repository/restaurant_repository.dart';

final restaurantProvider = StateNotifierProvider<RestaurantStateNotifier,
    List<RestaurantModel>>((ref) {
        final repository = ref.watch(restaurantRepositoryProvider);
        final notifier = RestaurantStateNotifier(repository: repository);
        return notifier;
      },
    );

class RestaurantStateNotifier extends StateNotifier<CursorPagination<RestaurantModel>> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository,
  }) : super() { // 아직 실행하지, 로딩되지 않는 상태이다
    paginate();
  }

  paginate() async {
    final resp = await repository.paginate();
    //state 안에 저장
    state = resp.data;
  }
}
