import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addOnList});

  final void Function(Expense expense) addOnList;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController =
      TextEditingController(); //The controller does all the job. Convert the message to string I guess ?
  final _amountController = TextEditingController();
  DateTime? _pickedDate;
  Category _selectedCategory = Category.leisure;

  void _pickDate() async {
    final now = DateTime.now();
    final fistDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: fistDate,
      lastDate: now,
    );
    setState(() {
      _pickedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final amountExpense = double.tryParse(_amountController.text);
    final amountIsInvalid = amountExpense == null || amountExpense < 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _pickedDate == null) {
      showDialog(
        context: context,
        builder: ((ctx) => AlertDialog(
              title: const Text('Alert !!'),
              content: const Text(
                  'Please input correctly title, amount, date, category'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Okay'),
                ),
              ],
            )),
      );
      return;
    }
    widget.addOnList(Expense(
        dateTime: _pickedDate!,
        price: amountExpense,
        title: _titleController.text,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    //We should dispose controllers. Otherwise the memory will be full with these unnecessary data.
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context)
        .viewInsets
        .bottom; //With this, when we open the keyboard. We can scroll the page.
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + keyboardSpace),
          child: Column(
            children: [
              TextField(
                style: const TextStyle(color: Colors.black),
                controller: _titleController,
                maxLength: 50,
                cursorColor: Colors.amber.shade200,
                decoration: const InputDecoration(
                  label: Text('Text'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      controller: _amountController,
                      maxLength: 10,
                      decoration: const InputDecoration(
                        prefixText: '\$',
                        label: Text('Amount'),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(_pickedDate == null
                            ? 'Pick a date'
                            : formatter.format(_pickedDate!)),
                        IconButton(
                          onPressed: _pickDate,
                          icon: const Icon(Icons.date_range),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  DropdownButton(
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = value;
                        });
                      }),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _submitExpenseData();
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
