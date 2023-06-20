import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_generation_provider.g.dart';

// 1) 어떤 Provider를 사용할 지 결정할 고민 할 필요 없도록
// Provider, FUtureProvider, StreamProvider
// StateNotifierProvider

final _testProvider = Provider<String>((ref) => 'Hello Code Generation');

@riverpod
String gSate(GSateRef ref) {
  return 'Hello Code Generation';
}

@riverpod
Future<int> gStatFuture(GStatFutureRef ref) async {
  await Future.delayed(Duration(seconds: 3));
  return 10;
}

@Riverpod(
  // 값 살려두기 속성
  keepAlive: true,
)
Future<int> gStatFuture2(GStatFuture2Ref ref) async {
  await Future.delayed(Duration(seconds: 3));
  return 10;
}

// 2) Parameter > Family 파라미터를 일반 함수처럼 사용할 수 있도록
class Parameter {
  final int number1;
  final int number2;

  Parameter({
    required this.number1,
    required this.number2,
  });
}

final _testFamilyProvider = Provider.family<int, Parameter>
  ((ref, parameter) => parameter.number1 * parameter.number2,
);

@riverpod
int gStateMultiply(GStateMultiplyRef ref,{
  required int number1,
  required int number2,
}){
  return number1 * number2;
}