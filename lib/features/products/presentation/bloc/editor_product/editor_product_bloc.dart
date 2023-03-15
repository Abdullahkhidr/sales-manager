import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/message.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/features/products/data/repository/products_repository_impl.dart';
import 'package:manager/features/products/domain/entities/product.dart';
import 'package:manager/features/products/domain/repository/products_repository.dart';
import 'package:manager/features/products/domain/usecases/add_product_usecase.dart';
import 'package:manager/features/products/domain/usecases/delete_product_usecase.dart';
import 'package:manager/features/products/domain/usecases/edit_product_usecase.dart';
import 'package:manager/features/products/domain/usecases/select_image_usecase.dart';
import 'package:manager/features/products/presentation/pages/products_page.dart';

part 'editor_product_event.dart';
part 'editor_product_state.dart';

class EditorProductBloc extends Bloc<EditorProductEvent, EditorProductState> {
  ProductsRepository productsRepository = ProductsRepositoryImpl();
  EditorProductBloc() : super(EditorProductInitial()) {
    on<EditorSetProductDataEvent>((event, emit) {
      if (init) {
        init = false;
        image = event.product.image;
        averageCostPrice = event.product.averageCostPrice ?? 0;
        remaining = event.product.remaining ?? 0;
        nameController.text = event.product.name ?? '';
        unitController.text = event.product.unit ?? '';
        descriptionController.text = event.product.description ?? '';
        emit(EditorSetProductDataState());
      }
    });

    on<EditorAddProductEvent>((event, emit) async {
      Product product = Product(
          image: image,
          remaining: 0,
          name: nameController.text.trim(),
          unit: unitController.text.trim(),
          description: descriptionController.text.trim(),
          addedDate: DateTime.now(),
          updatedDate: DateTime.now());
      Either<Failure, Product> result =
          await AddProductUsecase(productsRepository).call(product);
      result.fold((failure) {}, (addedProduct) {
        Nav.back;
        Nav.replace(const ProductsPage());
        showMsg('msg_success_add'.tr(args: ['product'.tr()]));
      });
    });
    on<EditorChangeImageProductEvent>((event, emit) async {
      Either<Failure, Uint8List> res =
          await SelectImageUsecase(productsRepository).call;
      res.fold((failure) {
        // showMsg('Failed To Pick Image: ${failure.message}');
      }, (imageData) {
        image = imageData;
        emit(EditorChangedImageProductState());
      });
    });
    on<EditorEditProductEvent>((event, emit) async {
      Product product = event.product;

      product.image = image;
      product.averageCostPrice = averageCostPrice;
      product.remaining = remaining;
      product.name = nameController.text.trim();
      product.unit = unitController.text.trim();
      product.description = descriptionController.text.trim();
      product.updatedDate = DateTime.now();

      Either<Failure, Product> result =
          await EditProductUsecase(productsRepository).call(product);
      result.fold((failure) {}, (addedProduct) {
        Nav.back;
        Nav.replace(const ProductsPage());
        showMsg('msg_success_edit'.tr(args: ['product'.tr()]));
      });
    });
    on<EditorDeleteProductEvent>((event, emit) async {
      Either<Failure, Product> result =
          await DeleteProductUsecase(productsRepository).call(event.product);

      result.fold((failure) {}, (addedProduct) {
        Nav.back;
        Nav.replace(const ProductsPage());
        showMsg('msg_success_delete'.tr(args: ['product'.tr()]));
      });
    });
  }

  bool init = true;

  Uint8List? image;
  double remaining = 0;
  double averageCostPrice = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
}
