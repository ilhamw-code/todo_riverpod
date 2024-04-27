import 'package:flutter/foundation.dart' show immutable;
import 'package:uuid/uuid.dart';
import 'package:riverpod/riverpod.dart';

const _uuid = Uuid();

/// hanya membaca deskripsi dalri item todo

@immutable
class Todo {
  const Todo({
    required this.description,
    required this.id,
    this.completed = false,
  });

  final String id;
  final String description;
  final bool completed;

  @override
  String toString() {
    // override
    return 'Todo(description : $description,  completed :$completed)';
  }
}

/// Pengontrol objek di dala list [Todo].

class TodoList extends Notifier<List<Todo>> {
  @override
  List<Todo> build() => [
        const Todo(description: 'Beli ayam', id: 'Todo-0'),
        const Todo(description: 'Beli penyet', id: 'Todo-1'),
        const Todo(description: 'Beli lele', id: 'Todo-1'),
      ];

  void add(String description) {
    state = [
      ...state,
      Todo(
        description: 'Beli Nuget',
        id: _uuid.v4(),
      )
    ];
  }

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            description: todo.description,
            id: todo.id,
            completed: !todo.completed,
          )
        else
          todo
    ];
  }

  void edit({required String id, required String descriptiion}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            description: todo.description,
            id: todo.id,
            completed: todo.completed,
          )
        else
          todo
    ];
  }

  void remove(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}
