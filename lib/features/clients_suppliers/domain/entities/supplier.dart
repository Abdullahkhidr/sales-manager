import 'package:hive/hive.dart';

part 'supplier.g.dart';

@HiveType(typeId: 2)
class Supplier {
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
  double? purchasesAmount;

  Supplier(
      {this.id,
      this.name,
      this.phone,
      this.company,
      this.notes,
      this.purchasesAmount});
}
