import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager/core/services/bottom_sheet_confirm_delete.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/widgets/app_bar_widget.dart';
import 'package:manager/core/widgets/button_widget.dart';
import 'package:manager/core/widgets/field_widget.dart';
import 'package:manager/core/widgets/icon_widget.dart';
import 'package:manager/core/widgets/space_widget.dart';
import 'package:manager/features/expenses/domain/entities/expense.dart';
import 'package:manager/features/expenses/presentation/bloc/editor_expense/editor_expense_bloc.dart';

class EditorExpensePage extends StatelessWidget {
  final Expense? expense;
  const EditorExpensePage({super.key, this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.paddingScreen.left),
      child: BlocProvider(
        create: (context) => EditorExpenseBloc(),
        child: BlocBuilder<EditorExpenseBloc, EditorExpenseState>(
          builder: (context, state) {
            EditorExpenseBloc bloc = context.read<EditorExpenseBloc>();
            if (expense != null && state is EditorExpenseInitial) {
              bloc.add(EditorExpenseSetDateEvent(expense!));
            }

            return CustomScrollView(
              slivers: [
                AppBarWidget('expense'.tr(),
                    iconButton: expense == null
                        ? null
                        : IconWidget(
                            icon: Icons.delete,
                            onTap: () => bottomSheetConfirmDelete(
                                () => bloc.add(EditorExpenseDeleteEvent())),
                          )),
                SliverList(
                    delegate: SliverChildListDelegate([
                  const Space(isH: true, count: 3),
                  FieldWidget(
                      hintText: 'hint_field_title'.tr(),
                      controller: bloc.titleController),
                  FieldWidget(
                    keyboardType: TextInputType.number,
                    hintText: 'hint_field_cost'.tr(),
                    controller: bloc.costController,
                  ),
                  FieldWidget(
                      hintText: 'Date',
                      controller: bloc.dateTimeController,
                      keyboardType: TextInputType.datetime,
                      onTap: () {
                        bloc.add(EditorExpensePickDateEvent());
                      },
                      readOnly: true),
                  FieldWidget(
                    hintText: 'hint_field_details'.tr(),
                    controller: bloc.detailsController,
                    keyboardType: TextInputType.multiline,
                  ),
                  ButtonWidget(
                      onTap: () {
                        if (expense == null) {
                          bloc.add(EditorExpenseAddEvent());
                        } else {
                          bloc.add(EditorExpenseEditEvent());
                        }
                      },
                      title: 'btn_validate'.tr())
                ])),
              ],
            );
          },
        ),
      ),
    ));
  }
}
