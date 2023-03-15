import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';
import 'package:manager/features/operations/presentation/pages/details_operation_page.dart';

import '../constants/constants.dart';

class ItemOperationWidget extends StatelessWidget {
  final Operation? operation;
  const ItemOperationWidget({super.key, this.operation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: ListTile(
        onTap: () {
          if (operation != null) {
            Nav.to(DetailsOperationPage(operation: operation!));
          }
        },
        contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 13),
        minLeadingWidth: 0,
        tileColor: colorScheme.primary.withAlpha(5),
        shape: RoundedRectangleBorder(borderRadius: Sizes.borderRadius),
        leading: CircleAvatar(
            radius: Sizes.size(11),
            backgroundColor: colorScheme.primary.withAlpha(10),
            child: Text(
                operation?.typeOperation == TypeOperation.Sale ? '+' : '-',
                style: Fonts.t1(
                    color: colorScheme.primary, fontWeight: FontWeight.w600))),
        title: Text(
            DateFormat.yMMMEd().format(operation?.date ?? DateTime.now()),
            style: Fonts.t5(fontWeight: FontWeight.w600)),
        trailing: Text('${operation?.amount} $currency',
            style: Fonts.t4(
                color: operation?.amount != null && operation!.amount! >= 0
                    ? Colors.green[700]
                    : Colors.red[700],
                fontWeight: FontWeight.w500)),
        subtitle: Text(
            operation?.typeOperation == TypeOperation.Buy
                ? 'buy'.tr()
                : operation?.typeOperation == TypeOperation.Refund
                    ? 'refund'.tr()
                    : 'sale',
            style: Fonts.t5(
                color: colorScheme.primary, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
