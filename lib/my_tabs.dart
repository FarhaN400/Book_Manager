import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Apptabs extends StatelessWidget{
  final Color color;
  final String text;
  const Apptabs({Key? key,required this.color,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 120,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: this.color,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.3),
        //     blurRadius: 7,
        //     offset: Offset(0, 0),
        //   )
        // ],
      ),
      child: Center(
        child: Text(
         this.text,style: TextStyle(color: Colors.white,fontSize: 15),
        ),
      ),
    );
  }
}