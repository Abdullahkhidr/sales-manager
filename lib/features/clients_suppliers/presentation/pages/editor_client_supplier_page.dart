import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/services/bottom_sheet_confirm_delete.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/widgets/app_bar_widget.dart';
import 'package:manager/core/widgets/button_widget.dart';
import 'package:manager/core/widgets/field_widget.dart';
import 'package:manager/core/widgets/icon_widget.dart';
import 'package:manager/core/widgets/space_widget.dart';
import 'package:manager/features/clients_suppliers/presentation/bloc/clients/clients_bloc.dart';
import 'package:manager/features/clients_suppliers/presentation/bloc/suppliers/suppliers_bloc.dart';

class EditorClientSupplierInfoPage extends StatelessWidget {
  final Either<ClientsBloc, SuppliersBloc> bloc;
  const EditorClientSupplierInfoPage({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.paddingScreen.left),
        child: CustomScrollView(
          slivers: [
            AppBarWidget(
                bloc.fold((l) => 'client'.tr(), (r) => 'supplier'.tr()),
                iconButton: _isEdit(bloc)
                    ? IconWidget(
                        icon: Icons.delete,
                        onTap: () => bottomSheetConfirmDelete(() {
                              bloc.fold((c) {
                                c.add(EditorDeleteClientEvent());
                              }, (s) {
                                s.add(EditorDeleteSupplierEvent());
                              });
                            }))
                    : null),
            SliverList(
                delegate: SliverChildListDelegate([
              const Space(isH: true, count: 3),
              FieldWidget(
                  hintText: 'hint_field_name'.tr(),
                  keyboardType: TextInputType.name,
                  controller: bloc.fold((clients) => clients.nameController,
                      (suppliers) => suppliers.nameController),
                  maxLines: 1),
              FieldWidget(
                  hintText: 'hint_field_phone'.tr(),
                  keyboardType: TextInputType.phone,
                  controller: bloc.fold((clients) => clients.phoneController,
                      (suppliers) => suppliers.phoneController),
                  maxLines: 1),
              FieldWidget(
                  hintText: 'hint_field_company'.tr(),
                  keyboardType: TextInputType.text,
                  controller: bloc.fold((clients) => clients.companyController,
                      (suppliers) => suppliers.companyController),
                  maxLines: 1),
              FieldWidget(
                  hintText: 'hint_field_notes'.tr(),
                  keyboardType: TextInputType.multiline,
                  controller: bloc.fold((clients) => clients.notesController,
                      (suppliers) => suppliers.notesController),
                  textInputAction: TextInputAction.newline),
              ButtonWidget(
                  onTap: () {
                    bloc.fold((clients) {
                      if (clients.id != null) {
                        clients.add(EditorEditClientEvent());
                      } else {
                        clients.add(EditorAddClientEvent());
                      }
                    }, (suppliers) {
                      if (suppliers.id != null) {
                        suppliers.add(EditorEditSupplierEvent());
                      } else {
                        suppliers.add(EditorAddSupplierEvent());
                      }
                    });
                  },
                  title: "btn_validate".tr())
            ]))
          ],
        ),
      ),
    );
  }
}

bool _isEdit(Either<ClientsBloc, SuppliersBloc> bloc) {
  return bloc.fold((l) {
    if (l.id != null) {
      return true;
    } else {
      return false;
    }
  }, (r) {
    if (r.id != null) {
      return true;
    } else {
      return false;
    }
  });
}
