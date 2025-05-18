import 'package:app_afazeres/constants/colors.dart';
import 'package:app_afazeres/model/model.dart';
import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  ToDo? todo;
  Function onTodoChanged;
  Function deleteItem;

  TodoItem({super.key, this.todo, required this.onTodoChanged, required this.deleteItem});

  @override
  Widget build(BuildContext context) {
    return            
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Container(
            height: 60,
            child: ListTile(
              onTap:() {
                  onTodoChanged(todo);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              title: Text('${todo?.todoText}', style: TextStyle(decoration: todo?.isDone == true ? TextDecoration.lineThrough : null),),
              leading: Icon(todo?.isDone == true ? Icons.check_box : Icons.check_box_outline_blank),
              tileColor: Colors.white,
              trailing: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                        color: todoRed,
                        borderRadius: BorderRadius.circular(6)
                      ),
                child: IconButton(
                  onPressed: () {
                    print('DELETOU');
                    deleteItem(todo?.id);
                  },
                  icon: Icon(Icons.delete,
                              color: Colors.white,
                              size: 18,)),
              ),
            )
          ),
        );
  }
}