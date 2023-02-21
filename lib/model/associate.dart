// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/adapters.dart';

part 'associate.g.dart';

@HiveType(typeId: 0)
class Associate extends HiveObject{
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int phone;
  @HiveField(2)
  final bool isSenior;
  @HiveField(3)
  final DateTime joinDate;
  @HiveField(4)
  final int age;
  Associate({
    required this.name,
    required this.phone,
    required this.isSenior,
    required this.joinDate,
    required this.age,
  });
}
