import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime _selectDate;
  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectDate==null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectDate,
    );

    Navigator.of(context).pop();
  }
  void _presentDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2019),
      lastDate: DateTime.now() 
      ).then((pickedDate){
        if(pickedDate == null)
        return;
        setState(() {
            _selectDate=pickedDate;
        });
      
      }
      );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),

            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              // onChanged: (val) => amountInput = val,
            ),
            Row(children: <Widget>[
              Text(_selectDate==null?'No Date Chosen!':DateFormat.yMd().format(_selectDate)),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('Choose Date',
                style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: _presentDatePicker,
              ),
            ],

            ),
            RaisedButton(
              child: Text('Add Transaction'),
              textColor: Theme.of(context).primaryColor,
              
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }
}
