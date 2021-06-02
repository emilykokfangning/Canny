import 'package:Canny/Models/category.dart';
import 'package:Canny/Models/expense.dart';
import 'package:Canny/Services/Quick%20Input/calculator_icon_buttons.dart';
import 'package:Canny/Services/Quick%20Input/quickinput_buttons.dart';
import 'package:Canny/Services/Receipt/receipt_database.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:Canny/Services/Quick%20Input/calculator_buttons.dart';
import 'package:Canny/Shared/colors.dart';
import 'package:Canny/Services/Quick Input/quickinput_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuickInput extends StatefulWidget {
  static final String id = 'quickinput_screen';

  @override
  QuickInputState createState() => QuickInputState();
}

class QuickInputState extends State<QuickInput> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  String _history = '';
  String _expression = '';
  final QuickInputDatabaseService _authQuickInput = QuickInputDatabaseService();
  final ReceiptDatabaseService _authReceipt = ReceiptDatabaseService();

  void numClick(String text) {
    setState(() => _expression += text);
  }

  void allClear(String text) {
    setState(() {
      _history = '';
      _expression = '';
    });
  }

  void evaluate(String text) {
    Parser p = Parser();
    Expression exp = p.parse(_expression);
    ContextModel cm = ContextModel();

    setState(() {
      _history = _expression;
      _expression = exp.evaluate(EvaluationType.REAL, cm).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    _authQuickInput.initNewQuickInputs();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[200],
        elevation: 0.0,
      ),
      body: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calculator',
        home: Scaffold(
          backgroundColor: kBackgroundColour,
          body: Container(
            padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  alignment: Alignment(1.0, 1.0),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Text(
                      _history,
                      style: TextStyle(
                          fontSize: 24,
                          color: kDarkGrey,
                        ),
                      ),
                    ),
                  ),
                Container(
                  alignment: Alignment(1.0, 1.0),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Text(
                      _expression,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.blueGrey[900],
                      ),
                      ),
                    ),
                  ),
                SizedBox(height: 12),
                Row(
                  //this row of calculator buttons
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CalcButton(
                      text: 'AC',
                      fillColor: kDeepOrangePrimary,
                      callback: allClear,
                      textSize: 22,
                    ),
                    CalcIconButton(
                      icon: _authQuickInput.getQuickInput(0).categoryIcon,
                      categoryColor: _authQuickInput.getQuickInput(0).categoryColor,
                      fillColor: Colors.orange[200],
                    ),
                    CalcIconButton(
                      icon: _authQuickInput.getQuickInput(1).categoryIcon,
                      categoryColor: _authQuickInput.getQuickInput(1).categoryColor,
                      fillColor: Colors.orange[200],
                    ),
                    CalcIconButton(
                      icon: _authQuickInput.getQuickInput(2).categoryIcon,
                      categoryColor: _authQuickInput.getQuickInput(2).categoryColor,
                      fillColor: Colors.orange[200],
                    ),
                    // QuickInputButton(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CalcButton(
                      text: '7',
                      fillColor: kDarkGrey,
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '8',
                      fillColor: kDarkGrey,
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '9',
                      fillColor: kDarkGrey,
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '÷',
                      fillColor: kDeepOrangePrimary,
                      textSize: 28,
                      callback: numClick,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CalcButton(
                      text: '4',
                      fillColor: kDarkGrey,
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '5',
                      fillColor: kDarkGrey,
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '6',
                      fillColor: kDarkGrey,
                      callback: numClick,
                    ),
                    CalcButton(
                      text: 'x',
                      fillColor: kDeepOrangePrimary,
                      textSize: 26,
                      callback: numClick,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CalcButton(
                      text: '1',
                      fillColor: kDarkGrey,
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '2',
                      fillColor: kDarkGrey,
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '3',
                      fillColor: kDarkGrey,
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '-',
                      fillColor: kDeepOrangePrimary,
                      textSize: 36,
                      callback: numClick,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CalcButton(
                      text: '.',
                      fillColor: kDarkGrey,
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '0',
                      fillColor: kDarkGrey,
                      callback: numClick,
                    ),
                    CalcButton(
                      text: '=',
                      fillColor: kDeepOrangePrimary,
                      callback: evaluate,
                    ),
                    CalcButton(
                      text: '+',
                      fillColor: kDeepOrangePrimary,
                      textSize: 30,
                      callback: numClick,
                    ),
                  ],
                ),
                SizedBox(
                  width: 300,
                  height: 6,
                ),
                SizedBox(
                  width: 360,
                  height: 50,
                  child: TextButton(
                      onPressed: () async {
                        final Expense expense = Expense(
                          categoryId: QuickInputButton().chosenCategory['categoryId'],
                          cost: double.parse(_expression),
                          itemName: "",
                          uid: uid,
                        );
                        await _authReceipt.addExpense(expense).then((_) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Successfully added an Expense",
                                  style: TextStyle(fontFamily: 'Lato'),
                                ),
                                content: Text(
                                  "Would you like to add another Expense?",
                                  style: TextStyle(fontFamily: 'Lato.Thin'),
                                ),
                                actions: <Widget> [
                                  TextButton(
                                    child: Text("Back to Function Screen"),
                                    onPressed: () {
                                      int count = 0;
                                      Navigator.popUntil(context, (route) {
                                        return count++ == 2;
                                      });
                                    },
                                  ),
                                  TextButton(
                                    child: Text("Add another Expense"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        });
                      },
                      child: Text(
                        "Enter",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: kDeepOrangePrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
