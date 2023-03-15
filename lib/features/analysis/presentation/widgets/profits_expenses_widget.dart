import 'package:flutter/material.dart';
import 'package:manager/core/services/funds_text.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/core/widgets/space_widget.dart';

class ProfitsExpensesWidget extends StatelessWidget {
  final double sales;
  final double expense;
  const ProfitsExpensesWidget(
      {super.key, required this.sales, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: colorScheme.primary),
      padding: EdgeInsets.only(top: Sizes.paddingScreen.top),
      child: Column(
        children: [
          Text(
              '${(expense * -1) > sales ? '-' : ''}${fundsText(sales + expense)}',
              textAlign: TextAlign.center,
              style: Fonts.t1(color: colorScheme.onPrimary)),
          const Space(isH: true, count: 3),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: colorScheme.background,
                boxShadow: [
                  BoxShadow(
                      color: colorScheme.primary,
                      blurRadius: 2,
                      spreadRadius: -1)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(fundsText(sales),
                    textAlign: TextAlign.center,
                    style: Fonts.t3(
                        color: Colors.green[400], fontWeight: FontWeight.w600)),
                Text(fundsText(expense),
                    textAlign: TextAlign.center,
                    style: Fonts.t3(
                        color: Colors.red[400], fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
