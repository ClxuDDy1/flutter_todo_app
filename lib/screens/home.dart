import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15.spMin,
              vertical: 10.spMin,
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 50.spMin,
                          bottom: 20.spMin,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'All ToDos 😃',
                              style: TextStyle(fontSize: 30.spMin),
                            ),
                            TextButton(
                              onPressed: _showClearAllDialog,
                              child: Text(
                                'Clear All',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                      for (ToDo todoo in _foundToDo)
                        TodoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(20.spMin),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style: TextStyle(color: Colors.grey[800]),
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: 'Enter task',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      minimumSize: Size(60.spMin, 60.spMin),
                      elevation: 10,
                    ),
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 40.spMin, color: Colors.white),
                    ),
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;

      // Sort the list: incomplete first, complete last
      // so the value will be one of the following:
      // 0 in case nothing happened

      todosList.sort((firstTask, otherTask) {
        if (firstTask.isDone == otherTask.isDone) return 0;
        return firstTask.isDone ? 1 : -1;
      });
    });
  }

  // I just realized thiat I can use the .reverse() method to solve this problem
  // خيرها في غيره  good to know anyway
  void _addToDoItem(String toDo) {
    setState(() {
      todosList.insert(
        0,
        ToDo(
          // I could've used the random number generator package and created random strings here
          // but using the DateTime as a unique id is alos valid
          // عجبتني الفكرة الصراحة 😄
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo,
        ),
      );
    });
    _todoController.clear();
  }

  void _runFilter(String enterKeyword) {
    // this list will contain all the results this function finds desune
    List<ToDo> results = [];
    if (enterKeyword.isEmpty) {
      // the regular tasks will be chilling like nothing happened in this case
      results = todosList;
    } else {
      results = todosList
          .where(
            (item) => item.todoText!.toLowerCase().contains(
              enterKeyword.toLowerCase(),
            ),
          )
          .toList();
      // they all neeDed to be lowercase because uppercase characters have different ascii codes and that's annoying -_-
    }
    setState(() {
      _foundToDo = results;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _clearAll() {
    setState(() {
      todosList.clear();
    });
  }

  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure you want to remove all Tasks?'),
          actions: [
            TextButton(
              onPressed: () {
                // I'll just close the dialog if the useer clicked on cancel ^_^
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // apparently the dialog will still be facing me if I don't pop it
                Navigator.of(context).pop();
                _clearAll();
              },
              child: Text('Clear', style: TextStyle(color: Colors.red)),
              // adding colors to the textbuttons made them look confusing so just the clear button will be colored
              // I was confused between choosing submit or Clear for confirmation but whatever -_-
            ),
          ],
        );
      },
    );
  }

  Widget searchBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20.spMin),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.spMin, vertical: 4.spMin),
        child: TextField(
          onChanged: (value) => _runFilter(value),
          style: TextStyle(color: Colors.grey[800]),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(color: Colors.black, size: 20.spMin, Icons.search),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20.spMin,
              minWidth: 25.spMin,
            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: tdGrey),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: tdBlack,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu, color: tdGBColor, size: 30.spMin),
          SizedBox(
            height: 40.spMin,
            width: 40.spMin,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/avatar1.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}
