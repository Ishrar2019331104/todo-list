import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list/model/todo.dart';
import 'package:todo_list/todo_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todo> todos = [
    Todo(
        title: 'Buy milk',
        description: 'There is no milk left in the fridge!',
        priority: Priority.high),
    Todo(
        title: 'Make the bed',
        description: 'The bed is a mess!',
        priority: Priority.low),
    Todo(
        title: 'Pay bills',
        description: 'The bills are due soon!',
        priority: Priority.urgent),
  ];

  final _formGlobalKey = GlobalKey<FormState>();
  Priority _selectedPriority = Priority.low;
  String _title = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List'),
        backgroundColor: Colors.grey[200],
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                  child: TodoList(
                todos: todos,
              )),

              // form stuff goes here

              Form(
                key: _formGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // todo title

                    TextFormField(
                      maxLength: 20,
                      decoration: const InputDecoration(
                        label: Text('Todo title'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'You must enter a value for the title.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _title = value!;
                      },
                    ),

                    // todo desc

                    TextFormField(
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text('Todo description'),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 5) {
                          return 'Enter a description atleast 5 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _description = value!;
                      },
                    ),

                    // todo priority

                    DropdownButtonFormField(
                      value: _selectedPriority,
                      items: Priority.values.map((p) {
                        return DropdownMenuItem(
                          value: p,
                          child: Text(p.title),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        label: Text('Priority of todo'),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedPriority = value!;
                        });
                      },
                    ),

                    // submit button
                    const SizedBox(
                      height: 20.0,
                    ),

                    FilledButton(
                        onPressed: () {
                          if (_formGlobalKey.currentState!.validate()) {
                            _formGlobalKey.currentState!.save();

                            setState(() {
                              todos.add(Todo(
                                title: _title,
                                description: _description,
                                priority: _selectedPriority,
                              ));
                            });
                            _formGlobalKey.currentState!.reset();
                            _selectedPriority = Priority.low;
                          }
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Add'))
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
