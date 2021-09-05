import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTxt;
  NewTransaction(this.addTxt);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  var _pickedDate;
  
  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final tit = _titleController.text;
    final amnt = double.parse(_amountController.text);

    if (tit.isEmpty || amnt <= 0 || _pickedDate == "") {
      return;
    }

    widget.addTxt(tit, amnt, _pickedDate);
    Navigator.of(context).pop(); // This will close the pop up window after entering the data
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate == null) {
        return;
      }
      setState(() {
        _pickedDate = selectedDate;//(DateFormat.yMMMEd().format(selectedDate!)) ;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var other = null;
    return Card(
      elevation: 10,
      child: Padding(
        // margin: EdgeInsets.symmetric( horizontal: 25),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              cursorColor: Colors.purple,
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Price'),
              cursorColor: Colors.purple,
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                      _pickedDate == null? 'No Date Choosen' :  DateFormat.yMMMEd().format(_pickedDate),
                      style: TextStyle(color: Colors.red)),
                ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _presentDatePicker,
                )
              ],
            ),
            RaisedButton(
                onPressed: _submitData,
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Add Transactions',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.button!.color,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
  
}
