// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/products/domain/entities/product.dart';
import 'package:manager/features/products/domain/repository/products_repository.dart';

class GetAllProductsUsecase {
  ProductsRepository productsRepository;
  GetAllProductsUsecase(this.productsRepository);
  Either<Failure, List<Product>> call() => productsRepository.getAllProducts();
}
