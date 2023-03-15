import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/products/domain/entities/product.dart';
import 'package:manager/features/products/domain/repository/products_repository.dart';

class EditProductUsecase {
  ProductsRepository productsRepository;
  EditProductUsecase(this.productsRepository);
  Future<Either<Failure, Product>> call(Product product) =>
      productsRepository.editProduct(product);
}
