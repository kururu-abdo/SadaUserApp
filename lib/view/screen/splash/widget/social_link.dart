import 'package:eamar_user_app/utill/sizes.dart';
import 'package:flutter/material.dart';

class SocialLink extends StatelessWidget {
  final String? link;
  final String? icon;

  const SocialLink({super.key, this.link, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
         height: 
    isTablet(context)?60: 30,
         width:isTablet(context)?60: 30,
      decoration: BoxDecoration(
        color: Colors.white ,shape: BoxShape.circle , 
        
      ),
      child: Center(child: ImageIcon(AssetImage(icon! ) , size:
      isTablet(context)?30:
      
       20,),),
    );
  }
}