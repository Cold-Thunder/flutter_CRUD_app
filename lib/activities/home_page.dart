import 'package:crud_app/activities/add_todos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState()=> _HomePageState();
}
class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(fontSize: 24, color: Colors.white)),
        backgroundColor: Colors.purple
      ),
      body: SafeArea(
        child: Column(
          children: [

          ]
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            floatingButton();
          },
        label:const Text('Add Todos', style: TextStyle(fontSize: 22, color: Colors.white)),
        backgroundColor: Colors.purple
      )
    );
  }
  void floatingButton(){
    Navigator.push(context,
      MaterialPageRoute(builder: (context)=>AddTodos())
    );
  }
  void todosFetching(){
    
  }
}