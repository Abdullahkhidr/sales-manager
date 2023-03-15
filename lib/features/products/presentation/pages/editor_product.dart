import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager/core/services/bottom_sheet_confirm_delete.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/widgets/app_bar_widget.dart';
import 'package:manager/core/widgets/button_widget.dart';
import 'package:manager/core/widgets/field_widget.dart';
import 'package:manager/core/widgets/icon_widget.dart';
import 'package:manager/core/widgets/space_widget.dart';
import 'package:manager/features/products/domain/entities/product.dart';
import 'package:manager/features/products/presentation/bloc/editor_product/editor_product_bloc.dart';
import 'package:manager/features/products/presentation/widgets/product_image_widget.dart';

class EditorProductPage extends StatelessWidget {
  final Product? product;
  const EditorProductPage({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.paddingScreen.left),
      child: BlocProvider(
        create: (context) => EditorProductBloc(),
        child: BlocBuilder<EditorProductBloc, EditorProductState>(
          builder: (context, state) {
            EditorProductBloc bloc = context.read<EditorProductBloc>();
            if (product != null) {
              bloc.add(EditorSetProductDataEvent(product!));
            }
            return CustomScrollView(
              slivers: [
                AppBarWidget('product'.tr(),
                    iconButton: product == null
                        ? null
                        : IconWidget(
                            icon: Icons.delete,
                            onTap: () => bottomSheetConfirmDelete(() =>
                                bloc.add(EditorDeleteProductEvent(product!))),
                          )),
                SliverList(
                    delegate: SliverChildListDelegate([
                  const Space(isH: true, count: 3),
                  ProductImageWidget(image: bloc.image, bloc: bloc),
                  const Space(isH: true, count: 4),
                  FieldWidget(
                      hintText: 'hint_field_name_product'.tr(),
                      controller: bloc.nameController),
                  FieldWidget(
                      hintText: 'hint_field_unit'.tr(),
                      controller: bloc.unitController),
                  FieldWidget(
                      hintText: 'hint_field_details'.tr(),
                      controller: bloc.descriptionController),
                  ButtonWidget(
                      onTap: () {
                        if (product == null) {
                          bloc.add(EditorAddProductEvent());
                        } else {
                          bloc.add(EditorEditProductEvent(product!));
                        }
                      },
                      title: 'btn_validate'.tr())
                ])),
              ],
            );
          },
        ),
      ),
    ));
  }
}
