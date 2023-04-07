import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 2)
class Profilemodel {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String userimage;
  @HiveField(2)
  final int id;

  Profilemodel(
      {required this.userimage, required this.username, required this.id});
}
