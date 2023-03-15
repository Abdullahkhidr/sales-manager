import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/features/clients_suppliers/domain/entities/client.dart';
import 'package:manager/features/clients_suppliers/domain/entities/supplier.dart';
import 'package:manager/features/operations/presentation/bloc/editor_operation/editor_operation_bloc.dart';
import 'package:manager/features/operations/presentation/widgets/select_options_widget.dart';

class SelectClientOrSupplierWidget extends StatelessWidget {
  final EditorOperationBloc bloc;
  final bool isClient;
  const SelectClientOrSupplierWidget(
      {super.key, required this.bloc, this.isClient = true});

  @override
  Widget build(BuildContext context) {
    return SelectOptionWidget(
      typeOptions: isClient ? 'client'.tr() : 'supplier'.tr(),
      textSelectedOption: isClient
          ? (bloc.client?.name ?? 'select_client'.tr())
          : (bloc.supplier?.name ?? 'select_supplier'.tr()),
      itemBuilder: List.generate(
          isClient ? bloc.clients.length : bloc.suppliers.length,
          (index) => _item(bloc,
              client: isClient
                  ? (bloc.clients.isEmpty ? null : bloc.clients[index])
                  : null,
              supplier: !isClient
                  ? (bloc.suppliers.isEmpty ? null : bloc.suppliers[index])
                  : null)),
    );
  }
}

PopupMenuItem _item(EditorOperationBloc bloc,
        {Client? client, Supplier? supplier}) =>
    PopupMenuItem(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
        onTap: () {
          if (client != null) {
            bloc.add(EditorOperationChangeClientEvent(client));
          } else {
            bloc.add(EditorOperationChangeSupplierEvent(supplier!));
          }
        },
        child: SizedBox(
          width: double.maxFinite,
          child: ListTile(
            tileColor: colorScheme.secondary.withAlpha(13),
            leading: CircleAvatar(
                radius: Sizes.size(10),
                backgroundColor: colorScheme.secondary.withAlpha(10),
                child: Text(
                    client != null
                        ? (client.name?[0].toUpperCase() ?? '')
                        : (supplier!.name?[0].toUpperCase() ?? ''),
                    style: Fonts.t3())),
            title: Text(
                client != null ? (client.name ?? '') : (supplier?.name ?? ''),
                style: Fonts.t4()),
            subtitle: Text(
                client != null
                    ? (client.company ?? '')
                    : (supplier!.company ?? ''),
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: Fonts.t5()),
          ),
        ));
