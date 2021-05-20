import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_todo_firebase_list/Modals/todo.dart';
import 'package:provider_todo_firebase_list/Services/todoServices.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TodoServices>(
        builder: (context, data, child) => ListView.builder(
            //check todo length
            itemCount: data.todos.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(
                    data.todos[index].title,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            TextEditingController controller =
                                TextEditingController();
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: TextField(
                                        controller: controller,
                                        decoration:
                                            InputDecoration(hintText: 'Add'),
                                      ),
                                      actions: [
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel')),
                                        FlatButton(
                                            onPressed: () {
                                              var temTodo = Todo(
                                                title:
                                                    controller.text.toString(),
                                              );
                                              temTodo.id = data.todos[index].id;

                                              context
                                                  .read<TodoServices>()
                                                  .updateTodo(temTodo);
                                              Navigator.pop(context);
                                            },
                                            child: Text('Update')),
                                      ],
                                    ));
                          }),
                      IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            context
                                .read<TodoServices>()
                                .removeTodo(data.todos[index].id);
                          }),
                    ],
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show Dialog
          TextEditingController controller = TextEditingController();
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: TextField(
                      controller: controller,
                      decoration: InputDecoration(hintText: 'Add'),
                    ),
                    actions: [
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel')),
                      FlatButton(
                          onPressed: () {
                            context.read<TodoServices>().addTodo(
                                Todo(title: controller.text.toString()));
                            Navigator.pop(context);
                          },
                          child: Text('Add')),
                    ],
                  ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
