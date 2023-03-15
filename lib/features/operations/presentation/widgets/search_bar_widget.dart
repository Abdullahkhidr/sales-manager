import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/widgets/field_widget.dart';
import 'package:manager/core/widgets/icon_widget.dart';
import 'package:manager/features/operations/presentation/bloc/operations/operations_bloc.dart';

class OperationsSearchBarWidget extends StatelessWidget {
  final OperationsBloc bloc;
  const OperationsSearchBarWidget({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: FieldWidget(
          hintText: 'search'.tr(),
          maxLines: 1,
          onChange: (v) {
            // bloc.add(OperationsAddEvent(v));
          },
        )),
        const IconWidget(icon: Icons.search),
        IconWidget(
          icon: Icons.sort,
          onTap: () => bloc.add(OperationsOpenSortFilterOptionsEvent()),
        ),
      ],
    );
  }
}
