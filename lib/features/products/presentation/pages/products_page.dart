import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/widgets/app_bar_widget.dart';
import 'package:manager/core/widgets/empty_widget.dart';
import 'package:manager/core/widgets/floating_button_add_widget.dart';
import 'package:manager/core/widgets/space_widget.dart';
import 'package:manager/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:manager/features/products/presentation/pages/editor_product.dart';
import 'package:manager/features/products/presentation/widgets/item_list_product.dart';
import 'package:manager/features/products/presentation/widgets/search_bar_widget.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.paddingScreen.left),
        child: BlocProvider(
          create: (context) => ProductsBloc(),
          child: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              ProductsBloc bloc = context.read<ProductsBloc>();
              bloc.add(ProductsGetAllEvent());
              return CustomScrollView(
                slivers: [
                  AppBarWidget('title_products'.tr()),
                  SliverToBoxAdapter(child: SearchBarWidget(bloc: bloc)),
                  if (bloc.allProducts != null && bloc.allProducts!.isEmpty)
                    SliverToBoxAdapter(
                        child: EmptyWidget(
                            msg: 'msg_empty_products'.tr(),
                            nameLottieFile: 'products')),
                  if (bloc.state is ProductsResultSearchState)
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => ItemProductWidget(
                                product: bloc.searchedProducts[index]),
                            childCount: bloc.searchedProducts.length))
                  else
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => ItemProductWidget(
                                product: bloc.allProducts![index]),
                            childCount: bloc.allProducts?.length ?? 0)),
                  const SliverToBoxAdapter(child: Space(isH: true, count: 4))
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingButtonAddWidget(
          onTap: () => Nav.to(const EditorProductPage()),
          title: 'btn_add_product'.tr()),
    );
  }
}
