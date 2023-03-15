import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/products/domain/entities/product.dart';

abstract class ProductsRepository {
  Either<Failure, List<Product>> getAllProducts();
  Either<Failure, Product> getProductById(String idProduct);
  Future<Either<Failure, Product>> addProduct(Product product);
  Future<Either<Failure, Product>> editProduct(Product product);
  Future<Either<Failure, Product>> deleteProduct(Product product);
  Future<Either<Failure, Uint8List>> selectImage();
}
