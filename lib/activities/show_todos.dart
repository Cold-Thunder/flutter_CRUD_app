import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowTodos extends StatelessWidget{
  Map todo;
  ShowTodos({
    required this.todo
  });

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('${todo['title']}', style: TextStyle(
          fontSize: 24,
          color: Colors.white
        )),
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.purple
      ),
      body: SafeArea(
        child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide.none,
                  left: BorderSide.none,
                  bottom: BorderSide(color: Colors.white, width: 1),
                )
              ),
              child: Text('${todo['title']}',style: TextStyle(
                fontSize: 22,
                color: Colors.white
              ),
                textAlign: TextAlign.left
              )
            ),
            const SizedBox(height: 20),
            Container(
              padding:const EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: Text('${todo['description']}', style: TextStyle(
                fontSize: 20,
                color: Colors.white
              ),
              )
            )
          ],
        )
      )
      )
    );
  }
}