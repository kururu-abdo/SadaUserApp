import 'package:flutter/material.dart';

class AuthTextfield extends StatelessWidget {
  final TextEditingController  controller;
  final String hintText;
  final FocusNode  focusNode;
  final String Function(String) validator;



const AuthTextfield({ Key key, this.controller, this.hintText, this.focusNode, this.validator }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 55,

      child: 
      
      TextFormField(

      ),
    );

  }
}