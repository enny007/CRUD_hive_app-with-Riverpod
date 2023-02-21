import 'package:flutter/material.dart';
import 'package:flutter_hive_riverpod/provider/associate_data.dart';
import 'package:flutter_hive_riverpod/model/associate.dart';
import 'package:flutter_hive_riverpod/widgets/toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssociateEditPage extends ConsumerStatefulWidget {
  const AssociateEditPage({super.key, required this.currentAssociate});
  final Associate currentAssociate;
  @override
  ConsumerState<AssociateEditPage> createState() => _AssociateEditPageState();
}

class _AssociateEditPageState extends ConsumerState<AssociateEditPage> {
  String? newName;
  int? newPhone;
  bool? newSenior;
  int? newAge;
  DateTime? newJoinDate;

  void editAssociate(context) {
    if (newName == null) {
      toastWidget('Give entry a name');
      return;
    }
    if (newName!.length < 2) {
      toastWidget('Name input is too short');
      return;
    }
    ref.read(associateProvider).editAssociate(
          associate: Associate(
            name: newName!,
            phone: newPhone!,
            isSenior: newSenior!,
            joinDate: newJoinDate!,
            age: newAge!,
          ),
          associateKey: widget.currentAssociate.key,
        );
    Navigator.pop(context);
  }

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.currentAssociate.name;
    newName = widget.currentAssociate.name;
    _phoneController.text = widget.currentAssociate.phone.toString();
    newPhone = widget.currentAssociate.phone;
    _ageController.text = widget.currentAssociate.age.toString();
    newAge = widget.currentAssociate.age;
    newSenior = widget.currentAssociate.isSenior;
    newJoinDate = widget.currentAssociate.joinDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        elevation: 16,
        title: Text(
          'Edit ${widget.currentAssociate.name}',
          style: const TextStyle(
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
              editAssociate(context);
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
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
                onChanged: (value) {
                  setState(() {
                    newName = value;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                autofocus: true,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'Phone',
                ),
                onChanged: (value) {
                  setState(() {
                    newPhone = int.parse(value);
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                autofocus: true,
                controller: _ageController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: false,
                ),
                decoration: const InputDecoration(
                  hintText: 'Age',
                ),
                onChanged: (value) {
                  setState(() {
                    newAge = int.parse(value);
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
                    value: newSenior ?? false,
                    onChanged: (value) {
                      setState(() {
                        newSenior = value;
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
                          newJoinDate = d;
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
