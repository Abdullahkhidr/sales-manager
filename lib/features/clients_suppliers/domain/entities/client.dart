import 'package:hive/hive.dart';

part 'client.g.dart';

@HiveType(typeId: 1)
class Client {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? phone;
  @HiveField(3)
  String? company;
  @HiveField(4)
  String? notes;
  @HiveField(5)
  double? salesAmount;

  Client(
      {this.id,
      this.name,
      this.phone,
      this.company,
      this.notes,
      this.salesAmount = 0});
}
