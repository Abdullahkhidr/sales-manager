import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/widgets/app_bar_widget.dart';
import 'package:manager/core/widgets/empty_widget.dart';
import 'package:manager/core/widgets/icon_widget.dart';
import 'package:manager/features/products/presentation/pages/products_page.dart';
import 'package:manager/features/store/presentation/bloc/store/store_bloc.dart';
import 'package:manager/features/store/presentation/widgets/item_store_product_widget.dart';
import 'package:manager/features/store/presentation/widgets/store_search_bar_widget.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.paddingScreen.left),
          child: BlocProvider(
              create: (context) => StoreBloc(),
              child: BlocBuilder<StoreBloc, StoreState>(
                builder: (context, state) {
                  StoreBloc bloc = context.read<StoreBloc>();
                  bloc.add(StoreGetAllProduct());
                  bool isSearch = state is StoreResultSearchState;
                  return CustomScrollView(
                    slivers: [
                      AppBarWidget('title_stock'.tr(),
                          iconButton: IconWidget(
                            icon: Icons.list_alt,
                            onTap: () => Nav.to(const ProductsPage()),
                          )),
                      SliverToBoxAdapter(
                          child: StoreSearchBarWidget(bloc: bloc)),
                      if (bloc.products != null && bloc.products!.isEmpty)
                        SliverToBoxAdapter(
                            child: EmptyWidget(
                                msg: 'msg_empty_stock'.tr(),
                                nameLottieFile: 'products_store')),
                      SliverGrid.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.9),
                          itemCount: isSearch
                              ? state.products.length
                              : bloc.products?.length ?? 0,
                          itemBuilder: (context, index) =>
                              ItemStoreProductWidget(
                                  product: isSearch
                                      ? state.products[index]
                                      : bloc.products![index]))
                    ],
                  );
                },
              ))),
    );
  }
}
