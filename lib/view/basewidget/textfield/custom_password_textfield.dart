import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/auth_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final bool? isCustomer;
  final String? hintTxt;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;

  CustomPasswordTextField({
    this.isCustomer=false ,
    this.controller, this.hintTxt, this.focusNode, this.nextNode, this.textInputAction});

  @override
  _CustomPasswordTextFieldState createState() => _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(6),
        // boxShadow: [
        //   BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)) // changes position of shadow
        // ],
      ),
      child: Column(
        
         crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

           children: [
             Visibility(
              visible: widget.hintTxt!=null,
              child: 
             
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             
                Text(
              
              widget.hintTxt ?? '' ,
             
             style: Theme.of(context).textTheme.titleMedium,
             
             ),
                 SizedBox(height: 5,),
              ],
             )
             
             ),
// widget.isCustomer!?
//               Container(
//                 margin: EdgeInsets.only(right: Dimensions.MARGIN_SIZE_SMALL),
//                 child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [Row(children: [
//                     Consumer<AuthProvider>(
//                       builder: (context, authProvider, child) => Checkbox(
//                         checkColor: ColorResources.WHITE,
//                         activeColor: Theme.of(context).primaryColor,
//                         value: authProvider.isRemember,
//                         onChanged: authProvider.updateRemember,),),
        
        
//                     Text(getTranslated('REMEMBER', context)!,
//                      style: titilliumRegular),
//                   ],),
        
                   
//                   ],
//                 ),
//               ):SizedBox.shrink(),
           ],
         ),
     
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: TextFormField(
              cursorColor: Theme.of(context).primaryColor,
              controller: widget.controller,
              obscureText: _obscureText,
              focusNode: widget.focusNode,
              textInputAction: widget.textInputAction ?? TextInputAction.next,
                  onTapOutside: (event) {
                      print('onTapOutside');
                      FocusScope.of(context).unfocus();
                    },
              onFieldSubmitted: (v) {
                setState(() {
                  widget.textInputAction == TextInputAction.done
                      ? FocusScope.of(context).consumeKeyboardToken()
                      : FocusScope.of(context).requestFocus(widget.nextNode);
                });
              },
              validator: (value) {
                return null;
              },
              decoration: InputDecoration(
                  suffixIcon: IconButton(icon: Icon(_obscureText ?
                   Icons.visibility_off : Icons.visibility), onPressed: _toggle,
                   color: ColorResources.getPasswordIconColor(context),
                   
                   
                   
                   
                   ),
                
                  contentPadding:  EdgeInsets.symmetric(vertical: 
                  isTablet(context)? 18: 
                  12.0, horizontal: 15),
                  isDense: true,
                  filled: true,
                  fillColor: 
                  ColorResources.getTextfieldFilledColor(context)
                  
                  // Theme.of(context).highlightColor
                  ,
                  focusedBorder:
                  InputBorder.none ,
                  
                  //  OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                  hintStyle: titilliumRegular.copyWith(color: Theme.of(context).hintColor),
                 
                  enabledBorder:OutlineInputBorder(borderSide: BorderSide(
                    width: .5,
                    
                    
                    color: ColorResources.getTextfieldFilledColor(context))) ,
                  
                  border: 
                  // InputBorder.none
                  OutlineInputBorder(borderSide: BorderSide(
                    width: .5,
                    
                    
                    color: ColorResources.getTextfieldFilledColor(context))),
                  
                  
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
