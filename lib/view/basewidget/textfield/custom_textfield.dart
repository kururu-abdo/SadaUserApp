import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textInputType;
  final int? maxLine;
  final bool? enabled;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final bool isPhoneNumber;
  final bool isValidator;
  final String? validatorMessage;
  final Color? fillColor;
  final TextCapitalization capitalization;
  final bool isBorder;

  CustomTextField(
      {this.controller,
      this.hintText,
      this.textInputType,
      this.maxLine,
      this.focusNode,
      this.nextNode,
      this.textInputAction,
      this.isPhoneNumber = false,
      this.isValidator=false,
      this.validatorMessage,
      this.capitalization = TextCapitalization.none,
      this.fillColor,
      this.isBorder = false, this.enabled= true,
      });

  @override
  Widget build(context) {
    var isRtl = Directionality.of(context)==TextDirection.rtl;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
         Visibility(
          visible: !hintText!.isEmpty,
          child: 
         
         Column(
          children: [

            Text(
          
          hintText ?? '' ,
         
         style: Theme.of(context).textTheme.titleMedium,
         
         ),
             SizedBox(height: 5,),
          ],
         )
         
         ),
     
        Container(
           width: double.infinity,
          decoration: BoxDecoration(
            // color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.circular(6),
            // boxShadow: [
            //   BoxShadow(color: Colors.grey.withOpacity(0.2), 
            //   spreadRadius: 1, blurRadius: 6,
            //    offset: Offset(0, 1)) // changes position of shadow
            // ],
          ),
          // decoration: BoxDecoration(
          //   border: isBorder? Border.all(width: .8,color: Theme.of(context).hintColor):null,
          //   color: Theme.of(context).highlightColor,
          //   borderRadius: isPhoneNumber ? BorderRadius.only(topRight: Radius.circular(6), bottomRight: Radius.circular(6)) : BorderRadius.circular(6),
          //   boxShadow: [
          //     BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1)) // changes position of shadow
          //   ],
          // ),
          child:  ClipRRect(
            // borderRadius: BorderRadius.circular(6),
            child: TextFormField(
              textAlign: 
              
              // isBorder? TextAlign.center:
              isRtl?TextAlign.end:
              TextAlign.start
              
              ,
            enabled: enabled,
              controller: controller,
              maxLines: maxLine ?? 1,
              textCapitalization: capitalization,
              maxLength: isPhoneNumber ? 10 : null,
              focusNode: focusNode,
              keyboardType: textInputType ?? TextInputType.text,
              //keyboardType: TextInputType.number,
              initialValue: null,
              textInputAction: textInputAction ?? TextInputAction.next,
          
          
              onTapOutside: (event) {
                      print('onTapOutside');
                      FocusScope.of(context).unfocus();
                    },
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(nextNode);
              },
              //autovalidate: true,
              inputFormatters: [isPhoneNumber ? FilteringTextInputFormatter.digitsOnly : FilteringTextInputFormatter.singleLineFormatter],
              validator: (input){
                if(input!.isEmpty){
                  if(isValidator){
                    return validatorMessage??"";
                  }
                }
                return null;
          
              },
              decoration: InputDecoration(
          hintTextDirection: TextDirection.ltr,
                // hintText: hintText ?? '',
                filled:true,
                fillColor: 
                // Color(0xFFf9fafc),
                
               ColorResources.getTextfieldFilledColor(context)

        
                ,
                contentPadding: 
                EdgeInsets.symmetric(vertical: 12.0, 
                horizontal: 15),
                isDense: true,
                counterText: '',


// enabledBorder:OutlineInputBorder(borderSide: BorderSide(
//                     width: .2,
                    
                    
//                     color: ColorResources.getTextfieldFilledColor(context))) ,
                  
                  border: 
                  InputBorder.none,
                  // OutlineInputBorder(borderSide: BorderSide(
                  //   width: .2,
                    
                    
                  //   color: ColorResources.getTextfieldFilledColor(context))),

 disabledBorder: 
                  // InputBorder.none,
                  InputBorder.none,


                focusedBorder:
                InputBorder.none
                //  OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor))
                 ,
                hintStyle:
                 titilliumRegular.copyWith(color: 
                 Theme.of(context).hintColor),
                errorStyle: TextStyle(height: 1.5),
                // border: InputBorder.none,
                floatingLabelBehavior:
                 FloatingLabelBehavior.always,
          
                prefixIcon:
                isPhoneNumber?
                
                isRtl?null: Container(
                  padding: EdgeInsets.zero,
                  width: 30,
                  decoration: BoxDecoration(
                    
                  ),
                  child: Center(
                    child: Text(
                           '966',
                        // showFlagMain: true,
                            style: TextStyle(
                                // color: Colors.black
                                
                         color:       Theme.of(context).textTheme.displayLarge!.color ,
                         fontWeight: FontWeight.bold
                                
                                ),
                          ),
                  ),
                ):null,
           suffixIcon:
           isPhoneNumber?
           isRtl? 
           
           Container(
                  padding: EdgeInsets.zero,
                  width: 30,
                  child: Center(
                    child: Text(
                           '966',
                        // showFlagMain: true,
                            style: TextStyle(
                                // color: Colors.black
                                
                         color:       Theme.of(context).textTheme.displayLarge!.color ,
                         fontWeight: FontWeight.bold
                                
                                ),
                          ),
                  ),
                ):null
          :null
          //           prefix:  Flex(
          //           direction: Axis.horizontal,
          //           mainAxisSize: MainAxisSize.min,
          // children: [
          //    Flexible(
          //                 fit: isRtl ? FlexFit.tight : FlexFit.loose,
          //                 child: Text(
          //                  '966',
          //               // showFlagMain: true,
          //                   style: TextStyle(
          //                       color: Colors.black
                            
          //                       // Theme.of(context).textTheme.headline1.color
                            
          //                       ),
          //                 ),
          //                   // overflow: widget.textOverflow,
                      
          //               ),
          // ],
          //           )
              ),
            ),
          ),
        ),
      ],
    );
  }
}
