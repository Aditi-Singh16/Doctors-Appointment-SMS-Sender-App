import 'package:flutter/material.dart';
import 'package:sms_app/services/sms_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Doctors Appointment';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}
// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}
// Create a corresponding State class. This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  TextEditingController _timeTextEditingController = TextEditingController();
  TextEditingController _dateTextEditingController = TextEditingController();
  String result = '';
  bool isResult = false;
  final SmsService _smsService = SmsService();

  Future sendSMS(String time,String day)async{
    String text = await _smsService.sendMessage(time, day);
    setState(() {
      result= text;
      isResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _timeTextEditingController,
              decoration: const InputDecoration(
                icon: const Icon(Icons.watch_later_outlined),
                hintText: 'Enter time',
                labelText: 'Time',
              ),
            ),
            TextFormField(
              controller: _dateTextEditingController,
              decoration: const InputDecoration(
                icon: const Icon(Icons.calendar_today),
                hintText: 'Enter date',
                labelText: 'date',
              ),
            ),
            Container(
                padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                child: new ElevatedButton(
                  child: const Text('Submit'),
                  onPressed:(){
                    sendSMS(_timeTextEditingController.text,_dateTextEditingController.text);
                  },
                )
            ),
          isResult?
              result=='successfully sent'?
                  Text(
                    result,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 30.0
                    ),
                  ):
              Text(
                result,
                style: TextStyle(
                    color: Colors.pink,
                    fontSize: 30.0
                ),
              )
            :
                Container()
          ],
        ),
      ),
    );
  }
}