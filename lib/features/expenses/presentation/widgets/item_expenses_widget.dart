import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/constants/constants.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/features/expenses/domain/entities/expense.dart';
import 'package:manager/features/expenses/presentation/pages/details_expense_page.dart';

class ItemExpensesWidget extends StatelessWidget {
  final Expense expense;
  const ItemExpensesWidget({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: ListTile(
        onTap: () => Nav.to(DetailsExpensePage(expense: expense)),
        contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 13),
        minLeadingWidth: 0,
        tileColor: colorScheme.secondary.withAlpha(10),
        shape: RoundedRectangleBorder(borderRadius: Sizes.borderRadius),
        subtitle: Text(
            DateFormat.yMMMEd().format(expense.date ?? DateTime.now()),
            style: Fonts.t6(fontWeight: FontWeight.w600)),
        trailing: Text('${expense.cost} $currency',
            style:
                Fonts.t4(color: Colors.red[700], fontWeight: FontWeight.w500)),
        title: Text(expense.title.toString(),
            style: Fonts.t3(
                color: colorScheme.primary, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
