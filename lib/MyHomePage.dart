import 'package:day7_8_9_task/model/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> transaction = [
    // Transaction(
    //     id: '1', title: 'canada trip', amount: 10000, dateTime: DateTime.now()),
    // Transaction(
    //     id: '2', title: 'UAE trip', amount: 20000, dateTime: DateTime.now()),
  ];

  //here we are declare the variable for storing data
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  // for validation
  final _formKey = GlobalKey<FormState>();

  //here we create the function for append the data into transaction
  void _appendTransaction(String title, double amount) {
    if (title!.isNotEmpty && amount != 0.0) {
      var temp_transaction = Transaction(
          id: transaction.length + 1,
          title: title,
          amount: amount,
          dateTime: DateTime.now());

      //setState is print the live value when we not use then value is added in transaction but it is not showing in current screen.
      setState(() {
        transaction.add(temp_transaction);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense App'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Card(
              elevation: 10,
              child: Form(
                //key for validation
                key: _formKey,

                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: TextFormField(
                          //controller for storing data in variable(titleController).
                          controller: titleController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              labelText: 'Title',
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .black), // Border color when focused
                              ),
                              hintText: 'enter the title of expense.'),

                          //for validation
                          validator: (value) {
                            print("validation ${value}");

                            if (value!.isEmpty) {
                              return 'title is required';
                            } else {
                              return null;
                            }
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Amount.',
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    Colors.black), // Border color when focused
                          ),
                          hintText: 'enter the ammount of expense',
                        ),

                        //  for validator
                        validator: (value) {
                          print("validation ${value}");

                          if (value!.isEmpty) {
                            return "amount is required.";
                          } else if (RegExp(r'^[0-9]+[.]$').hasMatch(value)) {
                            return null;
                          } else {
                            return "enter digit only";
                          }
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // for check validation in terminal
                        if (_formKey.currentState!.validate()) {
                          print('hureee');
                        } else {
                          print('not   hureee');
                        }

                        //it is print the input data in run console.
                        // print(titleController);
                        // print(amountController);

                        //  we add title and amount add into list
                        _appendTransaction(titleController.text,
                            double.parse(amountController.text));

                        //after press the add button textfield is clear
                        titleController.clear();
                        amountController.clear();
                      },
                      child: Text('Add'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black, // Background color
                      ),
                    )
                  ],
                ),
              ),
            ),

            //it is difficult to format the data using Text() so we are use the widget called listview.builder
            //this task also doing with for loop only using ListTile but
            //ListTile is represent fixed list and ListView.builder is represent the list in scrolling view.

            Expanded(
              child: ListView.builder(
                  itemCount: transaction.length,
                  itemBuilder: (BuildContext context, int index) {
                    // Text('${transaction[index].id},${transaction[index].title},${transaction[index].amount},${transaction[index].date}')
                    return ListTile(
                      leading: Text('${transaction[index].id}'),
                      title: Text('${transaction[index].title}'),
                      subtitle: Text(DateFormat.yMMMd()
                          .format(transaction[index].dateTime)),
                      trailing: Text('${transaction[index].amount}'),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
