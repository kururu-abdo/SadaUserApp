import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/phone_email_controller.dart';
import 'package:eamar_user_app/view/basewidget/button/auth_button.dart';
import 'package:eamar_user_app/view/basewidget/button/custom_button.dart';
import 'package:eamar_user_app/view/screen/auth/widget/phone_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';





class EmailOrPhone {
  bool? isPhone;
  bool? isEmail;
  String? emailOrPhone;
EmailOrPhone({this.emailOrPhone , this.isEmail, this.isPhone});

 EmailOrPhone copyWith({
  bool? isPhone,
  bool? isEmail,
  String? emailOrPhone
  }) {
    return EmailOrPhone(
    isPhone :isPhone  ?? this.isPhone,
      isEmail: isEmail ?? this.isEmail,
      emailOrPhone: emailOrPhone ?? this.emailOrPhone,
     
    );
  }

}

class EnterPhoneOrEmail extends StatefulWidget {
Function(EmailOrPhone)? onSelect;

   EnterPhoneOrEmail({super.key , this.onSelect});

  @override
  State<EnterPhoneOrEmail> createState() => _EnterPhoneOrEmailState();
}

class _EnterPhoneOrEmailState extends State<EnterPhoneOrEmail> {
TextEditingController emailController = 

TextEditingController();
TextEditingController phoneController = 

TextEditingController();
EmailOrPhone emailOrPhone=  EmailOrPhone();

int _selectOption = 0;

String? inintalPhone='';
@override
void initState() {
  super.initState();
   if(Provider.of<PhoneEmailController>(context , listen: false).emailOrPhone!=null){

if (Provider.of<PhoneEmailController>(context , listen: false).emailOrPhone!.isPhone!) {
   _selectOption = 0;

 inintalPhone=Provider.of<PhoneEmailController>(context , listen: false).emailOrPhone!.emailOrPhone;



 emailOrPhone = EmailOrPhone(
            
          ).copyWith(
            isPhone: true, 
            isEmail: false , 
            emailOrPhone: inintalPhone
          );

}else {

  _selectOption = 1;

 emailController.text=Provider.of<PhoneEmailController>(context , listen: false).emailOrPhone!.emailOrPhone!;
 emailOrPhone = EmailOrPhone(
            
          ).copyWith(
            isPhone: false, 
            isEmail: true , 
            emailOrPhone: emailController.text
          );
}
   }
}




  @override
  Widget build(BuildContext context) {
    return  Scaffold(

appBar: AppBar(
  backgroundColor: Colors.transparent,
leading: IconButton(onPressed: (){
  Navigator.pop(context);
}, icon: Icon(Icons.arrow_back_ios)),
),
body: SafeArea(
  child:   SizedBox.expand(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
    
        children: [
    
    Text(
      
      getLang(context)=="ar"?"الرجاء ادخال رقم الهاتف او البريد الالكتروني:":
      'Please Select Email or phone number: ') , 
    SizedBox(height: 30,),
  
  
  
    GestureDetector(
      onTap: (){
        _selectOption=0;
         emailOrPhone = EmailOrPhone(
            
          ).copyWith(
            isPhone: true, 
            isEmail: false , 
            emailOrPhone: phoneController.text
          );
      setState(() {
        
      });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
      Checkbox(value:_selectOption==0 , onChanged: (value){
      
      if(value!){
        _selectOption=0;
         emailOrPhone = EmailOrPhone(
            
          ).copyWith(
            isPhone: true, 
            isEmail: false , 
            emailOrPhone: phoneController.text
          );
        setState(() {
          
        });
      }
      
      }) ,  
      
      Text(
        getLang(context)=="ar"?"رقم الهاتف":
        'Phone Number')
      
      
      
      
            ],
          ) , 
      
      
      
          PhoneWidget(
            enabled: _selectOption==0,
            controller: phoneController,
            initalNumber: inintalPhone,
            onchanged: (str){
  emailOrPhone = EmailOrPhone(
            
          ).copyWith(
            isPhone: true, 
            isEmail: false , 
            emailOrPhone: str
          );
            },
          )
        ],
      ),
    )
    ,
      SizedBox(height: 10,),
  
    GestureDetector(
      onTap: (){
          _selectOption=1;
          emailOrPhone = EmailOrPhone(
            
          ).copyWith(
            isPhone: false, 
            isEmail: true , 
            emailOrPhone: emailController.text
          );
      setState(() {
        
      });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
      Checkbox(value:_selectOption==1 , onChanged: (value){
      
      if(value!){
        _selectOption=1;
         emailOrPhone = EmailOrPhone(
            
          ).copyWith(
            isPhone: false, 
            isEmail: true , 
            emailOrPhone: emailController.text
          );
        setState(() {
          
        });
        
      }
      
      }) ,  
      
      Text(
           getLang(context)=="ar"?"البريد الالكتروني":
        
        
        'Email ')
      
      
      
      
            ],
          ) , 
      
      
      
          Container(
          width: double.infinity,
          margin: new EdgeInsets.only(top: 10.0, bottom: 10.0, right: 3.0),
          color: Colors.white,
          child: new TextFormField(
            controller: emailController,
            validator: (value) {
              if (value!.isEmpty) {
                return 
                 getLang(context)=="ar"?
                 "هذا الحقل مطلوب":
                'This field is required';
              }
              else if(!EmailValidator.validate(value.trim())){
return 
                 getLang(context)=="ar"?
                 "البريد غير صالح":
                'Email is Invalid';
              }
              return null;
            },
            onChanged: (str){
               emailOrPhone = EmailOrPhone(
            
          ).copyWith(
            isPhone: false, 
            isEmail: true , 
            emailOrPhone: str
          );
            },
          
            keyboardType: TextInputType.emailAddress,
            enabled: _selectOption==1,
            decoration:  InputDecoration(
              counterText: '',
                contentPadding: const EdgeInsets.only(
                  top:
                  12.0 ,  ),
                border: InputBorder.none,
                filled: true,
                fillColor: Theme.of(context).highlightColor,
                // prefixIcon: countryDropDown,
                hintText: 'Email ',
                labelText: ''),
          ),
        )
        ],
      ),
    )
    ,
  
  Spacer()
  ,  
  
  AuthButton(buttonText: 
  
     getLang(context)=="ar"?"متابعة":
  'Continue',  
  isBorder: true,
  
  onTap: (){
  
    widget.onSelect!(
  
      emailOrPhone
    );
    Provider.of<PhoneEmailController>(context ,listen: false).
    setMethodd(emailOrPhone);
  Navigator.pop(context);
  
  
  
  
  },
  )
    
        ],
      ),
    ),
  ),
),




    );
  }
}