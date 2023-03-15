import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/widgets/field_widget.dart';
import 'package:manager/core/widgets/icon_widget.dart';
import 'package:manager/features/products/presentation/bloc/products/products_bloc.dart';

class SearchBarWidget extends StatelessWidget {
  final ProductsBloc bloc;
  const SearchBarWidget({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: FieldWidget(
          hintText: 'search'.tr(),
          maxLines: 1,
          onChange: (v) {
            bloc.add(ProductsSearchEvent(v));
          },
        )),
        const IconWidget(icon: Icons.search),
        IconWidget(
          icon: Icons.sort,
          onTap: () => bloc.add(ProductsOpenSortFilterOptionsEvent()),
        ),
      ],
    );
  }
}
