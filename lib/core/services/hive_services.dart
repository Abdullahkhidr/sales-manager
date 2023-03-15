import 'package:hive_flutter/adapters.dart';
import 'package:manager/features/clients_suppliers/domain/entities/client.dart';
import 'package:manager/features/clients_suppliers/domain/entities/supplier.dart';
import 'package:manager/features/expenses/domain/entities/expense.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';
import 'package:manager/features/operations/domain/entities/type_operation_adapter.dart';
import 'package:manager/features/products/domain/entities/product.dart';

class HiveServices {
  static Future<void> get init async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProductAdapter());
    Hive.registerAdapter(ClientAdapter());
    Hive.registerAdapter(SupplierAdapter());
    Hive.registerAdapter(OperationAdapter());
    Hive.registerAdapter(ExpenseAdapter());
    Hive.registerAdapter(TypeOperationAdapter());
    await Hive.openBox(HiveBoxes.operations);
    await Hive.openBox(HiveBoxes.products);
    await Hive.openBox(HiveBoxes.clients);
    await Hive.openBox(HiveBoxes.suppliers);
    await Hive.openBox(HiveBoxes.expenses);
  }
}

class HiveBoxes {
  static const String settings = 'Settings';
  static const String operations = 'Operations';
  static const String products = 'Products';
  static const String clients = 'Clients';
  static const String suppliers = 'Suppliers';
  static const String expenses = 'Expenses';
}
