import 'package:app_afazeres/constants/colors.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  Function searchItems;
  SearchBox({super.key, required this.searchItems});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30)
          ),
          child: TextField(
            onChanged: (value) => searchItems(value),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: todoBlack, size: 20,),
              hintText: 'Pesquisar',
              hintStyle: TextStyle(color: todoGrey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(12),
            )
          ),
        ),
      );
  }
}