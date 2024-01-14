import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/view/basewidget/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

enum RatingType{
  Captain , Product
}
class RatingBottmSheet extends StatefulWidget {
  final String? title;
  final String? desc;
  final Function(double?,String?)? onTap;
  final RatingType? ratingType;
  const RatingBottmSheet({super.key, this.title, this.desc, this.onTap, this.ratingType
  =RatingType.Captain
  });

  @override
  State<RatingBottmSheet> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingBottmSheet> {




  TextEditingController textEditingController =TextEditingController();


  double rate=0.0;
  @override
  Widget build(BuildContext context) {
    return   Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      width: MediaQuery.of(context).size.width,
      height:  MediaQuery.of(context).size.height*.90,
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child:
Column(children: [ 

Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    SizedBox.shrink(),
    Center(child: Text(
      getLang(context)=="ar"?
      "ما هو تقييمك؟":
      
      'What is your rate?'
    ,
    style: TextStyle(
      fontWeight: FontWeight.bold
    ),
    
    
    ),),

    GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Container(
        height: 35,width:35 , 
      
        decoration: BoxDecoration(
          shape: BoxShape.circle , 
          color: Colors.grey.shade300
        ),
      
        child: Center(
          child: Center(
            child: Icon(Icons.close , 
            
             color: Colors.grey.shade400
            ),
          ),
        ),
      ),
    )
  
  
  ],
)   , 

SizedBox(height: 15,),

RatingBar.builder(
   initialRating: 0,
   minRating: 0,
   direction: Axis.horizontal,
   allowHalfRating: true,
   itemCount: 5,
   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
   itemBuilder: (context, _) => Icon(
     Icons.star,
     color: Colors.amber,
   ),
   onRatingUpdate: (rating) {
     print(rating);
   },
)
, 
SizedBox(height: 20,),
Center(
  child: SizedBox(width: 180, 
  
  
  child: Text(

    widget.ratingType==RatingType.Captain?
       getLang(context)=="ar"?
                    "شارك رأيك بخصوص  كابتن الصيانة":
                    'Please share your opinion about Maintenance captain'
            :
       getLang(context)=="ar"?
                    "فضلا قم بتقييم  المنتج ، رايكم يهمنا.":      

    'Please share your opinion about our product', 
style: TextStyle(
  fontWeight: FontWeight.bold , 
  wordSpacing: 5
),
    textAlign: TextAlign.center,
    maxLines: 3,
    overflow: TextOverflow.ellipsis,
  ),
  ),
),

SizedBox(height: 10,),
       TextFormField(
        // focusNode: focusNode,
        controller: textEditingController,
        onTapOutside: (event){
          // focusNode.unfocus();
                                FocusScope.of(context).unfocus();
      
        },
        onFieldSubmitted: (str){
      // searchProvider.saveSearchAddress(str);
        },
      // controller: searchController,
        style: TextStyle(
          // color: Colors.grey[400] , 
        fontSize: 15 , fontWeight: FontWeight.w500
        ),
        maxLines: 15,
      decoration: InputDecoration( 
      hintText: 
      getLang(context)=="ar"?"اكتب تعاليق":
      'You Review...',
      hintStyle: 
      
      
       TextStyle(
  fontWeight: FontWeight.w300, 
  color: Colors.black54
)
      ,
      // prefixIcon: Icon(Icons.search ,size: 30,),
      // suffixIcon: IconButton(onPressed: (){
      // // searchController.clear();
      // }, icon: Icon(Icons.close)),
        fillColor: Colors.black54.withOpacity(.1), 
        filled: true , 
      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5) , 
          borderSide: BorderSide(width: .2 , )
        ), 
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5) , 
          borderSide: BorderSide.none
        ), 
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5) , 
          borderSide: BorderSide.none
        ), 
      
      
      
      ),
      
      ),
    
Spacer() , 

CustomButton(
  buttonText:
  
  
  getLang(context)=="ar"?
  "ارسال التقييم":
  
   'Review',
  isFilled: true,
  onTap: (){

widget.onTap!(

  rate ,textEditingController.text
);
  },

),
SizedBox(height: 20,)

],)

    );
  }
}