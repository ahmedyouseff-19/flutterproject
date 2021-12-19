import 'package:get/get.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/models/task.dart';

class TaskController extends GetxController {
  final RxList<Task> tsakList = <Task>[].obs;

  Future<int> addTask({Task? task}) {
    return DBHelper.insert(task);
  }

//get data from database
  Future<void> getTasks() async {
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    tsakList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  //delete data from database
  void deleteTasks(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

//update data from database
  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
