import 'package:flutter/material.dart';

class BrandItem extends StatelessWidget {
  final String? icon;
  final String? title;
  final Function()? onTap;
  const BrandItem({super.key, this.icon, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap!();
      },
      child: Container(
    
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          color: Color(0xFFffb239

)
        ), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80, width: 80 ,
    
              decoration: BoxDecoration(
                color: Colors.black  ,  
    
                shape: BoxShape.circle
              ),
              child: Center(child: ImageIcon(AssetImage(icon!), color: Colors.white,size: 39,)),
            ) , 
            SizedBox(height: 10,) ,  
    
            Text(title! , style: TextStyle(
              color: Colors.black , fontWeight: FontWeight.bold
            ),)
          ],
        ),
        
      ),
    );
  }
}