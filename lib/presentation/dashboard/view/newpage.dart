import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';




class Name extends StatefulWidget {

State<Name> createState()=>  _Namestate();
} 

class _Namestate extends  State<Name> {
  @override
  Widget build(BuildContext context) {
    return  Column(
       children: [

       ElevatedButton(onPressed: (){

          }, child:  const Text("Submit") ),


           


       ],
     );
  }
}