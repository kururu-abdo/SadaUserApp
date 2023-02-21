import 'package:flutter/material.dart';
import 'package:eamar_user_app/provider/splash_provider.dart';
import 'package:eamar_user_app/utill/app_constants.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class JobContainer extends StatelessWidget {
final   String  image;
final   String  name;
final   String  job;
final   String  desc;
final   String  email;

final   String  phone;

final   String  address;


  
  const JobContainer({ Key key, this.image, this.name, this.job, this.desc, this.email, this.phone, this.address }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width
      ),
      //  height: 
      //   MediaQuery.of(context).size.width/1.5  ,
        
        // MediaQuery.of(context).size.width/1.5,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).highlightColor,
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)],
        ),

child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [

Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
Container(
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(
      width: 1.5,color: Theme.of(context).primaryColor
    )
  ),
  child:   CircleAvatar(
    radius: 30,
    backgroundImage: 
    image ==null?
    AssetImage(Images.placeholder ):
    
    NetworkImage(
      AppConstants.BASE_URL+"/"+
      
      image.toString())
  ),


),
SizedBox(width: 10,),
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(name ,  style: Theme.of(context).textTheme.titleMedium,),

Text(job ,  style: Theme.of(context).textTheme.bodyMedium.copyWith(
  color: Theme.of(context).primaryColor ,fontWeight: FontWeight.bold
),),


TextButton.icon(onPressed: ()async{
  await _launchMail(email);
}, icon: Icon(Icons.email_outlined ,
color: Theme.of(context).primaryColor,
), label: SizedBox(
  width: MediaQuery.of(context).size.width/4,
  child:   Text(
    email ,  
  
    overflow: TextOverflow.ellipsis
    , style: Theme.of(context).textTheme.bodyMedium,
  ),
))
,

  ],
)


  ],
) ,

SizedBox(width: 10,),

SizedBox(
  width: double.infinity,
  child:   Text(desc, textAlign: TextAlign.justify ,maxLines: 3 ,overflow: TextOverflow.ellipsis,
  
    style: Theme.of(context).textTheme.bodySmall,),
),

Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,

  children: [



Text(
  address ,  style: Theme.of(context).textTheme.bodyMedium,
),






InkWell(
  onTap: ()async{
    await _makePhoneCall(phone);
  },
  child:   Container(
    decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(8),
  color: Colors.green
  
  // Theme.of(context).colorScheme.primary
    ),
    padding: EdgeInsets.all(10),
    child: Center(
      child: Row(
        textDirection: TextDirection.ltr,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.call ,
          color: Theme.of(context).highlightColor,
          ),
         
          Text(phone.toString(),style: TextStyle(
            color: Colors.white,fontWeight: FontWeight.bold
          ),),
  
  
        ],
      ),
    ),
  ),
)






  ],
)





  ],
),



    );
  }



   Future<void> _makePhoneCall(String phoneNumber) async {
   try {
      final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
   } catch (e) {
   }
  }

    Future<void> _launchMail(String mail) async {
   try {
      final Uri launchUri = Uri(
      scheme: 'mailto',
      path: "${mail}?subject=''=''",
    );
    await launchUrl(launchUri);
   } catch (e) {
   }
  }
}