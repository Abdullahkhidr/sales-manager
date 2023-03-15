import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/features/products/presentation/bloc/editor_product/editor_product_bloc.dart';

class ProductImageWidget extends StatelessWidget {
  final Uint8List? image;
  final EditorProductBloc? bloc;
  const ProductImageWidget({super.key, required this.image, this.bloc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bloc?.add(EditorChangeImageProductEvent());
      },
      child: Container(
        width: double.maxFinite,
        height: Sizes.size(80),
        decoration: BoxDecoration(
            color: colorScheme.secondary.withAlpha(30),
            borderRadius: Sizes.borderRadius,
            image: image == null
                ? null
                : DecorationImage(
                    image: MemoryImage(image!), fit: BoxFit.cover)),
        child: image == null
            ? bloc == null
                ? null
                : Icon(Icons.add_a_photo, color: colorScheme.secondary)
            : null,
      ),
    );
  }
}
