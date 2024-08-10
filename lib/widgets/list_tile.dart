import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget{
  Function tapFunc;
  Function editData;
  Function deleteById;
  int index;
  Map todo;

  ListTileWidget({
    required this.tapFunc,
    required this.editData,
    required this.deleteById,
    required this.index,
    required this.todo
});

  Widget build(BuildContext context){
    return GestureDetector(
      onTap:(){
        tapFunc(todo);
      },
      child: ListTile(
        tileColor: Colors.blueGrey,
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.purple,
          child: Text('${index+1}',
              style: TextStyle(fontSize: 22, color: Colors.white)
            )
          ),
          title: Text('${todo['title']}',
            overflow: TextOverflow.fade,
            maxLines: 1,
          ),
          titleTextStyle: TextStyle(fontSize: 24, color: Colors.white),
          subtitle: Text('${todo['description']}',
            overflow: TextOverflow.fade,
            maxLines: 1
          ),
          subtitleTextStyle: TextStyle(
            fontSize: 16,
            color: Colors.white
          ),
          trailing: PopupMenuButton(
          onSelected: (value){
            if(value == 'edit'){
              editData(todo);
            }else if(value == 'delete'){
              deleteById(todo['_id'].toString());
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
          )
    );
  }
}