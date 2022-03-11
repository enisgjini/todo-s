// This code used to import a package from flutter where material.dart is located
import 'package:flutter/material.dart';

// The main function will run the MyApp() constructor, like any other programming language where the main function is the entry point to start an application.
void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // This code remove a banner who show debugmode
        debugShowCheckedModeBanner: false,
        // This code add to our project a title
        title: "ToDo's",
        // This code needed to show a route of our app so this is default route
        home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  TodoListState createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  final List<String> todoList = <String>[];
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(bottom: BorderSide(color: Colors.orangeAccent, width: 5)),
        elevation: 0,
        title: const Text("Todo's"),
      ),
      body: ListView(children: getItems()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => displayDialog(context),
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTodoItem(String title) {
    //Wrapping it inside a set state will notify
    // the app that the state has changed

    setState(() {
      todoList.add(title);
    });
    _textFieldController.clear();
  }

  //Generate list of item widgets
  Widget _buildTodoItem(String title) {
    return ListTile(
      title: Text(title),
    );
  }

  //Generate a single item widget
  Future<Future> displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a task to your list'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Add task here'),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('Add'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(_textFieldController.text);
                },
              ),
              FlatButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  List<Widget> getItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    for (String title in todoList) {
      _todoWidgets.add(_buildTodoItem(title));
    }
    return _todoWidgets;
  }
}
