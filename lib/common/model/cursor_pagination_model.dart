import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:section1/restaurant/model/restaurant_model.dart';

part 'cursor_pagination_model.g.dart';

//모두 기본  base를 상속 받고 있다
abstract class CursorPaginationBase {}
// 애러 상태
class CursorPaginationError extends CursorPaginationBase{
  final String message;

  CursorPaginationError({
    required this.message,
  });
}

// 로딩 상태
class CursorPaginationLoading extends CursorPaginationBase{}

// 값이 잘 바아져온 상태
@JsonSerializable(
  //jsonserializable을 생성할 때 generic argument를 고려한 코드 생성함
  genericArgumentFactories: true,
)
class CursorPagination<T> extends CursorPaginationBase{
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

// 새로고침 상태 - 다시 처음부터 불러오기
// cursorpaginationbase도 상속중
// instance is CursorPagination -> true
// instance is CursorPaginationBase -> true
class CursorPaginationRefetching<T> extends CursorPagination<T>{
  CursorPaginationRefetching({
    required super.meta,
    required super.data
  });
}

// 레이지 로딩 상태
// 리스트의 맨 아래도 내려서
// 추가 데이터를 요청하는 중
class CursorPaginationFetchingMore<T> extends CursorPagination<T>{
  CursorPaginationFetchingMore({
    required super.meta,
    required super.data
  });
}