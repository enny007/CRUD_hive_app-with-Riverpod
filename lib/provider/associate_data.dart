import 'package:flutter/material.dart';
import 'package:flutter_hive_riverpod/model/associate.dart';
import 'package:flutter_hive_riverpod/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

//Global provider housing the changenotifier provider
//it contains the autodispose modofier that helps to dispose the provider when not in use.
final associateProvider =
    ChangeNotifierProvider.autoDispose<AssociateData>((ref) {
  return AssociateData();
});

class AssociateData with ChangeNotifier {
  static const String _boxName = 'associateBox';

  List<Associate> _associate = [];

  Associate? _activeAssociate;
  //Function to get all the associates in the registered box
  void getAssociates() async {
    var box = await Hive.openBox<Associate>(_boxName);

    _associate = box.values.toList();
    notifyListeners();
  }

  //Function to inject the associate property into the widget tree
  Associate getAssociate(index) {
    return _associate[index];
  }

  //Function to add an associate into the box
  void addAssociate(Associate associate) async {
    var box = await Hive.openBox<Associate>(_boxName);
    await box.add(associate);
    //using put requires using key and value pairs
    _associate = box.values.toList();
    notifyListeners();
  }

  //Function to delete an associate from the box
  void deleteAssociate(key) async {
    var box = await Hive.openBox<Associate>(_boxName);
    await box.delete(key);
    //using put requires using key and value pairs
    _associate = box.values.toList();

    Log.i('Deleted member with key$key');

    notifyListeners();
  }
  //Function to edit the content of an associate in the box
  void editAssociate(
      {required Associate associate, required int associateKey}) async {
    var box = await Hive.openBox<Associate>(_boxName);

    await box.put(associateKey, associate);
    _associate = box.values.toList();
    _activeAssociate = box.get(associateKey);

    Log.i('Edited ${associate.name}');
    notifyListeners();
  }

  //To select each individual assocciate with the help of the hiveobject key
  void setActiveAssociate(key) async {
    var box = await Hive.openBox<Associate>(_boxName);

    _activeAssociate = box.get(key);

    notifyListeners();
  }
  //Function to get a selected associate
  Associate getActiveAssociate() {
    return _activeAssociate!;
  }
  //A getter to get the length of all associate
  int get associateCount => _associate.length;
}
