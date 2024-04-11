import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          children: [
            Text(expense.title, style: const TextStyle(fontWeight: FontWeight.w500),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(children: [
                Text('\$${expense.price.toStringAsFixed(2)}'),
                const Spacer(),
                Row(children:[
                  Icon(categoryIcons[expense.category]),
                  const SizedBox(width: 10,),
                  Text(expense.formattedDate),
                ],)
              ],),
            )
          ],
        ),
      ),
    );
  }

}
