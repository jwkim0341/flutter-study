import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:section0/layout/default_layout.dart';
import 'package:section0/riverpod/code_generation_provider.dart';

class CodeGenerationSreen extends ConsumerWidget {
  const CodeGenerationSreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final state1 = ref.watch(gSateProvider);


    return DefaultLayout(
      title: 'CodeGenerationSreen',
      body: Column(
        children: [
          Text('State1 : $state1'),
        ],
      ),
    );
  }
}
