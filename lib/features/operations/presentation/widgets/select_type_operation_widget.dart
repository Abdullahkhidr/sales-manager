import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';
import 'package:manager/features/operations/presentation/bloc/editor_operation/editor_operation_bloc.dart';

class SelectTypeOperationWidget extends StatelessWidget {
  final EditorOperationBloc bloc;
  const SelectTypeOperationWidget({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Item(text: "sale".tr(), bloc: bloc, typeOperation: TypeOperation.Sale),
        _Item(
            text: "refund".tr(),
            bloc: bloc,
            typeOperation: TypeOperation.Refund),
        _Item(text: "buy".tr(), bloc: bloc, typeOperation: TypeOperation.Buy),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final String text;
  final TypeOperation typeOperation;
  final EditorOperationBloc bloc;
  const _Item(
      {required this.text, required this.typeOperation, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () =>
            bloc.add(EditorOperationChangeTypeOperationEvent(typeOperation)),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              color: typeOperation == bloc.typeOperation
                  ? colorScheme.primary
                  : colorScheme.background,
              borderRadius: Sizes.borderRadius,
              border: Border.all(width: 0.3)),
          child: Text(text,
              style: Fonts.t3(
                  color: typeOperation == bloc.typeOperation
                      ? colorScheme.onPrimary
                      : null)),
        ),
      ),
    );
  }
}
