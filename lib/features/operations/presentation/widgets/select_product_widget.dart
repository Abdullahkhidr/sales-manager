import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/features/operations/presentation/bloc/editor_operation/editor_operation_bloc.dart';
import 'package:manager/features/operations/presentation/widgets/select_options_widget.dart';
import 'package:manager/features/products/domain/entities/product.dart';

class SelectProductWidget extends StatelessWidget {
  final EditorOperationBloc bloc;
  const SelectProductWidget({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return SelectOptionWidget(
      typeOptions: 'product'.tr(),
      textSelectedOption: bloc.product?.name ?? 'select_product'.tr(),
      itemBuilder: List.generate(
          bloc.products.length, (index) => _item(bloc.products[index], bloc)),
    );
  }
}

PopupMenuItem _item(Product product, EditorOperationBloc bloc) => PopupMenuItem(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
    onTap: () => bloc.add(EditorOperationChangeProductEvent(product)),
    child: ListTile(
      tileColor: colorScheme.secondary.withAlpha(13),
      leading: CircleAvatar(
          backgroundImage:
              product.image == null ? null : MemoryImage(product.image!),
          radius: Sizes.size(10),
          backgroundColor: colorScheme.secondary.withAlpha(10)),
      title: Text(product.name!, style: Fonts.t4()),
      trailing: Text(product.remaining.toString(), style: Fonts.t5()),
      subtitle: product.description!.isEmpty
          ? null
          : Text(product.description!,
              maxLines: 1, overflow: TextOverflow.clip, style: Fonts.t6()),
    ));
