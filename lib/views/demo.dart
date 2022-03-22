import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Demo extends StatelessWidget{
  final id;
  const Demo({Key? key, this.id}) : super(key: key);

  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text(id),),);
  }
}