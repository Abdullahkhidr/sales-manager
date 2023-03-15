import 'package:flutter/material.dart';
import 'package:manager/core/widgets/operation_widget.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';

class ListOperations extends StatelessWidget {
  final List<Operation> operations;
  const ListOperations({super.key, required this.operations});

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) =>
                ItemOperationWidget(operation: operations[index]),
            childCount: operations.length));
  }
}
