import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/task.dart';
import '../db/task_database.dart';

final taskProvider =
    StateNotifierProvider<TaskNotifier, List<Task>>((ref) => TaskNotifier());

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  Future<void> fetchTasks() async {
    final tasks = await TaskDatabase.instance.fetchTasks();
    state = tasks;
  }

  Future<void> addTask(Task task) async {
    await TaskDatabase.instance.addTask(task);
    await fetchTasks();
  }

  Future<void> updateTask(Task task) async {
    await TaskDatabase.instance.updateTask(task);
    await fetchTasks();
  }

  Future<void> deleteTask(int id) async {
    await TaskDatabase.instance.deleteTask(id);
    await fetchTasks();
  }

  Future<void> searchTasks(String query) async {
    final tasks = await TaskDatabase.instance.fetchTasks();

    if (query.isEmpty) {
      state = tasks;
    } else {
      state = tasks
          .where((task) =>
              task.title.toLowerCase().contains(query.toLowerCase()) ||
              task.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
