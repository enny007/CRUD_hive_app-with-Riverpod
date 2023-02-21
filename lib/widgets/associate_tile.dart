import 'package:flutter/material.dart';
import 'package:flutter_hive_riverpod/provider/associate_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/associate_view.dart';

class AssociateTile extends ConsumerWidget {
  const AssociateTile({
    super.key,
    required this.titleIndex,
  });
  final int titleIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Instead of consumer, use the ref property
    //Flutter automatically infers the type of this variable
    final currentAssociate =
        ref.watch(associateProvider).getAssociate(titleIndex);
    return Container(
      decoration: BoxDecoration(
        color: titleIndex % 2 == 0 ? Colors.grey : Colors.white,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.lightGreenAccent,
          child: Text(
            currentAssociate.name.substring(0, 1),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          currentAssociate.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          currentAssociate.phone.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          //HiveObject generates a key
          ref
              .read(associateProvider.notifier)
              .setActiveAssociate(currentAssociate.key);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AssociateView(),
            ),
          );
        },
      ),
    );
  }
}
