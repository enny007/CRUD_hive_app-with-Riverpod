import 'package:flutter/material.dart';
import 'package:flutter_hive_riverpod/provider/associate_data.dart';
import 'package:flutter_hive_riverpod/model/associate.dart';
import 'package:flutter_hive_riverpod/widgets/toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddAssociatePage extends ConsumerStatefulWidget {
  const AddAssociatePage({super.key});

  @override
  ConsumerState<AddAssociatePage> createState() => _AddAssociatePageState();
}

class _AddAssociatePageState extends ConsumerState<AddAssociatePage> {
  String? name;
  int? phone;
  bool? senior;
  int? age;
  DateTime? joined;

  void addAssociate(context) {
    if (name == null) {
      toastWidget('Give entry a name');
      return;
    }
    if (name!.length < 2) {
      toastWidget('Name input is too short');
      return;
    }
    ref.read(associateProvider).addAssociate(
          Associate(
            name: name!,
            phone: phone!,
            isSenior: senior!,
            joinDate: joined!,
            age: age!,
          ),
        );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        elevation: 16,
        title: const Text(
          'Add Associate',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            iconSize: 24,
            color: Colors.blue,
            tooltip: 'Save',
            onPressed: () {
              addAssociate(context);
            },
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                autofocus: true,
                // controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'Phone',
                ),
                onChanged: (value) {
                  setState(() {
                    phone = int.parse(value);
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                autofocus: true,
                // controller: _ageController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: false,
                ),
                decoration: const InputDecoration(
                  hintText: 'Age',
                ),
                onChanged: (value) {
                  setState(() {
                    age = int.parse(value);
                  });
                },
              ),
              Row(
                children: [
                  const Text(
                    'Is Senior',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Switch(
                    activeTrackColor: Colors.black,
                    activeColor: Colors.blue,
                    value: senior ?? false,
                    onChanged: (value) {
                      setState(() {
                        senior = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Join Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2100),
                      );
                      if (d != null) {
                        setState(() {
                          joined = d;
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.calendar_today,
                    ),
                    tooltip: 'Tap to open the date picker',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
