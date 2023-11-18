import 'dart:async';
import 'dart:developer';

import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/auth_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/shake_widget.dart';
import 'package:eamar_user_app/view/screen/auth/auth_screen.dart';
import 'package:eamar_user_app/view/screen/cart/widget/maintenance_captain_alert.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/provider/splash_provider.dart';
import 'package:eamar_user_app/utill/app_constants.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:open_whatsapp/open_whatsapp.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class JobContainer extends StatefulWidget {
final   String?  image;
final   String?  name;
final   String?  job;
final   String?  desc;
final   String?  email;

final   String?  phone;

final   String?  address;


  
  const JobContainer({ Key? key, this.image, this.name, this.job, this.desc, this.email, this.phone, this.address }) : super(key: key);

  @override
  State<JobContainer> createState() => _JobContainerState();
}

class _JobContainerState extends State<JobContainer> {
  final _shakeKey = GlobalKey<ShakeWidgetState>();

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
  // mainAxisAlignment: MainAxisAlignment.,
mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [


Row( crossAxisAlignment: CrossAxisAlignment.center,
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
    (widget.image ==null?
    AssetImage(Images.placeholder ):
    
    NetworkImage(
      AppConstants.BASE_URL+"/"+
      
      widget.image.toString())) as ImageProvider<Object>?
  ),


),
SizedBox(width: 20,),
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(widget.name! ,  style: Theme.of(context).textTheme.titleMedium,),

Text(widget.job! ,  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
  color: Theme.of(context).primaryColor ,fontWeight: FontWeight.bold
),),
Text(
  widget.address! ,  style: Theme.of(context).textTheme.bodyMedium,
),



// TextButton.icon(onPressed: ()async{
//   await _launchMail(email);
// }, icon: Icon(Icons.email_outlined ,
// color: Theme.of(context).primaryColor,
// ), label: SizedBox(
//   width: MediaQuery.of(context).size.width/4,
//   child:   Text(
//     email ,  
  
//     overflow: TextOverflow.ellipsis
//     , style: Theme.of(context).textTheme.bodyMedium,
//   ),
// ))




  ],
)
, 
  ],
)

,
GestureDetector(

onTap: (){


            
                                final _dialog = RatingDialog(
                  initialRating: 1.0,
                  // your app's name?
                  title: Text(
                    getLang(context)=="ar"?
                    "تقييم كابتن الصيانة":
                    'Rate Maintenance Captain'
                    
                    ,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
                    ),
                  ),
                  // encourage your user to leave a high rating?
                  message: Text(
                    getLang(context)=="ar"?
                    "شارك رأيك بخصوص  كابتن الصيانة":
                    'Please share your opinion about Maintenance captain'
                    
                    ,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
                  ),
                  // your app's logo?
                  // image: const FlutterLogo(size: 100),
                  submitButtonText:
                  
                                      getLang(context)=="ar"?
"اضافة تقييم":
                  
                   'Add Rating',
                  commentHint: 
                                      getLang(context)=="ar"?
"اكتب رأيك":
                  
                  'let see you opinion',
                  onCancelled: () => print('cancelled'),
                  onSubmitted: (response) {
                    print('rating: ${response.rating}, comment: ${response.comment}');
            //
            
            //call api to send rate
            
            
            
                    // TODO: add your own logic
                    // if (response.rating < 3.0) {
                    //   // send their comments to your email or anywhere you wish
                    //   // ask the user to contact you instead of leaving a bad review
                    // } else {
                    //   // _rateAndReviewApp();
                    // }
                  },
                );
            
              showDialog(
                  context: context,
                  barrierDismissible: true, // set to false if you want to force a rating
                  builder: (context) => _dialog,
                );







},


  child:   Row(
    mainAxisSize: MainAxisSize.min,
    children: [
  Icon(Icons.star , 
  
  color: Colors.amber,
  
  ) , 
  SizedBox(width: 2,) , 
  Text(
    '(${0})'
  )
  
  
    ],
  ),
)

  ],
) ,

SizedBox(width: 10,),

SizedBox(
  width: double.infinity,
  child:   Text(widget.desc!, textAlign: TextAlign.justify ,maxLines: 3 ,overflow: TextOverflow.ellipsis,
  
    style: Theme.of(context).textTheme.bodySmall,),
),

Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,

  children: [




 IconButton(onPressed: ()async{
//https://wa.me/+966${w}/?text=Hello

if(Provider.of<AuthProvider>(context , listen: false)
.isLoggedIn()){

 showDialog(context: context, builder: (_)=> MaintenanceCaptainAlertConfirmationDialog(
                  
                   onYes: ()async{

await FirebaseAnalytics.instance.logEvent(
    name: "job_whatsapp",
    parameters: {
        "name":widget.name      ,
        "time": DateTime.now().toString(),
        "job":widget.job
    },
);
var encoded = Uri.encodeFull("whatsapp://send?phone=+966${widget.phone}");

await _launchWhatsapp(encoded);


                   },
                  ));
}else {

  Navigator.of(context).push(
    MaterialPageRoute(builder: (_)=>  AuthScreen())
  );
}








try {
  // log('Pressed');
  
  //     FlutterOpenWhatsapp.sendSingleMessage("966${phone}", "Hello").then((value) {
  //       log(value.toString());
  //     } as FutureOr<void> Function(Null));
  //       log('After Lauch');


} catch (e) {
  log('Exception');

  log(e.toString());
}


 }, icon: FaIcon(FontAwesomeIcons.whatsapp ,  size: 35,)) ,






 ShakeWidget(
  shakeCount: 3,
          shakeOffset: 10,
          shakeDuration: Duration(milliseconds: 400),
  key: _shakeKey,
   child: IconButton(onPressed: ()async{
 _shakeKey.currentState?.shake();
 
   }, icon: FaIcon(Icons.notifications_active_outlined ,  size: 35,
   
   color: ColorResources.getArrowButtonColor(context),
   
   )),
 ) ,





InkWell(
  onTap: ()async{

if(Provider.of<AuthProvider>(context , listen: false)
.isLoggedIn()){
 showDialog(context: context, builder: (_)=> MaintenanceCaptainAlertConfirmationDialog(
                  
                   onYes: ()async{

 await FirebaseAnalytics.instance.logEvent(
    name: "job_call",
    parameters: {
        "name":widget.name      ,
        "time": DateTime.now().toString(),
        "job":widget.job
    },
);
    await _makePhoneCall(widget.phone);


                   },
                  ));

}else {

  Navigator.of(context).push(
    MaterialPageRoute(builder: (_)=>  AuthScreen())
  );
}



      // Provider.of<ProfileProvider>(context,listen: false).userInfoModel.name;

   
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
         
          Text(widget.phone.toString(),style: TextStyle(
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

   Future<void> _makePhoneCall(String? phoneNumber) async {
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
      path: "$mail?subject=''=''",
    );
    await launchUrl(launchUri);
   } catch (e) {
   }
  }

   Future<void> _launchWhatsapp(String url) async {
   try {
      final Uri launchUri = Uri.parse(url);
    await launchUrl(launchUri);
   } catch (e) {
   }
  }
}