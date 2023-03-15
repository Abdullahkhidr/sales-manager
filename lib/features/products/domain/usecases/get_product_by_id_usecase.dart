import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/products/domain/entities/product.dart';
import 'package:manager/features/products/domain/repository/products_repository.dart';

class GetProductByIdUsecase {
  ProductsRepository productsRepository;
  GetProductByIdUsecase(this.productsRepository);
  Either<Failure, Product> call(String idProduct) =>
      productsRepository.getProductById(idProduct);
}
