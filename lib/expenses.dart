import 'package:expense_app/Charts/chart.dart';
import 'package:expense_app/expenselist.dart';
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/new_expenses.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> registeredexpenses = [
    // Expense(
    //   amount: 16.55,
    //   title: "Hotel",
    //   date: DateTime.now(),
    //   category: Category.food,
    // ),
    // Expense(
    //   amount: 1500,
    //   title: "Kodaikanal",
    //   date: DateTime.now(),
    //   category: Category.travel,
    // ),
    // Expense(
    //   amount: 8000,
    //   title: "Education",
    //   date: DateTime.now(),
    //   category: Category.education,
    // ),
    // Expense(amount: 2300,
    //   date:DateTime.now(),
    //   title: "Hospital",
    //   category:Category.medical,
    // ),
  ];

  void _expensesAddOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (ctx) => NewExpense(
              onAddExpense: _addExpense,
            ));
  }

  void _addExpense(Expense expense) {
    setState(() {
      registeredexpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = registeredexpenses.indexOf(expense);
    setState(() {
      registeredexpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense Deleted...!"),
        action: SnackBarAction(
            label: "undo",
            onPressed: () {
              setState(() {
                registeredexpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text("No Expenses Found...Start adding some new!"),
    );

    if (registeredexpenses.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: registeredexpenses,
        onRemoveExpense: removeExpense,
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Expense Tracker',
            style: GoogleFonts.habibi(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: _expensesAddOverlay,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: width < 600
            ? Column(
                children: [
                  //Toolbar with the add button =>Row()
                  Chart(expenses: registeredexpenses),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              )
            : Row(
                children: [
                  //Toolbar with the add button =>Row()
                  Expanded(
                    child: Chart(expenses: registeredexpenses),
                  ),

                  Expanded(
                    child: mainContent,
                  ),
                ],
              ));
  }
}
