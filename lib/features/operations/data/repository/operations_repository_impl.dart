import 'package:manager/features/clients_suppliers/data/datasources/hive/clients/hive_edit_client.dart';
import 'package:manager/features/clients_suppliers/data/datasources/hive/clients/hive_get_client_by_id.dart';
import 'package:manager/features/clients_suppliers/data/datasources/hive/suppliers/hive_edit_supplier.dart';
import 'package:manager/features/clients_suppliers/data/datasources/hive/suppliers/hive_get_supplier_by_id.dart';
import 'package:manager/features/clients_suppliers/domain/entities/client.dart';
import 'package:manager/features/clients_suppliers/domain/entities/supplier.dart';
import 'package:manager/features/operations/data/datasources/hive/hive_add_operation.dart';
import 'package:manager/features/operations/data/datasources/hive/hive_delete_operation.dart';
import 'package:manager/features/operations/data/datasources/hive/hive_edit_operation.dart';
import 'package:manager/features/operations/data/datasources/hive/hive_get_all_operations.dart';
import 'package:manager/features/operations/data/datasources/hive/hive_get_operation_by_id.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:manager/features/operations/domain/repository/operations_repository.dart';
import 'package:manager/features/products/data/datasources/hive/hive_edit_product.dart';
import 'package:manager/features/products/data/datasources/hive/hive_get_product_by_id.dart';
import 'package:manager/features/products/domain/entities/product.dart';

class OperationsRepositoryImpl implements OperationsRepository {
  @override
  Future<Either<Failure, Operation>> addOperation(Operation operation) async {
    try {
      Either<Failure, Operation> res = await hiveAddOperation(operation);
      res.fold((failure) {}, (successOperation) {
        Either<Failure, Product> resGetProduct =
            hiveGetProductById(successOperation.idProduct!);
        resGetProduct.fold((l) {}, (product) async {
          if (successOperation.typeOperation == TypeOperation.Sale) {
            product.remaining = product.remaining! - successOperation.quantity!;
          } else {
            product.remaining = product.remaining! + successOperation.quantity!;
          }
          await hiveEditProduct(product);
        });
        if (successOperation.idClient != null) {
          Either<Failure, Client> resGetClient =
              hiveGetClientById(successOperation.idClient!);
          resGetClient.fold((l) {}, (client) async {
            client.salesAmount = client.salesAmount! + successOperation.amount!;
            await hiveEditClient(client);
          });
        } else if (successOperation.idSupplier != null) {
          Either<Failure, Supplier> resGetSupplier =
              hiveGetSupplierById(successOperation.idSupplier!);
          resGetSupplier.fold((l) {}, (supplier) async {
            supplier.purchasesAmount =
                supplier.purchasesAmount! + successOperation.amount!;
            await hiveEditSupplier(supplier);
          });
        }
      });
      return Right(operation);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Operation>> deleteOperation(
      Operation operation) async {
    try {
      Either<Failure, Operation> res = await hiveDeleteOperation(operation);
      res.fold((failure) {}, (successOperation) {
        Either<Failure, Product> resGetProduct =
            hiveGetProductById(successOperation.idProduct!);
        resGetProduct.fold((l) {}, (product) async {
          if (successOperation.typeOperation == TypeOperation.Sale) {
            product.remaining =
                (product.remaining ?? 0) + (successOperation.quantity ?? 0);
          } else {
            product.remaining =
                (product.remaining ?? 0) - (successOperation.quantity ?? 0);
          }
          await hiveEditProduct(product);
        });
        if (successOperation.idClient != null) {
          Either<Failure, Client> resGetClient =
              hiveGetClientById(successOperation.idClient!);
          resGetClient.fold((l) {}, (client) async {
            client.salesAmount = client.salesAmount! - successOperation.amount!;
            await hiveEditClient(client);
          });
        } else if (successOperation.idSupplier != null) {
          Either<Failure, Supplier> resGetSupplier =
              hiveGetSupplierById(successOperation.idSupplier!);
          resGetSupplier.fold((l) {}, (supplier) async {
            supplier.purchasesAmount =
                supplier.purchasesAmount! - successOperation.amount!;
            await hiveEditSupplier(supplier);
          });
        }
      });
      return Right(operation);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Operation>> editOperation(Operation operation) async {
    try {
      Either<Failure, Operation> oldOperation =
          hiveGetOperationById(operation.id!);
      await hiveEditOperation(operation);

      double oldAmount = 0;
      double newAmount = 0;
      double oldQuantity = 0;
      double newQuantity = 0;

      oldOperation.fold((l) => null, (r) {
        oldAmount = r.amount ?? 0;
        newAmount = operation.amount ?? 0;
        oldQuantity = r.quantity ?? 0;
        newQuantity = operation.quantity ?? 0;

        double amount = newAmount - oldAmount;
        double quantity = newQuantity - oldQuantity;

        Either<Failure, Product> resGetProduct =
            hiveGetProductById(operation.idProduct!);
        resGetProduct.fold((l) => null, (product) async {
          if (operation.typeOperation == TypeOperation.Sale) {
            product.remaining = (product.remaining ?? 0) - quantity;
          } else {
            product.remaining = (product.remaining ?? 0) + quantity;
          }
          await hiveEditProduct(product);
        });

        //
        if (operation.idClient != null) {
          Either<Failure, Client> resGetClient =
              hiveGetClientById(operation.idClient!);
          resGetClient.fold((l) {}, (client) async {
            client.salesAmount = client.salesAmount! + amount;
            await hiveEditClient(client);
          });
        } else if (operation.idSupplier != null) {
          Either<Failure, Supplier> resGetSupplier =
              hiveGetSupplierById(operation.idSupplier!);
          resGetSupplier.fold((l) {}, (supplier) async {
            supplier.purchasesAmount = supplier.purchasesAmount! + amount;
            await hiveEditSupplier(supplier);
          });
        }
      });

      return Right(operation);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Either<Failure, List<Operation>> getAllOperations() {
    return hiveGetAllOperations();
  }
}
