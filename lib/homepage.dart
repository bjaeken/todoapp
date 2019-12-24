import 'package:flutter/material.dart';
import 'item.dart';
import 'dart:async';
import 'addtodo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Todo>> _getItems() async {
    var data =
        await http.get("https://5e020dcc63d08b0014a28654.mockapi.io/listitems");
    var jsonData = json.decode(data.body);
    List<Todo> todos = [];
    for (var t in jsonData) {
      Todo todo =
          Todo(id: t['id'], title: t['title'], description: t['description']);
      todos.add(todo);
    }
    return todos;
  }

  Future<Todo> _deleteItem(id) async {
    var url = "http://5e020dcc63d08b0014a28654.mockapi.io/listitems/" + id;
    await http.delete(url);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        title: const Text('ToDo List:'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddTodo()));
              }),
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: _getItems(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepPurple[900]),
                    backgroundColor: Colors.white,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data[index].title),
                    subtitle: Text(snapshot.data[index].description),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.deepPurple[900],
                      ),
                      onPressed: () {
                        _deleteItem(snapshot.data[index].id);
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTodo()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple[900],
      ),
    );
  }
}
