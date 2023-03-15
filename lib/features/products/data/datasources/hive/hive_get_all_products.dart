import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/hive_services.dart';
import 'package:manager/features/products/domain/entities/product.dart';

Either<Failure, List<Product>> hiveGetAllProducts() {
  try {
    List<Product> products =
        Hive.box(HiveBoxes.products).toMap().values.cast<Product>().toList();
    return Right(products);
  } catch (e) {
    return Left(UnexpectedFailure(e.toString()));
  }
}
