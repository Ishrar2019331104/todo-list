import 'package:flutter/material.dart';
import 'package:todo_list/model/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({required this.todos, super.key});

  final List<Todo> todos;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.todos.length,
      itemBuilder: (_, index) {
        final Todo todo = widget.todos[index];
        return Dismissible(
          key: Key(todo.title),
          onDismissed: (DismissDirection direction) {
            setState(() {
              widget.todos.removeAt(index);

              // show a snackbar

              final snackbar = SnackBar(
                elevation: 12.0,
                backgroundColor: Colors.blue[900],
                content: const Text('Task removed'),
                duration: const Duration(seconds: 1),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    setState(() {
                      widget.todos.insert(index, todo);
                    });
                  },
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: widget.todos[index].priority.color.withOpacity(0.5),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.todos[index].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(widget.todos[index].description),
                      ],
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: widget.todos[index].priority.color),
                        child: Text(widget.todos[index].priority.title)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
