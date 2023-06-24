import 'package:section1/common/model/cursor_pagination_model.dart';
import 'package:section1/common/model/pagination_params.dart';

abstract class IBasePaginationRepository<T>{

  Future<CursorPagination<T>> paginate({
    PaginationParams? paginationParams = const PaginationParams(),
  });
}