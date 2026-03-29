class Task {
  final int id;
  final String title;
  final String description;
  final String type;
  final String userId;
  final bool isDone;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.userId,
    required this.isDone,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? 'daily',
      userId: json['user_id'] ?? '',
      isDone: json['is_done'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'type': type,
      'user_id': userId,
      'is_done': isDone,
    };
  }

  Task copyWith({
    int? id,
    String? title,
    String? description,
    String? type,
    String? userId,
    bool? isDone,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      userId: userId ?? this.userId,
      isDone: isDone ?? this.isDone,
    );
  }
}
