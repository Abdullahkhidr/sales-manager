import 'package:flutter/material.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/features/products/domain/entities/product.dart';
import 'package:manager/features/products/presentation/pages/details_product_page.dart';

class ItemProductWidget extends StatelessWidget {
  final Product product;
  const ItemProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ListTile(
        onTap: () => Nav.to(DetailsProductPage(product: product)),
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        tileColor: colorScheme.secondary.withAlpha(6),
        shape: RoundedRectangleBorder(borderRadius: Sizes.borderRadius),
        leading: product.image != null
            ? ClipRRect(
                borderRadius: Sizes.borderRadius,
                child: Image.memory(product.image!,
                    height: Sizes.size(30),
                    width: Sizes.size(30),
                    fit: BoxFit.cover))
            : null,
        title: Text(product.name ?? '',
            style: Fonts.t4(fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.clip),
        subtitle: product.description!.isEmpty
            ? null
            : Text(product.description ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: Fonts.t6()),
        trailing: Text(product.unit ?? '',
            style: Fonts.t6(fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.clip),
      ),
    );
    // return GestureDetector(
    //   onTap: () => Nav.to(DetailsProductPage(product: product)),
    //   child: Container(
    //     padding: const EdgeInsets.all(16),
    //     margin: const EdgeInsets.all(5),
    //     decoration: BoxDecoration(
    //       color: colorScheme.secondary.withAlpha(10),
    //       borderRadius: Sizes.borderRadius,
    //       // border: Border.all(color: colorScheme.secondary.withAlpha(10)),
    //       // boxShadow: [
    //       // BoxShadow(
    //       //     blurRadius: 4, color: colorScheme.secondary, spreadRadius: -1)
    //       // ]
    //     ),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //           ClipRRect(
    //               borderRadius: Sizes.borderRadius,
    //               child: product.image != null
    //                   ? Image.memory(product.image!,
    //                       height: Sizes.size(40),
    //                       width: Sizes.size(40),
    //                       fit: BoxFit.cover)
    //                   : null),
    //           if (product.image != null) const Space(count: 4),
    //           Expanded(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(product.name ?? '',
    //                     style: Fonts.t4(fontWeight: FontWeight.w600),
    //                     maxLines: 1,
    //                     overflow: TextOverflow.clip),
    //                 const Space(count: 2, isH: true),
    //                 Text(product.description ?? '',
    //                     overflow: TextOverflow.ellipsis,
    //                     maxLines: 3,
    //                     style: Fonts.t6()),
    //               ],
    //             ),
    //           )
    //         ]),
    //       ],
    //     ),
    //   ),
    // );
  }
}
