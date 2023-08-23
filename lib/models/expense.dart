import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining_outlined,
  Category.leisure: Icons.movie_creation_outlined,
  Category.travel: Icons.flight_outlined,
  Category.work: Icons.work_outline
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category,
      required this.currency})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  final String currency;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();
  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (Expense expense in expenses) {
      if (expense.currency == '\$') {
        sum = sum + expense.amount * 3.7;
      } else if (expense.currency == '€') {
        sum = sum + (expense.amount * 4.05);
      } else {
        sum = sum + expense.amount;
      }
    }
    return double.parse(sum.toStringAsFixed(2));
  }
}
