import 'package:flutter/material.dart';
import 'package:task_manager/src/models/task.dart';

class TaskListTile extends StatelessWidget {
  final Task task;
  final void Function() onEditTap;
  final void Function(bool? value) onCheckBoxTap;
  final void Function() onDeleteTap;
  const TaskListTile({
    super.key,
    required this.task,
    required this.onEditTap,
    required this.onCheckBoxTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            GestureDetector(
              onTap: onEditTap,
              child: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Checkbox(
              value: task.isCompleted,
              onChanged: onCheckBoxTap,
            ),
            GestureDetector(
              onTap: onDeleteTap,
              child: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
