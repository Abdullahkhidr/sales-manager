import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/products/domain/repository/products_repository.dart';

class SelectImageUsecase {
  ProductsRepository productsRepository;
  SelectImageUsecase(this.productsRepository);

  Future<Either<Failure, Uint8List>> get call async =>
      await productsRepository.selectImage();
}
