import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/products/domain/entities/product.dart';
import 'package:manager/features/products/domain/repository/products_repository.dart';

class AddProductUsecase {
  ProductsRepository productsRepository;
  AddProductUsecase(this.productsRepository);
  Future<Either<Failure, Product>> call(Product product) =>
      productsRepository.addProduct(product);
}
