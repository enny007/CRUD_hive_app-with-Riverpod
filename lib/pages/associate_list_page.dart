import 'package:flutter/material.dart';
import 'package:flutter_hive_riverpod/provider/associate_data.dart';
import 'package:flutter_hive_riverpod/widgets/associate_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssociateListPage extends ConsumerWidget {
  const AssociateListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(associateProvider).getAssociates();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        elevation: 16,
        title: const Text(
          'Associates',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Expanded(
            child: AssociateList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/AddAssociatePage');
        },
        backgroundColor: Colors.lightGreenAccent,
        tooltip: 'Add',
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
