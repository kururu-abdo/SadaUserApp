import 'package:eamar_user_app/view/screen/branches/branch_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BranchWidget extends StatelessWidget {
  final String? branch;
  const BranchWidget({super.key, this.branch});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40, 
    
     margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5,), 
     padding: EdgeInsets.symmetric(horizontal: 10),
     decoration: BoxDecoration(
      color: Colors.white
     ),
     child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(branch! , ),

        GestureDetector(
          onTap: (){
            Navigator.of(context)
            .push(
              MaterialPageRoute(builder: (_)=>   BranchMapPage(
                branch: branch,
              ))
            );
          },
          child: Container(
            height: 40, 
            width: 150, 
            decoration: BoxDecoration(
              color: Color(0xFF0FFe69211),
              borderRadius: BorderRadius.circular(50)
            ),
            child: Center(
              child: Text("الذهاب للموقع" ,  ),
            ),
          ),
        ) 
      ],
     ),
    );
  }
}