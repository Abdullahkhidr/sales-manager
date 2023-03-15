import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/features/clients_suppliers/domain/entities/client.dart';
import 'package:manager/features/clients_suppliers/domain/entities/supplier.dart';
import 'package:manager/features/clients_suppliers/presentation/bloc/clients/clients_bloc.dart';
import 'package:manager/features/clients_suppliers/presentation/bloc/suppliers/suppliers_bloc.dart';
import 'package:manager/features/clients_suppliers/presentation/pages/details_client_supplier_page.dart';

import '../../../../core/constants/constants.dart';

class ItemClientSupplierWidget extends StatelessWidget {
  final Client? client;
  final Supplier? supplier;
  final Either<ClientsBloc, SuppliersBloc> bloc;
  const ItemClientSupplierWidget(
      {super.key, this.client, this.supplier, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 14),
        onTap: () {
          bloc.fold((l) {
            l.add(ClientsGetOperationsOfClient(client ?? Client()));
            Nav.to(DetailsClientSupplierPage(bloc: bloc, model: Left(client!)));
          }, (r) {
            r.add(EditorGetOperationsOfSupplier(supplier ?? Supplier()));
            Nav.to(
                DetailsClientSupplierPage(bloc: bloc, model: Right(supplier!)));
          });
        },
        tileColor: colorScheme.primary.withAlpha(10),
        shape: RoundedRectangleBorder(borderRadius: Sizes.borderRadius),
        leading: CircleAvatar(
            radius: Sizes.size(12),
            backgroundColor: colorScheme.secondary.withAlpha(20),
            child: Text(
                (client?.name! ?? supplier!.name!).toString()[0].toUpperCase(),
                style: Fonts.t3())),
        title: Text(client?.name ?? supplier!.name!,
            style: Fonts.t3(fontWeight: FontWeight.w600)),
        subtitle:
            Text(client?.company ?? supplier!.company!, style: Fonts.t5()),
        trailing: Text(
            '${client?.salesAmount ?? supplier?.purchasesAmount ?? 0} $currency',
            style: Fonts.t4(
                fontWeight: FontWeight.w600,
                color:
                    ((client?.salesAmount ?? supplier?.purchasesAmount) ?? 0) >=
                            0
                        ? Colors.green[400]
                        : Colors.red[400])),
      ),
    );
  }
}
