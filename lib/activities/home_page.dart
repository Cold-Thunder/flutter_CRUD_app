import 'dart:convert';

import 'package:crud_app/activities/add_todos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState()=> _HomePageState();
}
class _HomePageState extends State<HomePage>{
  List todos = [];
  @override
  void initState(){
    super.initState();
    todosFetching();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(fontSize: 24, color: Colors.white)),
        backgroundColor: Colors.purple
      ),
      body:RefreshIndicator(
          onRefresh: todosFetching,
          child: SafeArea(
              child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index){
                    final todo = todos[index] as Map;
                    return ListTile(
                        leading: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.purple,
                            child: Text('${index+1}',
                                style: TextStyle(fontSize: 22, color: Colors.white)
                            )
                        ),
                        title: Text('${todo['title']}'),
                        titleTextStyle: TextStyle(fontSize: 24, color: Colors.white),
                        subtitle: Text('${todo['description']}'),
                        subtitleTextStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                        )
                    );
                  }
              )
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
  Future<void> todosFetching()async{
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode == 200){
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState((){
        todos = result;
      });
    }else{

    }
  }
}