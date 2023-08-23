import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expensesList, required this.deleteExpense});
  final List<Expense> expensesList;
  final void Function(Expense expense) deleteExpense;

  void addExpense(value) {
    expensesList.add(value);
  }

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (ctx, index) => Dismissible(
        onDismissed: (direction) {
          deleteExpense(expensesList[index]);
        },
        key: ValueKey(expensesList[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.5),
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        child: ExpenseItem(expensesList[index]),
      ),
    );
  }
}
