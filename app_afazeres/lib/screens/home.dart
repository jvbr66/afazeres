import 'package:app_afazeres/constants/colors.dart';
import 'package:app_afazeres/model/model.dart';
import 'package:app_afazeres/widgets/search_box.dart';
import 'package:app_afazeres/widgets/todo_item.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var todosList = ToDo.todoList();

  List<ToDo> _foundTodo = [];

  final _todoTextEditController = TextEditingController();


  @override
  void initState() {
    _foundTodo = todosList;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        shadowColor: todoGrey,
        elevation: 3,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu),
            Text("JOÃO SIMPSON"),
            ClipOval(
                child: SizedBox.fromSize(
                    size: Size.fromRadius(20), // Image radius
                    child: Image.asset('assets/images/avatar.png', fit: BoxFit.cover),
                ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SearchBox(searchItems: _filter),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("AFAZERES", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for(ToDo todoo in _foundTodo)
                      TodoItem(todo: todoo, onTodoChanged: _handleToDoChange, deleteItem: _deleteTodoItem)
                  ]
                ),
              ),
            ],
          ),
          
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 0),
                          blurRadius: 5,
                          spreadRadius: 0
                        )],
                        borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: TextField(
                        controller: _todoTextEditController,
                        decoration: InputDecoration(
                          hintText: 'Clique para Adicionar',
                          border: InputBorder.none
                        ),
                      ),
                    )),
                    Container(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: (){
                          print('ADICIONOU');
                          _addTodoItem(_todoTextEditController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: todoBlue,
                          elevation: 10
                        ),
                        child: Text('+',style: TextStyle(color: Colors.white, fontSize: 40),)),
                    )
                ],
              ),
            )
        ]
        ),
      ),
    );
  }

  void _handleToDoChange(ToDo todo){
    setState(() {
      if(todo.isDone != null){
        todo.isDone = !todo.isDone!;
      }
    });
  }

  void _deleteTodoItem(String id){
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addTodoItem(String todoString){
    setState(() {
      todosList.add(
      ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: todoString));
    });
    _todoTextEditController.clear();
  }

  void _filter(String digitKeyboard){
    List<ToDo> results = [];

    if(digitKeyboard.isEmpty){
      results = todosList;
    } else {
      results = todosList.where((item) =>
      item.todoText!.toLowerCase().contains(digitKeyboard.toLowerCase())).toList();
    }

    setState(() {
      _foundTodo = results;
    });
  }


}