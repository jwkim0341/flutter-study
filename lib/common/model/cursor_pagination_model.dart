import 'package:json_annotation/json_annotation.dart';
import 'package:section1/restaurant/model/restaurant_model.dart';

part 'cursor_pagination_model.g.dart';

@JsonSerializable(
  //jsonserializable을 생성할 때 generic argument를 고려한 코드 생성함
  genericArgumentFactories: true,
)
class CursorPagination<T>{
  final CursorPaginationMeta meta;
  final List<T> data;
  
  CursorPagination({
    required this.meta,
    required this.data,
});
  
  factory CursorPagination.fromJson(Map<String,dynamic>json,T Function(Object? json) fromJsonT )
  => _$CursorPaginationFromJson(json,fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta{
  final int count;
  final bool hasMore;

  CursorPaginationMeta({
    required this.count,
    required this.hasMore,
});
  
  factory CursorPaginationMeta.fromJson(Map<String,dynamic>json)
  => _$CursorPaginationMetaFromJson(json);
}