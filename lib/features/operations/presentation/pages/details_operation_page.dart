import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager/core/services/funds_text.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/core/widgets/app_bar_widget.dart';
import 'package:manager/core/widgets/icon_widget.dart';
import 'package:manager/core/widgets/space_widget.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';
import 'package:manager/features/operations/presentation/bloc/operations/operations_bloc.dart';
import 'package:manager/features/operations/presentation/pages/editor_operation_page.dart';

class DetailsOperationPage extends StatelessWidget {
  final Operation operation;

  const DetailsOperationPage({super.key, required this.operation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.paddingScreen.left),
          child: BlocProvider(
            create: (context) => OperationsBloc(),
            child: BlocBuilder<OperationsBloc, OperationsState>(
              builder: (context, state) {
                OperationsBloc bloc = context.read<OperationsBloc>();
                if (state is OperationsInitial) {
                  bloc.add(OperationsGetClientOrSupplierEvent(operation));
                  bloc.add(OperationsGetProductEvent(operation));
                }
                return CustomScrollView(
                  slivers: [
                    AppBarWidget('details_operation'.tr(),
                        iconButton: IconWidget(
                            icon: Icons.edit,
                            onTap: () => Nav.replace(EditorOperationPage(
                                operation: operation,
                                selectedClient: bloc.client,
                                selectedSupplier: bloc.supplier,
                                selectedProduct: bloc.product)))),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      const Space(isH: true, count: 3),
                      Text(
                          operation.typeOperation == TypeOperation.Buy
                              ? 'buy_operation'.tr()
                              : operation.typeOperation == TypeOperation.Refund
                                  ? 'refund_operation'.tr()
                                  : 'sale_operation'.tr(),
                          style: Fonts.t2(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600)),
                      const Space(isH: true, count: 3),
                      Text(
                          '${(operation.amount ?? 0) >= 0 ? '' : '-'}${fundsText(operation.amount ?? 0)}',
                          style: Fonts.t1(
                              fontWeight: FontWeight.w700,
                              color: (operation.amount ?? 0) >= 0
                                  ? Colors.green[500]
                                  : Colors.red[500])),
                      const Space(isH: true, count: 3),
                      Text(
                          DateFormat.yMMMMEEEEd()
                              .format(operation.date ?? DateTime.now()),
                          style: Fonts.t5()),
                      _ItemData(
                          text: (operation.typeOperation == TypeOperation.Buy
                                  ? '${'supplier'.tr()} : '
                                  : '${'client'.tr()} : ') +
                              (bloc.client?.name ?? bloc.supplier?.name ?? '')),
                      _ItemData(
                          text:
                              '${'product'.tr()} : ${bloc.product?.name ?? ''}'),
                      _ItemData(
                          text:
                              '${'hint_field_quantity'.tr()} : ${operation.quantity ?? ''} ${bloc.product?.unit ?? ''}'),
                      const Space(isH: true, count: 4),
                      Text('hint_field_notes'.tr(),
                          style: Fonts.t3(fontWeight: FontWeight.w600)),
                      const Space(isH: true, count: 2),
                      Text(operation.notes ?? '', style: Fonts.t5()),
                    ]))
                  ],
                );
              },
            ),
          )),
    );
  }
}

class _ItemData extends StatelessWidget {
  final String text;
  const _ItemData({required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Space(isH: true, count: 3),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: colorScheme.secondary.withAlpha(10)),
          child: Text(text, style: Fonts.t3(fontWeight: FontWeight.w600)),
        )
      ],
    );
  }
}
