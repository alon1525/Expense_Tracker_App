import 'package:expense_tracker/widgets/expenses_list/ExpensesList.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'Chart/chart.dart';
import '../models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'flutter course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work,
        currency: '\$'),
    Expense(
        title: 'Shawarma',
        amount: 10.99,
        date: DateTime.now(),
        category: Category.food,
        currency: '\$')
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(addExpense);
        });
  }

  void deleteExpense(Expense expense) {
    final index = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  void addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  @override
  Widget build(context) {
    Widget mainWidget;
    if (_registeredExpenses.isNotEmpty) {
      mainWidget = ExpensesList(
          expensesList: _registeredExpenses, deleteExpense: deleteExpense);
    } else {
      mainWidget = const Center(
        child: Text('No expenses registered. Start adding some!'),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expense List",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(children: [
        Chart(expenses: _registeredExpenses),
        Expanded(child: mainWidget),
      ]),
    );
  }
}
