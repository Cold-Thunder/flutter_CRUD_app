import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputSection extends StatelessWidget{
  TextEditingController controller = TextEditingController();
  final String hint;
  final bool multiLine;

  InputSection({
    required this.controller,
    required this.hint,
    required this.multiLine
});
  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 10),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 20, color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 22,
            color: Colors.white
          ),
        ),
        keyboardType: multiLine == true
            ? TextInputType.multiline : TextInputType.text,
        minLines: multiLine == true ? 5 : 1,
        maxLines: multiLine == true ? 7 : 1
      )
    );
  }
}