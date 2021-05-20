import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider_todo_firebase_list/Modals/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoServices extends ChangeNotifier {
// Add Empty List
  List<Todo> todos = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  getTodo() async {}

  addTodo(Todo todo) async {
    todos.add(todo);
    await firestore
        .collection('todos')
        .add({"title": todo.title}).then((value) {
      //Set Document idd
      todo.id = value.id;
      //
      //add  todo in  tto ttos
      todos.add(todo);
    });
    notifyListeners();
  }

  removeTodo(id) async {
    //ddelete todo

    var index = todos.indexWhere((element) => element.id == id);
    if (index != -1) await firestore.collection('todos').doc(id).delete();
    todos.removeAt(index);

    notifyListeners();
  }

  updateTodo(Todo todo) async {
    var index = todos.indexWhere((element) => element.id == todo.id);
    //Udate  and check todo is in the list of not
    if (index != -1) {
      //update todo
      await firestore
          .collection('todos')
          .doc(todo.id)
          .update({"title": todo.title});
      todos[index] == todos;
    }
    notifyListeners();
  }
}
