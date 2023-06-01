import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TextFieldData>(
      create: (_) => TextFieldData(),
      child: MaterialApp(
        title: 'Text Field Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Field Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFieldWidget(),
            SizedBox(height: 16),
            SubmitButtonWidget(),
          ],
        ),
      ),
    );
  }
}

class TextFieldData extends ChangeNotifier {
  String text1 = '';
  String text2 = '';

  void setText1(String value) {
    text1 = value;
    notifyListeners();
  }

  void setText2(String value) {
    text2 = value;
    notifyListeners();
  }

  bool get isButtonEnabled => text1.isNotEmpty && text2.isNotEmpty;
}

class TextFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TextFieldData>(
      builder: (context, textFieldData, _) {
        return Column(
          children: [
            TextField(
              onChanged: (value) => textFieldData.setText1(value),
              decoration: InputDecoration(
                labelText: 'Text 1',
              ),
            ),
            TextField(
              onChanged: (value) => textFieldData.setText2(value),
              decoration: InputDecoration(
                labelText: 'Text 2',
              ),
            ),
          ],
        );
      },
    );
  }
}

class SubmitButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TextFieldData>(
      builder: (context, textFieldData, _) {
        return Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            color: textFieldData.isButtonEnabled ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextButton(
            onPressed: textFieldData.isButtonEnabled ? () {} : null,
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
