import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      price: 23,
      dateTime: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Theatre',
      price: 18.88,
      dateTime: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _opedAddExpenseOverlay() { //Whit this we opened different page. Trust me it is different !!
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return const NewExpense();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter expense tracker'), actions: [
        IconButton(onPressed: _opedAddExpenseOverlay, icon: const Icon(Icons.add)),
      ]),
      body: Column(
        children: [
          const Text('The Chart'),
          Expanded(child: ExpensesList(expenses: _registeredExpenses)),
        ],
      ),
    );
  }
}
