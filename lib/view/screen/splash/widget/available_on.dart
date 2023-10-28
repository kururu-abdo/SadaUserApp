import 'package:flutter/material.dart';

class AvailableOn extends StatelessWidget {
  final String? storeName; 
    final String? title; 
  final String? icon; 

  const AvailableOn({super.key, this.storeName, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, 
      height: 65,
  padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
       border: Border.all(
         color: Colors.white, width: 1
       )

      ),
      child: Row(
     crossAxisAlignment: CrossAxisAlignment.center,
     children: [

      Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          // color: Colors.white,
          // shape: BoxShape.circle
        ),
        child: Center(
          child: Image.asset(icon!),
        ),
      ), 

SizedBox(width: 8,),      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title! , style: TextStyle(
            fontSize: 15 , fontWeight: FontWeight.w500 , 
            color: Colors.white
          ),) , 

          Text(storeName! , style: TextStyle(
            fontSize: 20 , fontWeight: FontWeight.bold , 
            color: Colors.white
          ),)
        ],
      )
     ],
      ),
    );
  }
}