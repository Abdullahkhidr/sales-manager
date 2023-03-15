import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/core/widgets/line_widget.dart';
import 'package:manager/core/widgets/space_widget.dart';
import 'package:manager/features/products/presentation/bloc/products/products_bloc.dart';

class FilterSortWidget extends StatelessWidget {
  final SortBy currentTypeSort;
  final Function(SortBy) onChange;
  const FilterSortWidget(
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
            title: 'sort_newest'.tr(),
            groupValue: currentTypeSort,
            value: SortBy.Newest,
            onTap: (v) => onChange(v),
          ),
          _ItemSort(
              title: 'sort_older'.tr(),
              groupValue: currentTypeSort,
              value: SortBy.Older,
              onTap: (v) => onChange(v)),
        ],
      ),
    );
  }
}

class _ItemSort extends StatelessWidget {
  final String title;
  final SortBy value;
  final SortBy groupValue;
  final Function(SortBy) onTap;
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
      child: RadioListTile<SortBy>(
        value: value,
        title: Text(title, style: Fonts.t3()),
        groupValue: groupValue,
        onChanged: (value) {
          onTap(value ?? SortBy.Newest);
        },
      ),
    );
  }
}
