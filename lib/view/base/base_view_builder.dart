import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:moonlang_dictionary/view_model/base/base_view_model.dart';
  
class BaseViewBuilder<T extends StateNotifier<S>, S extends BaseViewModelState>
    extends ConsumerWidget {
  final StateNotifierProvider<T, S> provider;
  final Widget Function(
    BuildContext context,
    S state,
    T viewModel,  
  )
  builder;
  const BaseViewBuilder({
    required this.provider,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);
    final vm = ref.watch(provider.notifier);
    return builder(context, state, vm);
  }
}
