import 'package:flutter/material.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/widgets/app_bar_widget.dart';
import 'package:manager/core/widgets/icon_widget.dart';
import 'package:manager/core/widgets/space_widget.dart';
import 'package:manager/features/products/domain/entities/product.dart';
import 'package:manager/features/products/presentation/pages/editor_product.dart';
import 'package:manager/features/products/presentation/widgets/product_image_widget.dart';

class DetailsProductPage extends StatelessWidget {
  final Product product;
  const DetailsProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.paddingScreen.left),
      child: CustomScrollView(
        slivers: [
          AppBarWidget('${product.name}',
              iconButton: IconWidget(
                  icon: Icons.edit,
                  onTap: () => Nav.to(EditorProductPage(product: product)))),
          SliverList(
              delegate: SliverChildListDelegate([
            const Space(isH: true, count: 3),
            ProductImageWidget(image: product.image),
            const Space(isH: true, count: 4),
            Text('${product.description}',
                textAlign: TextAlign.start, style: Fonts.t4()),
          ]))
        ],
      ),
    ));
  }
}
