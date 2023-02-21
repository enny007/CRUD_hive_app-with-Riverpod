import 'package:flutter/material.dart';
import 'package:flutter_hive_riverpod/provider/associate_data.dart';
import 'package:flutter_hive_riverpod/widgets/associate_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssociateList extends ConsumerWidget {
  const AssociateList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associates = ref.watch(associateProvider);
    return ListView.builder(
        itemCount: associates.associateCount,
        padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
        itemBuilder: (context, index) {
          return AssociateTile(
            titleIndex: index,
          );
        });
  }
}
