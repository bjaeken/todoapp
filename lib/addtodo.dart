import 'package:flutter/material.dart';
import 'dart:async';
import 'item.dart';
import 'package:http/http.dart' as http;

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() {
    return _AddTodoState();
  }
}

class _AddTodoState extends State<AddTodo> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _title;
  String _description;

  Future<Todo> _postTodo() async {
    var url = "http://5e020dcc63d08b0014a28654.mockapi.io/listitems";
    await http.post(url, body: {'title': _title, 'description': _description});

    return null;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        title: const Text('Add Todo'),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                validator: (titleValue) {
                  if (titleValue.isEmpty) {
                    return "Please fill in this field";
                  }
                  if (titleValue.length > 100) {
                    return "Title is too long";
                  }
                  return null;
                },
                decoration:
                    InputDecoration(hintText: "Title", icon: Icon(Icons.title)),
              ),
              TextFormField(
                validator: (descValue) {
                  if (descValue.isEmpty) {
                    return "Please fill in this field";
                  }
                  if (descValue.length > 100) {
                    return "Description is too long";
                  }
                  return null;
                },
                controller: _descriptionController,
                maxLines: 2,
                maxLength: 100,
                decoration: InputDecoration(
                    hintText: "Description", icon: Icon(Icons.description)),
              ),
              ButtonTheme(
                buttonColor: Colors.deepPurple[900],
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _title = _titleController.text;
                      _description = _descriptionController.text;
                      _postTodo();
                      Navigator.pop(context);
                    }
                  },
                  textColor: Colors.white,
                  child: Text('Add todo'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
