import 'package:flutter/material.dart';

class CategoryTitle extends StatelessWidget {
  final String? title; 
  final bool? hasChilds;
  final Function()? onTap;
  const CategoryTitle({super.key, this.title, this.hasChilds=false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ 
    
        if (hasChilds!) {
          onTap!();
        }
      },
      child: Row(
      
        mainAxisSize: MainAxisSize.min, 
      
        children: [  
      
      
          Text(title!,  style: TextStyle(
            color: Theme.of(context).primaryColor , 
            fontWeight: FontWeight.bold , 
            fontSize: 18  
           ),
           
           ), 
      
           SizedBox(width: 3,) , 
           Icon(Icons.arrow_forward_ios ,      color: Theme.of(context).primaryColor ,    )
        ],
      ),
    );
  }
}