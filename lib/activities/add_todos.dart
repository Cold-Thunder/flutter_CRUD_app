import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTodos extends StatefulWidget{
  @override
  _AddTodosState createState()=> _AddTodosState();
}
class _AddTodosState extends State<AddTodos>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todos', style: TextStyle(
            fontSize: 24,
            color: Colors.white)),
        backgroundColor: Colors.purple,
        iconTheme: const IconThemeData(
          color: Colors.white
        )
      ),
      body: SafeArea(
        child: Column(
          children: [

          ]
        )
      )
    );
  }
}