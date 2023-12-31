import 'package:flutter/material.dart';
import 'todo.dart';
import 'todo_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Storage Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Local Storage Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var _todoItem;
  var _lastInsertedId = 0;
  var _model = TodoModel();
  var _replaceId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                  labelText: "Id Number"
              ),
              style: TextStyle(fontSize: 30),
              onChanged: (value){
                _replaceId = int.tryParse(value);
              },
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Todo Item"
              ),
              style: TextStyle(fontSize: 30),
              onChanged: (value){
                _todoItem = value;
              },
            ),
            ElevatedButton(
              onPressed: _readTodos,
              child: Text("Read",
                style: TextStyle(fontSize: 30),
              ),
            ),
            ElevatedButton(
              onPressed: _updateTodo,
              child: Text("Update",
                style: TextStyle(fontSize: 30),
              ),
            ),
            ElevatedButton(
              onPressed: _deleteTodo,
              child: Text("Delete",
                style: TextStyle(fontSize: 30),
              ),
            ),
            ElevatedButton(
              onPressed: _getTodo,
              child: Text("Search",
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future _addTodo() async{
    Todo todo = Todo(item: _todoItem);
    if (_replaceId != null){
      todo.id = _replaceId;
    }
    _lastInsertedId = await _model.insertTodo(todo);
    print("Todo Inserted: $_lastInsertedId, ${todo.toString()}");
  }

  Future _readTodos() async{
    List todos = await _model.getAllTodos();
    print('');
    print("Todos:");
    for (Todo todo in todos){
      print(todo);
    }
  }

  Future _updateTodo() async{
    Todo todo = Todo(item: _todoItem);
    todo.id = _lastInsertedId;
    _model.updateTodo(todo);
  }

  void _deleteTodo(){
    _model.deleteTodoWithId(_replaceId);
  }

  Future _getTodo() async{
    Todo todo = await _model.getTodoWithId(_replaceId);
    print('');
    print(todo.toString());
  }

}