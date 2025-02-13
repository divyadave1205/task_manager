// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/src/models/task.dart';
import 'package:task_manager/src/view_model/task_provider.dart';

class AddTaskScreen extends ConsumerWidget {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Task Title',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Task Description',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final title = _titleController.text.trim();
                final description = _descriptionController.text.trim();

                if (title.isNotEmpty && description.isNotEmpty) {
                  final task = Task(
                    title: title,
                    description: description,
                    isCompleted: false,
                    priority: 0,
                    dueDate: DateTime.now(),
                  );

                  // Add task via Riverpod
                  await ref.read(taskProvider.notifier).addTask(task);

                  // Return to the previous screen
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields')),
                  );
                }
              },
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
