import 'package:hive/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 9)
class Expense {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  double? cost;
  @HiveField(3)
  DateTime? date;
  @HiveField(4)
  String? details;

  Expense(
      {this.id, this.title = '', this.cost = 0, this.date, this.details = ''});
}
