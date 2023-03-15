// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'operation.g.dart';

@HiveType(typeId: 3)
class Operation {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? idProduct;
  @HiveField(2)
  String? idClient;
  @HiveField(3)
  String? idSupplier;
  @HiveField(4)
  DateTime? date;
  @HiveField(5)
  double? quantity;
  @HiveField(6)
  TypeOperation? typeOperation;
  @HiveField(7)
  String? notes;
  @HiveField(8)
  double? amount;
  Operation(
      {this.id,
      this.idProduct,
      this.idClient,
      this.date,
      this.quantity = 0,
      this.typeOperation,
      this.notes,
      this.amount = 0,
      this.idSupplier});
}

// ignore: constant_identifier_names
enum TypeOperation { Sale, Buy, Refund }
