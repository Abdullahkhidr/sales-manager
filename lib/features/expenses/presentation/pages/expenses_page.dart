import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/widgets/app_bar_widget.dart';
import 'package:manager/core/widgets/empty_widget.dart';
import 'package:manager/core/widgets/floating_button_add_widget.dart';
import 'package:manager/core/widgets/space_widget.dart';
import 'package:manager/features/expenses/presentation/bloc/expenses/expenses_bloc.dart';
import 'package:manager/features/expenses/presentation/pages/editor_expense_page.dart';
import 'package:manager/features/expenses/presentation/widgets/item_expenses_widget.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.paddingScreen.left),
        child: BlocProvider(
          create: (context) => ExpensesBloc(),
          child: BlocBuilder<ExpensesBloc, ExpensesState>(
            builder: (context, state) {
              ExpensesBloc bloc = context.read<ExpensesBloc>();
              if (state is ExpensesInitial) bloc.add(ExpensesGetAllEvent());
              return CustomScrollView(
                slivers: [
                  AppBarWidget('title_expenses'.tr()),
                  // SliverToBoxAdapter(child: SearchBarWidget(bloc: bloc)),
                  // if (bloc.state is ProductsResultSearchState)
                  //   SliverList(
                  //       delegate: SliverChildBuilderDelegate(
                  //           (context, index) => const ItemExpensesWidget()))
                  // else
                  if (bloc.expenses != null && bloc.expenses!.isEmpty)
                    SliverToBoxAdapter(
                        child: EmptyWidget(
                            msg: 'msg_no_expenses'.tr(),
                            nameLottieFile: 'expenses')),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => ItemExpensesWidget(
                              expense: bloc.expenses![index]),
                          childCount: bloc.expenses?.length ?? 0)),
                  const SliverToBoxAdapter(child: Space(isH: true, count: 4))
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingButtonAddWidget(
          onTap: () => Nav.to(const EditorExpensePage()),
          title: 'btn_add_expense'.tr()),
    );
  }
}
