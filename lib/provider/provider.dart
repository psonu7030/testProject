import 'package:flutter/foundation.dart';

import '../database/new_database_helper.dart';
// import '../model/item.dart';

class Task with ChangeNotifier {
  List<Item> taskItem = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Task() {
    _fetchTasksFromDB();
  }

  Future<void> _fetchTasksFromDB() async {
    taskItem = await _dbHelper.fetchTasks();
    notifyListeners();
  }

  Future<void> addItem(String id, String title, bool isCompleted) async {
    final newItem = Item(id: id, title: title, isCompleted: false);
    taskItem.insert(0, newItem);
    notifyListeners();
    await _dbHelper.insertTask(newItem);
  }

  Future<void> updateItem(String id, bool isCompleted) async {
    final index = taskItem.indexWhere((item) => item.id == id);
    if (index != -1) {
      taskItem[index].isCompleted = isCompleted;
      notifyListeners();
      await _dbHelper.updateTask(taskItem[index]);
    }
  }

  Future<void> removeItem(int index) async {
    final id = taskItem[index].id;
    taskItem.removeAt(index);
    notifyListeners();
    await _dbHelper.deleteTask(id!);
  }
}











//
//
// import 'package:flutter/material.dart';
//
// import '../model/item.dart';
//
// class Task with ChangeNotifier {
//   List<Item> taskItem=[];
//   void addItem(String id,String title,bool isCompleted) {
//      taskItem.insert(0,Item(id,title, false));
//     notifyListeners();
//   }
//   void updateItem(String id, bool isCompleted) {
//     final index = taskItem.indexWhere((item) => item.id == id);
//     if (index != -1) {
//       taskItem[index].isCompleted = isCompleted;
//       notifyListeners();
//     }
//   }
//   void removeItem(int index) {
//    taskItem.removeAt(index);
//     notifyListeners();
//   }
// }
