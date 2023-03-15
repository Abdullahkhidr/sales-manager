import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/constants/constants.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/core/widgets/app_bar_widget.dart';
import 'package:manager/core/widgets/icon_widget.dart';
import 'package:manager/core/widgets/line_widget.dart';
import 'package:manager/core/widgets/space_widget.dart';
import 'package:manager/features/clients_suppliers/domain/entities/client.dart';
import 'package:manager/features/clients_suppliers/domain/entities/supplier.dart';
import 'package:manager/features/clients_suppliers/presentation/bloc/clients/clients_bloc.dart';
import 'package:manager/features/clients_suppliers/presentation/bloc/suppliers/suppliers_bloc.dart';
import 'package:manager/features/clients_suppliers/presentation/pages/editor_client_supplier_page.dart';

import '../../../../core/widgets/operation_widget.dart';

class DetailsClientSupplierPage extends StatelessWidget {
  final Either<Client, Supplier> model;
  final Either<ClientsBloc, SuppliersBloc> bloc;
  const DetailsClientSupplierPage(
      {super.key, required this.model, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.paddingScreen.left),
        child: CustomScrollView(
          slivers: [
            AppBarWidget(
                model.fold((client) => 'title_about_client'.tr(),
                    (supplier) => 'title_about_supplier'.tr()),
                iconButton: IconWidget(
                    icon: Icons.edit,
                    onTap: () {
                      bloc.fold((clients) {
                        model.fold((client) {
                          clients.setDate(client);
                        }, (r) => null);
                      }, (suppliers) {
                        model.fold((l) => null, (supplier) {
                          suppliers.setDate(supplier);
                        });
                      });
                      Nav.to(EditorClientSupplierInfoPage(bloc: bloc));
                    })),
            SliverList(
                delegate: SliverChildListDelegate([
              const Space(isH: true, count: 3),
              CircleAvatar(
                  radius: Sizes.size(17),
                  backgroundColor: colorScheme.secondary.withAlpha(30),
                  child: Text(
                      model.fold((client) => client.name![0],
                          (supplier) => supplier.name![0]),
                      style: Fonts.t2())),
              const Space(isH: true, count: 3),
              Text(
                  model.fold((client) => client.name ?? '',
                      (supplier) => supplier.name ?? ''),
                  textAlign: TextAlign.center,
                  style: Fonts.t3(fontWeight: FontWeight.w600)),
              const Space(isH: true, count: 2),
              Text(
                  model.fold((client) => client.company ?? '',
                      (supplier) => supplier.company ?? ''),
                  textAlign: TextAlign.center,
                  style: Fonts.t6()),
              const Space(isH: true, count: 4),
              Container(
                padding: const EdgeInsets.all(10),
                decoration:
                    BoxDecoration(color: colorScheme.secondary.withAlpha(10)),
                child: Text(
                    model.fold((client) => client.notes ?? '',
                        (supplier) => supplier.notes ?? ''),
                    textAlign: TextAlign.center,
                    style: Fonts.t3(fontWeight: FontWeight.w600)),
              ),
              const Space(isH: true, count: 3),
              Text(
                  '${model.fold((l) => l.salesAmount, (r) => r.purchasesAmount)} $currency',
                  textAlign: TextAlign.center,
                  style: Fonts.t1(
                      fontWeight: FontWeight.w600,
                      color: model.fold(
                          (l) => (l.salesAmount ?? 0) >= 0
                              ? Colors.green[500]
                              : Colors.red[500],
                          (r) => (r.purchasesAmount ?? 0) >= 0
                              ? Colors.green[500]
                              : Colors.red[500]))),
              const Space(isH: true, count: 3),
              const LineWidget(),
              const Space(isH: true, count: 3),
              Text(
                  model.fold((client) => 'title_operations_client'.tr(),
                      (supplier) => 'title_operations_supplier'.tr()),
                  textAlign: TextAlign.start,
                  style: Fonts.t3(
                      fontWeight: FontWeight.w700, color: colorScheme.primary)),
            ])),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => ItemOperationWidget(
                        operation: bloc.fold((l) => l.operationsOfClient[index],
                            (r) => r.operationsOfSupplier?[index])),
                    childCount: bloc.fold((l) => l.operationsOfClient.length,
                        (r) => r.operationsOfSupplier?.length ?? 0)))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          model.fold((client) {
            bloc.fold((l) => l.add(ClientsMakeCallEvent(client)), (r) => null);
          }, (supplier) {
            bloc.fold(
                (l) => null, (r) => r.add(SuppliersMakeCallEvent(supplier)));
          });
        },
        child: const Icon(Icons.call),
      ),
    );
  }
}
