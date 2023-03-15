import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/features/products/domain/entities/product.dart';
import 'package:manager/features/store/presentation/pages/details_store_product_page.dart';

class ItemStoreProductWidget extends StatelessWidget {
  final Product product;
  const ItemStoreProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Nav.to(DetailsStoreProductPage(product: product)),
      child: Container(
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            border: Border.all(width: 0.2, color: colorScheme.primary),
            borderRadius: Sizes.borderRadius),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset('assets/images/box.svg',
                height: Sizes.size(50),
                width: double.maxFinite,
                fit: BoxFit.contain),
            Text(product.name!,
                textAlign: TextAlign.center,
                style: Fonts.t4(fontWeight: FontWeight.w600)),
            Text('${product.remaining} ${product.unit}',
                textAlign: TextAlign.center,
                style: Fonts.t5(
                    fontWeight: FontWeight.w700, color: colorScheme.primary)),
          ],
        ),
      ),
    );
  }
}
