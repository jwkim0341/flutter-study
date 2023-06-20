import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  // 프로바이더 스콥안에 있는 모든 하위 프로바이더가 업데이트가 되었을 떄 실행됨
  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
      print('[Provider Updated] provider: $provider / pv : $previousValue / nv: $newValue ');
  }

  // 프로바이더를 추가하면 불리는 함수
  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value, ProviderContainer container) {
    print('[Provider Added] provider: $provider / value: ${value} ');
  }

  //프로바이더가 삭제되면 불리는 함수
  @override
  void didDisposeProvider(ProviderBase<Object?> provider, ProviderContainer container) {
    print('[Provider Disposed] provider: $provider ');
  }
}
