import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class TextArea extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textInputType;
  final  Function(String)? onFieldSubmitted;
  final int? maxLine;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final bool isPhoneNumber;
  final bool isValidator;
  final String? validatorMessage;
  final Color? fillColor;
  final TextCapitalization capitalization;
  final bool isBorder;

  TextArea(
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
      this.isBorder = false, this.onFieldSubmitted,
      });

  @override
  Widget build(context) {
    var isRtl = Directionality.of(context)==TextDirection.rtl;
    return Container(
      width: double.infinity,
      //  width: double.infinity,

                //                  margin:
                // EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          // BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)) // changes position of shadow
        ],
      ),
      // decoration: BoxDecoration(
      //   border: isBorder? Border.all(width: .8,color: Theme.of(context).hintColor):null,
      //   color: Theme.of(context).highlightColor,
      //   borderRadius: isPhoneNumber ? BorderRadius.only(topRight: Radius.circular(6), bottomRight: Radius.circular(6)) : BorderRadius.circular(6),
      //   boxShadow: [
      //     BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1)) // changes position of shadow
      //   ],
      // ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(
          
          hintText ?? '' ,
         
         style: Theme.of(context).textTheme.titleMedium,
         
         ),
         SizedBox(height: 5,),
          TextFormField(
                  textAlign: TextAlign.start,
            controller: controller,
            minLines: 2,
            maxLines:isTablet(context)?12: 8,
            textCapitalization: capitalization,
            maxLength: isPhoneNumber ? 10 : null,
            focusNode: focusNode,
            
            keyboardType:  TextInputType.multiline,
            //keyboardType: TextInputType.number,
            initialValue: null,
            // textInputAction: TextInputAction.newline,
          
              onTapOutside: (event) {
                      print('onTapOutside');
                      FocusScope.of(context).unfocus();
                    },
            
            onFieldSubmitted:
             (v) {
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
          
              hintText: '',
              filled: true,
              fillColor: ColorResources.getTextfieldFilledColor(context),
              contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
              isDense: true,
              counterText: '',
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
              hintStyle: titilliumRegular.copyWith(color: Theme.of(context).hintColor),
              errorStyle: TextStyle(height: 1.5),
              border: InputBorder.none,
              floatingLabelBehavior: FloatingLabelBehavior.always,
          
          
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
        ],
      ),
    );
  }
}
