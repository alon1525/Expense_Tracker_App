import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense(this.addExpense, {super.key});
  final void Function(Expense expense) addExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  var savedTitleValue = '';
  double savedAmountValue = 0;
  List<String> currencyOptions = ['\$', '€', '₪'];
  String selectedCurrency = '₪';
  Category savedCategoryValue = Category.food;
  void _saveTitleInput(String inputValue) {
    savedTitleValue = inputValue;
  }

  void _saveCategoryInput(Category inputValue) {
    savedCategoryValue = inputValue;
  }

  DateTime? _selectedDate;

  void _datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpense() {
    if (savedTitleValue.isEmpty ||
        savedAmountValue <= 0 ||
        _selectedDate == null) {
      if (Platform.isIOS) {
        showCupertinoDialog(
            context: context,
            builder: ((context) => CupertinoAlertDialog(
                  title: const Text('Invalid Input'),
                  content: const Text('Please fill in all fields'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Okay'))
                  ],
                )));
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Invalid Input'),
            content: const Text('Please fill in all fields'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Okay'))
            ],
          ),
        );
      }
      return;
    } else {
      Expense newExpense = Expense(
        title: savedTitleValue,
        amount: savedAmountValue,
        category: savedCategoryValue,
        date: _selectedDate ?? DateTime.now(),
        currency: selectedCurrency,
      );
      widget.addExpense(newExpense);
      Navigator.pop(context);
    }
  }

  _saveCurrencyInput(String currencyCode) {
    selectedCurrency = currencyCode;
  }

  void _saveAmountInput(String inputValue) {
    try {
      savedAmountValue = double.parse(inputValue);
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, keyBoardSpace + 16),
        child: Column(
          children: [
            TextField(
              onChanged: _saveTitleInput,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Title'),
                contentPadding: EdgeInsets.fromLTRB(0, 8, 0, 0),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Row(
              children: [
                DropdownButton(
                  value: selectedCurrency,
                  iconSize: 10,
                  items: currencyOptions
                      .map(
                        (currency) => DropdownMenuItem(
                          value: currency,
                          child: Text(currency),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(
                        () {
                          _saveCurrencyInput(value);
                        },
                      );
                    }
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: TextField(
                      onChanged: _saveAmountInput,
                      maxLength: 50,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          label: Text('Amount'),
                          contentPadding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_selectedDate == null
                          ? 'No Date Selected'
                          : formatter.format(_selectedDate!)),
                      IconButton(
                        onPressed: _datePicker,
                        icon: const Icon(Icons.calendar_month_outlined),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                DropdownButton(
                  value: savedCategoryValue,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toString().toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(
                        () {
                          _saveCategoryInput(value);
                        },
                      );
                    }
                  },
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                    onPressed: () {
                      _submitExpense();
                    },
                    child: const Text('Save Expense')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
