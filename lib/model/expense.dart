import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd(); 

enum Category { food, travel, leisure, work }

 const categoryIcons = {
    Category.food: Icons.lunch_dining,
    Category.leisure: Icons.movie,
    Category.travel: Icons.flight_takeoff,
    Category.work: Icons.work,
};

class Expense {
  Expense(
      {required this.dateTime,
      required this.price,
      required this.title,
      required this.category})
      : id = uuid.v4(); //I gave unique value for "id" automatically.

  final String id;
  final double price;
  final String title;
  final DateTime dateTime;
  final Category category;

  String get formattedDate { //I converted the date more readeble form.
    return formatter.format(dateTime);
  }
}
