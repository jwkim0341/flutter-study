import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:section0/layout/default_layout.dart';
import 'package:section0/riverpod/listen_provider.dart';

class ListenProviderScreen extends ConsumerStatefulWidget {
  const ListenProviderScreen({super.key});

  @override
  ConsumerState<ListenProviderScreen> createState() =>
      _ListenProviderScreenState();
}

class _ListenProviderScreenState extends ConsumerState<ListenProviderScreen>
    with TickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(
      length: 10,
      vsync: this,
      initialIndex: ref.read(listenProvider),
    );
  }

  @override
  Widget build(BuildContext context) {
    // previous - 기존 상태
    // next - 변경이 될 다음 상태
    // <int> - 타입반환 지정
    ref.listen<int>(listenProvider, (previous, next) {
      if (previous != next) {
        controller.animateTo(next); // index 값 부여 (화면이 넘어가도록)
      }
    });

    return DefaultLayout(
      title: 'ListenProviderScreen',
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: List.generate(
          10,
          (index) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                index.toString(),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(listenProvider.notifier).update(
                        (state) => state == 10 ? 10 : state + 1,
                      );
                },
                child: Text('다음'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(listenProvider.notifier).update(
                        (state) => state == 0 ? 0 : state - 1,
                      );
                },
                child: Text('뒤로'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
