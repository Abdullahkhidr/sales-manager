import 'dart:typed_data';
import 'package:hive/hive.dart';
part 'product.g.dart';

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  Uint8List? image;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? unit;
  @HiveField(5)
  DateTime? addedDate;
  @HiveField(6)
  DateTime? updatedDate;
  @HiveField(7)
  double? remaining;
  @HiveField(8)
  double? averageCostPrice;
  Product(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.unit,
      this.addedDate,
      this.updatedDate,
      this.remaining = 0,
      this.averageCostPrice = 0});

  @override
  String toString() {
    return 'ID $id, Remaining $remaining, Average Cost Price $averageCostPrice, Name $name, Description $description, Unit $unit, Added Date $addedDate, Updated Date $updatedDate';
  }
}
