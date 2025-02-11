import 'package:isar/isar.dart';

part 'todo.isar.dart';

@collection
class Todo {
  Id id = Isar.autoIncrement;

  late String text;
  DateTime datetime = DateTime.now();
  bool isDone = false;
}