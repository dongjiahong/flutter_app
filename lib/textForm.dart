import 'package:flutter/material.dart';

class TextFormScreen extends StatefulWidget{
  @override
  createState() => _TextFormState();
}

class _TextFormState extends State<TextFormScreen> {
  final mController = TextEditingController();

  @override
  void dispose() {
    // clean up the controller when the widget is disposed
    mController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('获取输入信息Demo'),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          decoration: InputDecoration(
            labelText: '输入信息',
            border: OutlineInputBorder(),
          ),
          controller: mController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(mController.text),
              );
            }
          );
        },
        tooltip: 'show me the value',
        child: Icon(Icons.text_fields),
      ),
    );
  }
}