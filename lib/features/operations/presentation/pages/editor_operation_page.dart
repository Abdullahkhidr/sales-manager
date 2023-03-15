import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager/core/services/bottom_sheet_confirm_delete.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/widgets/app_bar_widget.dart';
import 'package:manager/core/widgets/button_widget.dart';
import 'package:manager/core/widgets/field_widget.dart';
import 'package:manager/core/widgets/icon_widget.dart';
import 'package:manager/core/widgets/space_widget.dart';
import 'package:manager/features/clients_suppliers/domain/entities/client.dart';
import 'package:manager/features/clients_suppliers/domain/entities/supplier.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';
import 'package:manager/features/operations/presentation/bloc/editor_operation/editor_operation_bloc.dart';
import 'package:manager/features/operations/presentation/widgets/select_client_or_supplier_widget.dart';
import 'package:manager/features/operations/presentation/widgets/select_product_widget.dart';
import 'package:manager/features/operations/presentation/widgets/select_type_operation_widget.dart';
import 'package:manager/features/products/domain/entities/product.dart';

class EditorOperationPage extends StatelessWidget {
  final Operation? operation;
  final Product? selectedProduct;
  final Client? selectedClient;
  final Supplier? selectedSupplier;
  const EditorOperationPage(
      {super.key,
      this.operation,
      this.selectedProduct,
      this.selectedClient,
      this.selectedSupplier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<EditorOperationBloc>(
        create: (_) => EditorOperationBloc(),
        child: BlocBuilder<EditorOperationBloc, EditorOperationState>(
            builder: (context, state) {
          EditorOperationBloc bloc = context.read<EditorOperationBloc>();
          if (state is EditorOperationInitial) {
            bloc.add(EditorOperationInitEvent());
            if (operation != null) {
              bloc.add(EditorOperationSetOperationDateEvent(operation!,
                  selectedProduct, selectedSupplier, selectedClient));
            }
          }
          return Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Sizes.paddingScreen.left),
              child: CustomScrollView(
                slivers: [
                  AppBarWidget('operation'.tr(),
                      iconButton: operation == null
                          ? null
                          : IconWidget(
                              icon: Icons.delete,
                              onTap: () => bottomSheetConfirmDelete(() =>
                                  bloc.add(EditorOperationDeleteEvent(
                                      bloc.operation))),
                            )),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    const Space(isH: true, count: 4),
                    SelectTypeOperationWidget(bloc: bloc),
                    const Space(isH: true, count: 3),
                    SelectProductWidget(bloc: bloc),
                    const Space(isH: true, count: 3),
                    SelectClientOrSupplierWidget(
                        bloc: bloc,
                        isClient: bloc.typeOperation != TypeOperation.Buy),
                    const Space(isH: true, count: 3),
                    FieldWidget(
                      hintText: 'Date',
                      maxLines: 1,
                      readOnly: true,
                      controller: bloc.dateController,
                      onTap: () => bloc.add(EditorOperationPickDateEvent()),
                    ),
                    FieldWidget(
                        hintText: 'hint_field_quantity'.tr(),
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        controller: bloc.quantityController,
                        endIcon: Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(
                                minWidth: 0, maxWidth: Sizes.size(50)),
                            child: Text(bloc.product?.unit ?? '',
                                style: Fonts.t6()))),
                    if (bloc.product?.remaining != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                            'msg_remaining_quantity'.tr(namedArgs: {
                              'quantity':
                                  (bloc.product?.remaining ?? '0').toString(),
                              'unit': bloc.product?.unit ?? ''
                            }),
                            style: Fonts.t6()),
                      ),
                    FieldWidget(
                        hintText: 'hint_field_amount'.tr(),
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        controller: bloc.amountController),
                    FieldWidget(
                        hintText: 'hint_field_notes'.tr(),
                        keyboardType: TextInputType.multiline,
                        controller: bloc.notesController),
                    ButtonWidget(
                        onTap: () {
                          bloc.add(operation != null
                              ? EditorOperationEditEvent(bloc.operation)
                              : EditorOperationAddEvent(bloc.operation));
                        },
                        title: 'btn_validate'.tr()),
                  ]))
                ],
              ));
        }),
      ),
    );
  }
}
