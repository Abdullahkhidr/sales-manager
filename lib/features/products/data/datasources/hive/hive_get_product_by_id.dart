import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/hive_services.dart';
import 'package:manager/features/products/domain/entities/product.dart';

Either<Failure, Product> hiveGetProductById(String idProduct) {
  try {
    Product product = Hive.box(HiveBoxes.products).get(idProduct);
    return Right(product);
  } catch (e) {
    return Left(UnexpectedFailure(e.toString()));
  }
}
