import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moonlang_dictionary/view/base/base_view_builder.dart';
import 'package:moonlang_dictionary/view_model/word_entry_vm.dart';

class VariantEditor extends ConsumerWidget {
  final int meaningIndex;
  final int variantIndex;

  const VariantEditor({
    required this.meaningIndex,
    required this.variantIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseViewBuilder(
      provider: wordDraftProvider,
      builder: (context, state, wVm) {
        final variant = wVm.meanings[meaningIndex].variants?[variantIndex];
        return Card(
          color: Colors.grey.shade100,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                TextFormField(
                  initialValue: variant?.form,
                  decoration: const InputDecoration(labelText: 'Form'),
                  onChanged: (v) {
                    final newVariant = variant?.copyWith(form: v);
                    if (newVariant != null) {
                      wVm.updateVariant(meaningIndex, variantIndex, newVariant);
                    }
                  },
                ),
                TextFormField(
                  initialValue: variant?.region,
                  decoration: const InputDecoration(labelText: 'Region'),
                  onChanged: (v) {
                    final newVariant = variant?.copyWith(form: v);
                    if (newVariant != null) {
                      wVm.updateVariant(meaningIndex, variantIndex, newVariant);
                    }
                  },
                ),
                TextFormField(
                  initialValue: variant?.region,
                  decoration: const InputDecoration(labelText: 'Tribe'),
                  onChanged: (v) {
                    final newVariant = variant?.copyWith(form: v);
                    if (newVariant != null) {
                      wVm.updateVariant(meaningIndex, variantIndex, newVariant);
                    }
                  },
                ),
                TextFormField(
                  initialValue: variant?.tone,
                  decoration: const InputDecoration(labelText: 'Tone'),
                  onChanged: (v) {
                    final newVariant = variant?.copyWith(form: v);
                    if (newVariant != null) {
                      wVm.updateVariant(meaningIndex, variantIndex, newVariant);
                    }
                  },
                ),
                TextFormField(
                  initialValue: variant?.pronunciation,
                  decoration: const InputDecoration(labelText: 'Pronunciation'),
                  onChanged: (v) {
                    final newVariant = variant?.copyWith(form: v);
                    if (newVariant != null) {
                      wVm.updateVariant(meaningIndex, variantIndex, newVariant);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}