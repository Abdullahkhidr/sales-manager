import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/core/widgets/field_widget.dart';
import 'package:manager/core/widgets/icon_widget.dart';
import 'package:manager/features/store/presentation/bloc/store/store_bloc.dart';
import 'package:manager/features/store/presentation/widgets/filter_sort_widget.dart';

class StoreSearchBarWidget extends StatelessWidget {
  final StoreBloc bloc;
  const StoreSearchBarWidget({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: FieldWidget(
          hintText: 'search'.tr(),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          maxLines: 1,
          onChange: (v) {
            bloc.add(StoreSearchEvent(v));
          },
        )),
        const IconWidget(icon: Icons.search),
        IconWidget(
          icon: Icons.sort,
          onTap: () async {
            await showModalBottomSheet(
                context: context,
                backgroundColor: colorScheme.background,
                builder: (context) => FilterSortStoreProductWidget(
                    currentTypeSort: bloc.sortType,
                    onChange: (typeSort) {
                      Nav.back;
                      bloc.add(StoreSortEvent(typeSort));
                    }));
          },
        ),
      ],
    );
  }
}
