import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/widgets/field_widget.dart';
import 'package:manager/core/widgets/icon_widget.dart';
import 'package:manager/features/clients_suppliers/presentation/bloc/clients/clients_bloc.dart';
import 'package:manager/features/clients_suppliers/presentation/bloc/suppliers/suppliers_bloc.dart';

class SearchBarWidget extends StatelessWidget {
  final Either<ClientsBloc, SuppliersBloc> bloc;
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
            bloc.fold((l) => l.add(ClientsSearchEvent(v)),
                (r) => r.add(SuppliersSearchEvent(v)));
          },
        )),
        const IconWidget(icon: Icons.search),
        // const IconWidget(icon: Icons.sort),
      ],
    );
  }
}
