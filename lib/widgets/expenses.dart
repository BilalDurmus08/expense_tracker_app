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

  void _opedAddExpenseOverlay() {
    //with this we opened different page. Trust me it is different !!
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(
          addOnList: _addExpenseToList,
        );
      },
    );
  }

  void _addExpenseToList(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _deleteExpenseFromList(Expense expense) {
    final indexOfExpense = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context)
        .clearSnackBars(); //If we have more than 1 snackBar at stack. This method delete them.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Deleted Expense'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(indexOfExpense, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Column(children: [
        SizedBox(
          height: 350,
        ),
        Text('There are no expenses currently. Please add some.')
      ]),
    ); //Just Center widget couldn't work. And I used different way to centered my Text Widget.
    if (_registeredExpenses.isNotEmpty) {
      mainContent = Expanded(
          child: ExpensesList(
        expenses: _registeredExpenses,
        onDeleteExpense: _deleteExpenseFromList,
      ));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter expense tracker'), actions: [
        IconButton(
            onPressed: _opedAddExpenseOverlay, icon: const Icon(Icons.add)),
      ]),
      body: Column(
        children: [
          const Text('The Chart'),
          mainContent,
        ],
      ),
    );
  }
}
