import 'dart:convert';

import 'package:crud_app/widgets/input_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodos extends StatefulWidget{
  final Map? todo;
  @override
  AddTodos({
    super.key,
    this.todo
  });

  @override
  _AddTodosState createState()=> _AddTodosState();
}
class _AddTodosState extends State<AddTodos>{
  TextEditingController titleCont = TextEditingController();
  TextEditingController desCont = TextEditingController();
  bool isSubmiting = false;
  bool isEdit = false;

  void initState(){
    final todo = widget.todo;
    if(todo != null){
      isEdit = true;
      titleCont.text = todo['title'];
      desCont.text = todo['description'];
      print(todo['_id']);

    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit == true ? 'Edit Todo' :
            'Add Todos',
            style: TextStyle(
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
            InputSection(controller: titleCont, hint: 'Title', multiLine: false),
            InputSection(controller: desCont, hint: 'Description', multiLine: true),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                  child: Text(
                      isEdit == true ? 'Update' : 'Submit',
                      style: TextStyle(fontSize: 22, color: Colors.white)),
                  onPressed: (){
                    isEdit == true ?
                        editTodo() :
                    submitTodo();
                  }
              )
            ),
            Visibility(
              visible: isSubmiting,
                child: CircularProgressIndicator(
                  color: Colors.purple
                ),
              replacement: Container()
            )
          ]
        )
      )
    );
  }

  Future<void> editTodo() async{
    final String title = titleCont.text;
    final String des = desCont.text;
    final todo = widget.todo;
    late final id;
    if(todo != null){
      id = todo['_id'];
    }
    setState((){
      isSubmiting =true;
    });
    final body = {
      "title": title,
      "description": des,
      "is_completed": false
    };

    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.put(
        uri,
        body: jsonEncode(body),
      headers: {
          'Content-Type': 'application/json'
      }
    );
    if(response.statusCode == 200){
      snackMessage('Updated!', Colors.purple);
      setState((){
        isSubmiting = false;
      });
    }else{
      snackMessage('Faild to update!', Colors.red);
    }
  }

  Future<void> submitTodo()async{
    final String title = titleCont.text;
    final String des = desCont.text;
    setState(() {
      isSubmiting = true;
    });
    final body = {
      "title": title,
      "description": des,
      "is_completed": false
    };
    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(
        uri,
        body: jsonEncode(body),
      headers: {
          'Content-Type': 'application/json'
      },
    );
    if(response.statusCode == 201){
      snackMessage('Successfully added!', Colors.purple);
      titleCont.clear();
      desCont.clear();
      setState((){
        isSubmiting = false;
      });
    }else{
      snackMessage('Failed to add!', Colors.purple);
    }
  }
  void snackMessage(String message, Color color){
    final snackBar = SnackBar(content: Text(message,
      style: TextStyle(
        fontSize: 20,
        color: Colors.white
      )
    ),
    backgroundColor: color
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}