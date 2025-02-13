// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/src/components/list_tile.dart';
import 'package:task_manager/src/models/task.dart';
import 'package:task_manager/src/view/tasks/add_task_screen.dart';
import '../../view_model/task_provider.dart';

class TaskListPage extends ConsumerStatefulWidget {
  const TaskListPage({super.key});
  @override
  ConsumerState<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends ConsumerState<TaskListPage> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(taskProvider.notifier).fetchTasks());
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Management',
          style: TextStyle(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                ref.read(taskProvider.notifier).searchTasks(value);
              },
              decoration: InputDecoration(
                labelText: 'Search Tasks',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: tasks.isEmpty
                ? const Center(child: Text('No tasks available'))
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      var task = tasks[index];
                      return TaskListTile(
                        task: task,
                        onEditTap: () async {
                          ref
                              .read(taskProvider.notifier)
                              .taskTitleController
                              .text = task.title;
                          ref
                              .read(taskProvider.notifier)
                              .taskDescriptionController
                              .text = task.description;
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  insetPadding: EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Edit Task',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        TextFormField(
                                          controller: ref
                                              .read(taskProvider.notifier)
                                              .taskTitleController,
                                        ),
                                        TextFormField(
                                          controller: ref
                                              .read(taskProvider.notifier)
                                              .taskDescriptionController,
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await onEditSubmit(tasks[index]);
                                          },
                                          child: Text('Submit'),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        onCheckBoxTap: (value) {
                          ref
                              .read(taskProvider.notifier)
                              .updateTask(task..isCompleted = value!);
                        },
                        onDeleteTap: () {
                          ref
                              .read(taskProvider.notifier)
                              .deleteTask(task.id ?? 0);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> onEditSubmit(Task task) async {
    await ref.read(taskProvider.notifier).updateTask(
          task
            ..title = ref.read(taskProvider.notifier).taskTitleController.text
            ..description =
                ref.read(taskProvider.notifier).taskDescriptionController.text,
        );
    ref.read(taskProvider.notifier).taskTitleController.clear();
    ref.read(taskProvider.notifier).taskDescriptionController.clear();
    Navigator.pop(context);
  }
}
