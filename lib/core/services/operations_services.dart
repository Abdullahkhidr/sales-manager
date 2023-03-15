import 'package:manager/features/clients_suppliers/domain/entities/client.dart';
import 'package:manager/features/clients_suppliers/domain/entities/supplier.dart';
import 'package:manager/features/operations/data/datasources/hive/hive_get_all_operations.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';
import 'package:manager/features/products/domain/entities/product.dart';

class OperationsServices {
  static List<Product> getRemainingFromProducts(
      List<Product> products, List<Operation> operations) {
    List<Product> res = [];
    for (Product itemProduct in products) {
      List<Operation> operationsProduct = operations
          .where((element) => element.idProduct == itemProduct.id)
          .toList();
      for (var i = 0; i < operationsProduct.length; i++) {
        if (operationsProduct[i].typeOperation == TypeOperation.Sale) {
          itemProduct.remaining =
              itemProduct.remaining ?? 0 - (operationsProduct[i].quantity ?? 0);
        } else {
          itemProduct.remaining =
              itemProduct.remaining ?? 0 + (operationsProduct[i].quantity ?? 0);
        }
      }
      res.add(itemProduct);
      operations.removeWhere((element) => element.idProduct == itemProduct.id);
    }
    return res;
  }

  static List<double> calculateExpenseAndSales(List<Operation> operations) {
    double sales = 0;
    double expense = 0;
    operations = operations
        .where((element) => element.typeOperation != TypeOperation.Buy)
        .toList();
    for (var operation in operations) {
      if ((operation.amount ?? 0) > 0) {
        sales += operation.amount!;
      } else {
        expense += operation.amount ?? 0;
      }
    }
    return [expense, sales];
  }

  static List<Operation> getOperationsOfClientOrSupplier(
      {List<Operation>? operations, Client? client, Supplier? supplier}) {
    if (operations == null) {
      hiveGetAllOperations().fold((l) {
        return [];
      }, (r) {
        operations = r;
      });
    }
    return operations!.where((element) {
      if (client != null) {
        return element.idClient == client.id;
      } else if (supplier != null) {
        return element.idSupplier == supplier.id;
      }
      return false;
    }).toList();
  }

  static double calculateExpenseAndSalesOfClientOrSupplier(
      {List<Operation>? operations, Client? client, Supplier? supplier}) {
    List<Operation> resultOperations = getOperationsOfClientOrSupplier(
        operations: operations, client: client, supplier: supplier);
    double sum = 0;
    for (var operation in resultOperations) {
      sum += operation.amount ?? 0;
    }
    return sum;
  }
}
