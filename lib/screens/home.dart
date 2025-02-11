import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/todo.dart';
import 'package:flutter_application_1/screens/add_todo_screen.dart';
import 'package:flutter_application_1/services/database_service.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  void _fetchTodos() {
    context.read<DatabaseService>().fetchTodos();
  }

  void _navigateToAddScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTodoScreen(),
      ),
    );
  }

  @override
  void initState() {
    _fetchTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Görev Uygulaması"),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Colors.blue.shade700,
        actions: [
          IconButton(
            onPressed: _navigateToAddScreen,
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: _todoListWidget(),
      ),
    );
  }

  Expanded _todoListWidget() {
    return Expanded(
      child: Consumer<DatabaseService>(
        builder: (context, databaseService, child) => ListView.separated(
          itemCount: databaseService.currentTodos.length,
          itemBuilder: (context, index) {
            final Todo todo = databaseService.currentTodos[index];
            return ListTile(
              title: Text(
                todo.text,
                style: TextStyle(
                  decoration: todo.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text(todo.datetime.toString()),
              tileColor: Colors.grey.shade100,
              trailing: Checkbox(
                value: todo.isDone,
                onChanged: (isDone) {
                  todo.isDone = isDone!;
                  databaseService.updateTodo(todo);
                },
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
            height: 0,
            color: Colors.blueGrey.shade100,
          ),
        ),
      ),
    );
  }
}