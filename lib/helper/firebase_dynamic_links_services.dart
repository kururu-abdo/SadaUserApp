import 'dart:developer';

import 'package:eamar_user_app/data/model/response/product_model.dart';
import 'package:eamar_user_app/di_container.dart';
import 'package:eamar_user_app/view/screen/product/product_details_screen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class DymanicLinksServices {

 static  Future<String> createDynamicLink(bool short ,Product product) async {
  
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://eamar.page.link',
      // longDynamicLink: Uri.parse(
      //   'https://eamar.page.link?efr=0&ibi=io.flutter.plugins.firebase.dynamiclinksexample&apn=io.flutter.plugins.firebase.dynamiclinksexample&imv=0&amv=0&link=https%3A%2F%2Fexample%2Fhelloworld&ofl=https://ofl-example.com',
      // ),
      link: Uri.parse("https://sada.com/product?id=${product.id}&slug=${product.slug}&seller=${product.userId}"),
      androidParameters: const AndroidParameters(
        packageName: 'com.eamar.user',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.eamar.user',
        minimumVersion: '0',
      ),
    );

    Uri url;
   if(short){
     final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }

return url.toString();
  }



static Future<void> initDynamicLink(BuildContext context)async{



 FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
   var deepLink = dynamicLinkData.link;
   bool isProdutct =deepLink.pathSegments.contains('product');
   if (isProdutct) {
     try {
       if (deepLink!=null) {
       var productId =deepLink.queryParameters['id'];
     var slug=deepLink.queryParameters['slug'];
     var seller=deepLink.queryParameters['seller'];
      Navigator.push(context, 
      
      MaterialPageRoute(builder: (_)=>ProductDetails(product: null ,
      
      slug: slug,
      id: productId,
      seller: seller,
      
      ))
      );
     }
     } catch (e) {
       log(e.toString());
     }

   }else {
     
     
   }
     
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });


var pendingInitLink =await  FirebaseDynamicLinks.instance.getInitialLink();


var deepLink=pendingInitLink.link;
  bool isProdutct =deepLink.pathSegments.contains('product');

   if (isProdutct) {
     try {
       if (deepLink!=null) {
       var productId =deepLink.queryParameters['id'];
     var slug=deepLink.queryParameters['slug'];
     var seller=deepLink.queryParameters['seller'];
      Navigator.push(context, 
      
      MaterialPageRoute(builder: (_)=>ProductDetails(product: null ,
      
      slug: slug,
      id: productId,
      seller: seller,
      
      ))
      );
     }
     } catch (e) {
       log(e.toString());
     }

   }else {
     
     
   }



}
}