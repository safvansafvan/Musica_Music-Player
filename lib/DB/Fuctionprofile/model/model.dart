
import 'package:hive/hive.dart';
part 'model.g.dart';
@HiveType(typeId: 1)
class Profilemodel {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final  userimage;

  Profilemodel({required this.userimage, required this.username});
}