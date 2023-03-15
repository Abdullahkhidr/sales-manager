import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/core/widgets/line_widget.dart';
import 'package:manager/core/widgets/space_widget.dart';
import 'package:manager/features/store/presentation/bloc/store/store_bloc.dart';

class FilterSortStoreProductWidget extends StatelessWidget {
  final SortTypeStoreProduct currentTypeSort;
  final Function(SortTypeStoreProduct) onChange;
  const FilterSortStoreProductWidget(
      {super.key, required this.currentTypeSort, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Sizes.paddingScreen,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('sort'.tr(), style: Fonts.t2()),
          const Space(isH: true, count: 3),
          const LineWidget(),
          const Space(isH: true, count: 3),
          _ItemSort(
            title: 'sort_most_quantitive'.tr(),
            groupValue: currentTypeSort,
            value: SortTypeStoreProduct.mostQuantitative,
            onTap: (v) => onChange(v),
          ),
          _ItemSort(
            title: 'sort_least_quantity'.tr(),
            groupValue: currentTypeSort,
            value: SortTypeStoreProduct.leastQuantity,
            onTap: (v) => onChange(v),
          ),
        ],
      ),
    );
  }
}

class _ItemSort extends StatelessWidget {
  final String title;
  final SortTypeStoreProduct value;
  final SortTypeStoreProduct groupValue;
  final Function(SortTypeStoreProduct) onTap;
  const _ItemSort(
      {required this.title,
      required this.value,
      required this.groupValue,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          radioTheme: RadioThemeData(
              fillColor: MaterialStateProperty.all(colorScheme.secondary))),
      child: RadioListTile<SortTypeStoreProduct>(
        value: value,
        title: Text(title, style: Fonts.t3()),
        groupValue: groupValue,
        onChanged: (value) {
          onTap(value ?? SortTypeStoreProduct.mostQuantitative);
        },
      ),
    );
  }
}
