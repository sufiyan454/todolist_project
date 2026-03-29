import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/task_model.dart';

class TaskService {
  final supabase = Supabase.instance.client;

  Future<List<Task>> fetchTasks() async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    final data = await supabase
        .from('tasks')
        .select()
        .eq('user_id', user.id)
        .order('id', ascending: false);

    return (data as List).map((e) => Task.fromJson(e)).toList();
  }

  Future<void> addTask(String title, String desc, String type) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase.from('tasks').insert({
      'title': title,
      'description': desc,
      'type': type,
      'user_id': user.id,
      'is_done': false,
    });
  }

  Future<void> toggleDone(int id, bool current) async {
    await supabase
        .from('tasks')
        .update({'is_done': !current})
        .eq('id', id);
  }

  Future<void> deleteTask(int id) async {
    await supabase.from('tasks').delete().eq('id', id);
  }

  Future<void> updateTask(int id, String title, String desc, String type) async {
    await supabase.from('tasks').update({
      'title': title,
      'description': desc,
      'type': type,
    }).eq('id', id);
  }
}
