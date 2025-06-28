// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/model/todo_model.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  const TodoItem({
    super.key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.spMin),
      child: ListTile(
        onTap: () {
          onToDoChanged(todo);
        },

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20.spMin),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.spMin,
          vertical: 5.spMin,
        ),
        tileColor: Colors.grey[900],
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16.spMin,
            color: Colors.grey[400],
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          // margin: EdgeInsets.symmetric(vertical: 12.spMin),
          height: 35.spMin,
          width: 35.spMin,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: () {
              onDeleteItem(todo.id);
            },

            iconSize: 15.spMin,
            icon: Icon(Icons.delete, color: Colors.white, size: 20.spMin),
          ),
        ),
      ),
    );
  }
}
