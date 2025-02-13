class Task {
  final int? id;
  String title;
  String description;
  bool isCompleted;
  final int priority; // 1 - High, 2 - Medium, 3 - Low
  final DateTime dueDate;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.priority,
    required this.dueDate,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
      priority: map['priority'],
      dueDate: DateTime.parse(map['dueDate']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
      'priority': priority,
      'dueDate': dueDate.toIso8601String(),
    };
  }
}
