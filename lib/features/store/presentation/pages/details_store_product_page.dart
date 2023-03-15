import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/core/widgets/app_bar_widget.dart';
import 'package:manager/core/widgets/line_widget.dart';
import 'package:manager/core/widgets/operation_widget.dart';
import 'package:manager/core/widgets/space_widget.dart';
import 'package:manager/features/products/domain/entities/product.dart';
import 'package:manager/features/store/presentation/bloc/store/store_bloc.dart';

class DetailsStoreProductPage extends StatelessWidget {
  final Product product;
  const DetailsStoreProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => StoreBloc(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.paddingScreen.left),
          child: BlocBuilder<StoreBloc, StoreState>(builder: (context, state) {
            StoreBloc bloc = context.read();
            if (state is StoreInitial) {
              bloc.add(StoreGetOperationsOfProductEvent(product));
            }
            return CustomScrollView(slivers: [
              AppBarWidget(product.name ?? ''),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: colorScheme.background,
                      border:
                          Border.all(width: 0.2, color: colorScheme.primary)),
                  child: Text('${product.remaining} ${product.unit}',
                      textAlign: TextAlign.center,
                      style: Fonts.t2(
                          fontWeight: FontWeight.w700,
                          color: colorScheme.primary)),
                ),
                const Space(isH: true, count: 3),
                const LineWidget(),
                const Space(isH: true, count: 3),
                Text('title_operations_product'.tr(),
                    textAlign: TextAlign.start,
                    style: Fonts.t3(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.primary)),
              ])),
              if (state is StoreLoadedOperationsOfProductState)
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => ItemOperationWidget(
                            operation: state.operations[index]),
                        childCount: state.operations.length))
            ]);
          }),
        ),
      ),
    );
  }
}
