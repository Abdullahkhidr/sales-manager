import 'dart:typed_data';

import 'package:manager/core/services/file_picker_services.dart';
import 'package:manager/features/products/data/datasources/hive/hive_add_product.dart';
import 'package:manager/features/products/data/datasources/hive/hive_delete_product.dart';
import 'package:manager/features/products/data/datasources/hive/hive_edit_product.dart';
import 'package:manager/features/products/data/datasources/hive/hive_get_all_products.dart';
import 'package:manager/features/products/data/datasources/hive/hive_get_product_by_id.dart';
import 'package:manager/features/products/domain/entities/product.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:manager/features/products/domain/repository/products_repository.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  @override
  Future<Either<Failure, Product>> addProduct(Product product) {
    return hiveAddProduct(product);
  }

  @override
  Future<Either<Failure, Product>> deleteProduct(Product product) {
    return hiveDeleteProduct(product);
  }

  @override
  Future<Either<Failure, Product>> editProduct(Product product) {
    return hiveEditProduct(product);
  }

  @override
  Either<Failure, List<Product>> getAllProducts() {
    return hiveGetAllProducts();
  }

  @override
  Future<Either<Failure, Uint8List>> selectImage() async {
    return await FilePickerServices.pickImage();
  }

  @override
  Either<Failure, Product> getProductById(String idProduct) {
    return hiveGetProductById(idProduct);
  }
}
