import 'package:eamar_user_app/utill/sizes.dart';
import 'package:eamar_user_app/view/screen/branches/widgets/branch_widget.dart';
import 'package:eamar_user_app/view/screen/splash/widget/available_on.dart';
import 'package:eamar_user_app/view/screen/splash/widget/social_link.dart';
import 'package:flutter/material.dart';

class BranchesPage extends StatelessWidget {
  const BranchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return     Scaffold(
    extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      
appBar: PreferredSize(
  preferredSize: Size.fromHeight(
    isTablet(context)? 200:
    
    150),
  child:   Hero(
    tag: 'bar',
    child: GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: AppBar(
        leading: SizedBox.shrink(),
        flexibleSpace: Center(
          child: Image.asset('assets/images/logo_with_name.png'  ,
           color: Colors.white ,),
        ),
      backgroundColor: Color(0xFFe69211),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(100)
          )
        ),
      ),
    ),
  ),
),


body: Column(
  children: [
Container(
  padding: EdgeInsets.all(20),
  alignment: Alignment.center,
  height: MediaQuery.of(context).size.height*.770,
  color: Colors.black,
// decoration: BoxDecoration(
//   color: Theme.of(context).primaryColor.withOpacity(.90),
//   borderRadius: BorderRadius.vertical(
//         bottom: Radius.circular(100)
//       )
// ),


child: Column(
  crossAxisAlignment: CrossAxisAlignment.center,
mainAxisAlignment: MainAxisAlignment.center,
  children: [
SizedBox(height:  isTablet(context)?100: 160,) ,  

Column(
  mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,

  children: [
SizedBox(height: 50,),
    Icon(Icons.location_on 
    , size: 80, color: Colors.white,) , 
SizedBox(height: 8,) ,  
Text("فروعنا" ,   style: TextStyle(color: Colors.white, fontSize:  isTablet(context)?
30: 20),)

  ],
)
 ,
 Container(
  height:  isTablet(context)?MediaQuery.of(context).size.height/2.2
  
  : MediaQuery.of(context).size.height/2.7, 
  width: MediaQuery.of(context).size.width,
  child:  ListView(
    children: [ 
      BranchWidget(
        branch: 'الرياض - الملز',
      ),
  BranchWidget(
        branch: 'القصيم - حي النفل',
      ),
  BranchWidget(
        branch: 'جدة - الملز',
      ),
  BranchWidget(
        branch: 'الرياض - الملز',
      ),


  BranchWidget(
        branch: 'الرياض - الملز',
      ),
  BranchWidget(
        branch: 'الرياض - الملز',
      ),


    ],
  ),
 ),




  ],
)
)

, 
Spacer(),

Column(
  crossAxisAlignment: CrossAxisAlignment.center , 

  children: [

    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   children: [
    //     AvailableOn(
    //       title: 'GET IT ON',
    //       storeName: 'Google Play',
    //       icon:"assets/images/google-play.png" ,

    //     ) , 
        
    //     AvailableOn(
    //       title: 'Available on',
    //       storeName: 'App Store',
    //         icon:"assets/images/apple.png" ,
    //     ),
    //   ],
    // ) , 
    
  
  SizedBox(height: 20,),
Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
children: [
  SocialLink(
icon: "assets/images/facebook-app-symbol.png",
  ) ,
  
  SizedBox(width: 10,)
  , SocialLink(
    icon: "assets/images/instagram-symbol.png",
  ) ,
  
  SizedBox(width: 10,), SocialLink(
    icon: "assets/images/google-plus-logo.png",
  ),
  
  SizedBox(width: 10,) , SocialLink(
     icon: "assets/images/twitter1.png",
  )
],
),
    // Spacer()  , 
  SizedBox(height: 10,),
    Text('الحقوق محفوظة لصدى الاعمار ' , style: TextStyle(
      color: Colors.white ,fontWeight: FontWeight.w500 , 
    ),)
,
      SizedBox(height: 20,),

  ],
)

  ],
),
  
  
  


    );
  }
}