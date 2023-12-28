import 'package:eamar_user_app/utill/sizes.dart';
import 'package:flutter/material.dart';

class BrandItem extends StatelessWidget {
  final String? icon;
  final String? title;
  final Function()? onTap;
  const BrandItem({super.key, this.icon, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return 
    
    LayoutBuilder(
builder:(context, constraints) {
if (isTablet(context)) {
return  
    
    GestureDetector(
      onTap: (){
        onTap!();
      },
      child: Container(
        padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 2),
        height: MediaQuery.of(context).size.height/8,
        width: MediaQuery.of(context).size.width,
        // width: 300,
        decoration: BoxDecoration(
          color: Color(0xFFffb239,
      
      ),  

      borderRadius: BorderRadius.circular(5)
        ), 
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100, width: 100 ,
          
              decoration: BoxDecoration(
                color: Colors.black  ,  
          
                shape: BoxShape.circle
              ),
              child: Center(child: ImageIcon(AssetImage(icon!), color: Colors.white,size: 50,)),
            ) , 
            SizedBox(width: 20,) ,  
          
            Text(title! , style: TextStyle(
              fontSize: 30,
              color: Colors.black , fontWeight: FontWeight.bold
            ),)
          ],
        ),
        
      ),
    );
 
} else {
return  
    
    GestureDetector(
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
);
    
    
    
    
    GestureDetector(
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