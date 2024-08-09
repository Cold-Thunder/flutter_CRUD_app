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
  bool isLoading = true;
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
      body:Visibility(
        visible: isLoading,
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.purple
            )
        ),
      replacement: RefreshIndicator(
          onRefresh: todosFetching,
          child: SafeArea(
              child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index){
                    final todo = todos[index] as Map;
                    final id = todo['_id'] as String;
                    return
                      ListTile(
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
                        ),
                      trailing: PopupMenuButton(
                        onSelected: (value){
                          if(value == 'edit'){

                          }else if(value == 'delete'){
                            deleteById(id);
                          }
                        },
                        itemBuilder: (context){
                          return [
                            PopupMenuItem(
                              child: Text('Edit', style: TextStyle(fontSize: 20)),
                              value: 'edit'
                            ),
                            PopupMenuItem(
                              child: Text('Delete', style: TextStyle(fontSize: 20)),
                              value: 'delete'
                            )
                          ];
                        }
                      )
                    );
                  }
              )
          )
      )),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            floatingButton();
          },
        label:const Text('Add Todos', style: TextStyle(fontSize: 22, color: Colors.white)),
        backgroundColor: Colors.purple
      )
    );
  }
  Future<void> floatingButton() async{
    await Navigator.push(context,
      MaterialPageRoute(builder: (context)=>AddTodos())
    );
    setState((){
      isLoading = true;
    });
    todosFetching();
  }

  deleteById(String id){
      showDialog(
        context: context,
        builder:(context){
          return AlertDialog(
            backgroundColor: Colors.white,
              title: const Text('Do you want to delete?'),
              titleTextStyle: const TextStyle(
                  fontSize: 22,
                  color: Colors.black
              ),
              actions:[
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child:const Text('No', style: TextStyle(fontSize: 21, color: Colors.blue)),
                ),
                TextButton(
                    onPressed: (){
                      delete(id);
                    },
                    child:const Text('Yes', style: TextStyle(fontSize: 21, color: Colors.red))
                )
              ]
          );
        }
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
        isLoading = false;
      });
    }else{

    }
  }

  Future<void> delete(String id)async{
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if(response.statusCode == 200){
      final filtered = todos.where((elem)=> elem['_id'] != id).toList();
      setState((){
        todos = filtered;
      });
    }
    Navigator.pop(context);
  }
}