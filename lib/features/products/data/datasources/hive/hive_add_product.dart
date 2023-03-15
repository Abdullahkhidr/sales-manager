import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/hive_services.dart';
import 'package:manager/features/products/domain/entities/product.dart';

Future<Either<Failure, Product>> hiveAddProduct(Product product) async {
  try {
    product.id = '${DateTime.now().millisecondsSinceEpoch}';
    await Hive.box(HiveBoxes.products).put(product.id, product);
    return Right(product);
  } catch (e) {
    return Left(UnexpectedFailure(e.toString()));
  }
}
