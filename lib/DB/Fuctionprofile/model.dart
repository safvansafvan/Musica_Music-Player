import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Profilemodel {
  @HiveField(0)
  final username;
  // @HiveField(1)
  // final userimage;

  Profilemodel({required this.username});
}