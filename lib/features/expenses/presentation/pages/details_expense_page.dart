import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/constants/constants.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/widgets/app_bar_widget.dart';
import 'package:manager/core/widgets/icon_widget.dart';
import 'package:manager/core/widgets/space_widget.dart';
import 'package:manager/features/expenses/domain/entities/expense.dart';
import 'package:manager/features/expenses/presentation/pages/editor_expense_page.dart';

class DetailsExpensePage extends StatelessWidget {
  final Expense expense;
  const DetailsExpensePage({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.paddingScreen.left),
        child: CustomScrollView(
          slivers: [
            AppBarWidget('hint_field_details'.tr(),
                iconButton: IconWidget(
                    icon: Icons.edit,
                    onTap: () =>
                        Nav.replace(EditorExpensePage(expense: expense)))),
            SliverList(
                delegate: SliverChildListDelegate([
              Text(expense.title.toString(), style: Fonts.t3()),
              const Space(isH: true, count: 3),
              Text(
                  DateFormat.yMMMMEEEEd()
                      .format(expense.date ?? DateTime.now()),
                  style: Fonts.t6()),
              const Space(isH: true, count: 3),
              Text("${expense.cost.toString()} $currency",
                  style: Fonts.t1(color: Colors.red[700])),
              const Space(isH: true, count: 3),
              Text('hint_field_details'.tr().tr(), style: Fonts.t3()),
              const Space(isH: true, count: 3),
              Text(expense.details.toString(), style: Fonts.t5()),
            ]))
          ],
        ),
      ),
    );
  }
}
