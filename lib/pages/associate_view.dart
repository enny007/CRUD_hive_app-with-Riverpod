import 'package:flutter/material.dart';
import 'package:flutter_hive_riverpod/provider/associate_data.dart';
import 'package:flutter_hive_riverpod/pages/associate_edit.dart';
import 'package:flutter_hive_riverpod/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AssociateView extends ConsumerWidget {
  const AssociateView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentAssociate = ref.watch(associateProvider).getActiveAssociate();
    void deleteConfirmation() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                'Are you sure?',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(
                      'You are about to delete ${currentAssociate.name}',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('This action cannot be undone')
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Log.d('Deleting ${currentAssociate.name}');
                    ref
                        .read(associateProvider.notifier)
                        .deleteAssociate(currentAssociate.key);
                    Navigator.popUntil(context,
                        ModalRoute.withName(Navigator.defaultRouteName));
                  },
                  child: const Text(
                    'DELETE',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Log.d('Cancelling');
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        elevation: 16,
        title: Text(
          currentAssociate.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Log.d('Selected to edit');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssociateEditPage(
                    currentAssociate: currentAssociate,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.create),
            iconSize: 24,
            color: Colors.blue,
            tooltip: 'Edit',
          ),
          IconButton(
            onPressed: () {
              Log.d('Selected for deletion');
              deleteConfirmation();
            },
            icon: const Icon(Icons.delete),
            iconSize: 24,
            color: Colors.red,
            tooltip: 'Delete',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Container(
                height: 36,
                color: Colors.grey[300],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Phone',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      currentAssociate.phone.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 36,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Age',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      currentAssociate.age.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 36,
                color: Colors.grey[300],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Join Date',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd').format(
                        currentAssociate.joinDate,
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 36,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Senior',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Switch(
                      activeTrackColor: Colors.black,
                      value: currentAssociate.isSenior,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
