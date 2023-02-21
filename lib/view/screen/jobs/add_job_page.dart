import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:eamar_user_app/data/model/body/register_model.dart';
import 'package:eamar_user_app/data/model/response/city.dart';
import 'package:eamar_user_app/data/model/response/job_model.dart';
import 'package:eamar_user_app/data/model/response/region.dart';
import 'package:eamar_user_app/helper/email_checker.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/auth_provider.dart';
import 'package:eamar_user_app/provider/jobs_provider.dart';
import 'package:eamar_user_app/provider/localization_provider.dart';
import 'package:eamar_user_app/utill/base64_converter.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/phone_utils.dart';
import 'package:eamar_user_app/view/basewidget/custom_app_bar.dart';
import 'package:eamar_user_app/view/basewidget/textfield/custom_textfield.dart';
import 'package:eamar_user_app/view/basewidget/textfield/custom_textfield2.dart';
import 'package:eamar_user_app/view/basewidget/textfield/dropdown_field.dart';
import 'package:eamar_user_app/view/basewidget/textfield/teaxt_area.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:validate_ksa_number/validate_ksa_number.dart';

import '../../../data/model/response/new_job_model.dart';

class AddJobPage extends StatefulWidget {
    final bool isBacButtonExist;

  const AddJobPage({ Key key, this.isBacButtonExist=true }) : super(key: key);

  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {

    bool isFirstTime = true;


var _fromKey = GlobalKey<FormState>();

TextEditingController _nameController=TextEditingController();
var  _nameFocus =FocusNode();


TextEditingController _descController=TextEditingController();
var  _descFocus =FocusNode();

TextEditingController _phoneController=TextEditingController();
var  _phoneFocus =FocusNode();

TextEditingController _photoController=TextEditingController();
var  _photoFocus =FocusNode();


TextEditingController _emailController=TextEditingController();
var  _emailFocus =FocusNode();

@override
void initState() { 
  super.initState();
  _loadData(context, false);
}
Future<void> _loadData(BuildContext context, bool reload) async {


await Provider.of<JobsProvider>(context, listen: false).getRegions( context ,
    Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode
    ,reload: reload
    
    );
await Provider.of<JobsProvider>(context, listen: false).getJobs( context ,
    Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode
    ,reload: reload
    
    );
  }












City  city;
Region  regoin
;

var  _cityFocus =FocusNode();

Job job;

var  _jobFocus =FocusNode();
  XFile _image;

 Future getImage() async {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
          print('Image Path $_image');
      });
    }
  NewJobModel register = NewJobModel();


  addUser() async {
    if (_fromKey.currentState.validate()) {
      _fromKey.currentState.save();

      // isEmailVerified = true;
     var ksaValidate =KsaNumber();

      String _name = _nameController.text.trim();
      String _email = _emailController.text.trim();
      String _phone = _phoneController.text.trim();
      String desc = _descController.text.trim();

     // String _phoneNumber = _countryDialCode+_phoneController.text.trim();
  String _phoneNumber = "+966"+
                    
                    PhoneNumberUtils.getPhoneNumberFromInputs( _phoneController.text.trim())
                    ;
     

      if (_name.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('name_field_required_txt', context)),
          backgroundColor: Colors.red,
        ));
      }else if (_email.isEmpty) { 

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('email_field_required_txt', context)),
          backgroundColor: Colors.red,
        ));
      }else if (EmailChecker.isNotValid(_email)) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('enter_valid_email_address', context)),
          backgroundColor: Colors.red,
        ));
      } 
      
      else if (_phone.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('phone_field_required_txt', context)),
          backgroundColor: Colors.red,
        ));
      } 
       else if (!ksaValidate.isValidNumber(_phoneNumber)) {
         log('is not valid Number');
try {
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('enter_valid_phone', context)),
          backgroundColor: Colors.red,
        ));
} catch (e) {
    log(e.toString());
}


                     // showCustomSnackBar(getTranslated('enter_valid_email', context), context);
                    }
                      
      else if (job==null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('job_field_required_txt', context)),
          backgroundColor: Colors.red,
        ));
      } 
      
      else if (city==null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('city_field_required_txt', context)),
          backgroundColor: Colors.red,
        ));
      } 
       else if (regoin==null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('area_field_required_txt', context)),
          backgroundColor: Colors.red,
        ));
      } 
       else if (_image==null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('img_field_required_txt', context)),
          backgroundColor: Colors.red,
        ));
      } 
      
      
      else {
             

        register.name = _nameController.text.trim();
        register.email = _emailController.text.trim();
        
        register.phoneNumber = PhoneNumberUtils.getPhoneNumberFromInputs( _phoneController.text.trim());
        register.cityId = city.id;
        register.jobId= job.id;
        register.desc=_descController.text.trim();
          if (_image!= null) {
                   

          register.profilePhoto=FileConverter.getBase64FormateFile(_image.path);
        }else{
           register.profilePhoto=null;
        }

     
        await Provider.of<JobsProvider>(context, listen: false).addJob(context ,
        register
        , route);
      }}
    
  }

route(bool isRoute,  String successMessage, String errorMessage) async { 
 if (isRoute) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(successMessage , style: TextStyle(
      color: Colors.white
    ),),
       backgroundColor: Colors.green));
Navigator.pop(context);
 }else {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage),
       backgroundColor: Colors.red));

 }

}
  @override
  Widget build(BuildContext context) {

     bool isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if(isFirstTime) {
      // if(!isGuestMode) {
      //   Provider.of<OrderProvider>(context, listen: false).initOrderList(context);
      // }

      isFirstTime = false;
    }

    return Scaffold(
       backgroundColor: ColorResources.getIconBg(context),


          body: Consumer<JobsProvider>(
            builder: (context , provider, child) {
              return Column(
        children: [
              CustomAppBar(title: getTranslated('add_job_txt', context), isBackButtonExist: widget.isBacButtonExist),
SizedBox(height: 20,),

Expanded(child: 
Form(
  
  key: _fromKey,
  child: ListView(





children: [

 Row(
                    mainAxisAlignment: MainAxisAlignment.center,
   children: [
     Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 100,
                              backgroundColor: 
                              // Colors.white,
                              
                              
                              Color(0xff476cfb),
                              child: ClipOval(
                                child: new SizedBox(
                                  width: 180.0,
                                  height: 180.0,
                                  child: (_image!=null)?
                                  Image.file(
                                    File(_image.path),
                                    fit: BoxFit.fill,
                                  ):
                                  Image.asset(

                                    'assets/images/placeholder.png',


                                    // "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),

                           Padding(
                        padding: EdgeInsets.only(top: 60.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.camera,
                            size: 30.0,
                          ),
                          onPressed: () {
                            getImage();
                          },
                        ),
                      ),
   ],
 ),




SizedBox(height: 10,),
    Container(
                                     margin:
                    EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT,
                    bottom: Dimensions.MARGIN_SIZE_DEFAULT,
                        right: Dimensions.MARGIN_SIZE_DEFAULT, top: Dimensions.MARGIN_SIZE_SMALL),
                          child: NormalTextField(
                            hintText: getTranslated('name', context),
                            
                            // focusNode: _nameFocus,
                            // nextNode: _emailFocus,
                            capitalization: TextCapitalization.words,
                            controller: _nameController,),
                        ),
  Container(
                                     margin:
                    EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT,
                    bottom: Dimensions.MARGIN_SIZE_DEFAULT,
                        right: Dimensions.MARGIN_SIZE_DEFAULT, top: Dimensions.MARGIN_SIZE_SMALL),
                          child: NormalTextField(
                            hintText: getTranslated('EMAIL', context),
                            // focusNode: _emailFocus,
                            // nextNode: _phoneFocus,
                            capitalization: TextCapitalization.words,
                            controller: _emailController,),
                        ),
Container(
                                     margin:
                    EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT,
                    bottom: Dimensions.MARGIN_SIZE_DEFAULT,
                        right: Dimensions.MARGIN_SIZE_DEFAULT, top: Dimensions.MARGIN_SIZE_SMALL),
                          child: CustomTextField(
                                          hintText: getTranslated('ENTER_MOBILE_NUMBER', context),
                                          focusNode: _phoneFocus,
                                          // nextNode: _passwordFocus,
                                          controller: _phoneController,
                                          
                                          isPhoneNumber: true,
                                          textInputAction: TextInputAction.next,
                                          textInputType: TextInputType.phone,
                                        ),
                        ),
    Container(
                                     margin:
                    EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT,
                    bottom: Dimensions.MARGIN_SIZE_DEFAULT,
                        right: Dimensions.MARGIN_SIZE_DEFAULT, top: Dimensions.MARGIN_SIZE_SMALL),
                          child: CustomDropdown<Region>(
                            
                                child: Text(
                                 getTranslated('choose_region_txt' ,context),
                                  style: titilliumRegular.copyWith(color: Theme.of(context).hintColor),
                                ),
                                leadingIcon: true,
                                
                                onChange: (Region value, int index)async {
                                  setState(() {
                                    
                                    regoin   =value;

                                  });
await Provider.of<JobsProvider>(context, listen: false).getCities( context ,
regoin.id,
    Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode
    ,reload: false
    
    );
                                  //fetch region cities

//                          await     getNeighboursByCity(selectedCity!.id!).then((value) {
// setState(() {
                                    
//                                 neighbours=value;

                                  // });

                                  // });
                                },
                                dropdownButtonStyle: DropdownButtonStyle(
                                    width: double.infinity,

                                  height: 59,
                                  elevation: 0.0,
                                  backgroundColor: Colors.white,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  primaryColor: Theme.of(context).primaryColor,
                                ),
                                dropdownStyle: DropdownStyle(
                                  borderRadius: BorderRadius.circular(6),
                                  elevation: 0.0,
                                  padding: EdgeInsets.all(0),
                                ),
                                items: 

                                provider.regions
                                    // .asMap()
                                    // .entries
                                    .map(
                                      (item) => DropdownItem<Region>(
                                        value: item,
                                        child: Padding(
                                          padding: const EdgeInsets.only(

                                            left: 18,right: 18 ,bottom: 18
                                          ),
                                          child: Text(item.name,
                                              style:
                                                  TextStyle(color: Color(0xFF6F6E6E),
                                                  fontSize: 12,fontWeight: 
                                                  FontWeight.bold
                                                  
                                                  
                                                  )),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              )),
     
     
      Container(
                                     margin:
                    EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT,
                    bottom: Dimensions.MARGIN_SIZE_DEFAULT,
                        right: Dimensions.MARGIN_SIZE_DEFAULT, top: Dimensions.MARGIN_SIZE_SMALL
                        ),
                          child:
                         provider.cities.isEmpty?

                         CustomDropdown<int>(
                                child: Text(
                                 getTranslated('choose_city_txt' ,context),
                                   style: titilliumRegular.copyWith(color: Theme.of(context).hintColor),
                                ),
                                leadingIcon: true,
                                onChange: (int value, int index)async {
                              

//                          await     getNeighboursByCity(selectedCity!.id!).then((value) {
// setState(() {
                                    
//                                 neighbours=value;

                                  // });

                                  // });
                                },
                                dropdownButtonStyle: DropdownButtonStyle(
                                    width: double.infinity,

                                  height: 59,
                                  elevation: 0.0,
                                  backgroundColor: Colors.white,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  primaryColor: Theme.of(context).primaryColor,
                                ),
                                dropdownStyle: DropdownStyle(
                                  borderRadius: BorderRadius.circular(6),
                                  elevation: 0.0,
                                  padding: EdgeInsets.all(5),
                                ),
                                items: 
                                
                                [0]
                                    .map(
                                      (item) => DropdownItem<int>(
                                        value: item,
                                        child: Padding(
                                          padding: const EdgeInsets.only(


                                            left: 18,right: 18 ,bottom: 18                                          ),
                                          child: Text(item.toString(),
                                              style:
                                                  TextStyle(color: Color(0xFF6F6E6E),
                                                  fontSize: 12,fontWeight: 
                                                  FontWeight.bold
                                                  
                                                  
                                                  )),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ):
    
               CustomDropdown<City>(
                                child: Text(
                                 getTranslated('choose_city_txt' ,context),
                                   style: titilliumRegular.copyWith(color: Theme.of(context).hintColor),
                                ),
                                leadingIcon: true,
                                onChange: (City value, int index)async {
                              setState(() {
                                    
                                city=value;

                              });

//                          await     getNeighboursByCity(selectedCity!.id!).then((value) {
// setState(() {
                                    
//                                 neighbours=value;

                                  // });

                                  // });
                                },
                                dropdownButtonStyle: DropdownButtonStyle(
                                    width: double.infinity,

                                  height: 59,
                                  elevation: 0.0,
                                  backgroundColor: Colors.white,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  primaryColor: Theme.of(context).primaryColor,
                                ),
                                dropdownStyle: DropdownStyle(
                                  borderRadius: BorderRadius.circular(6),
                                  elevation: 0.0,
                                  padding: EdgeInsets.all(5),
                                ),
                                items: 
                                
                                provider.isCitiesLoading?
                                []:
                                provider.cities
                                    
                                    .map(
                                      (item) => DropdownItem<City>(
                                        value: item,
                                        child: Padding(
                                          padding: const EdgeInsets.only(


                                            left: 18,right: 18 ,bottom: 18                                          ),
                                          child: Text(item.name,
                                              style:
                                                  TextStyle(color: Color(0xFF6F6E6E),
                                                  fontSize: 12,fontWeight: 
                                                  FontWeight.bold
                                                  
                                                  
                                                  )),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
    
                                 
         
                        ),
    


     Container(
                                     margin:
                    EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT,
                    bottom: Dimensions.MARGIN_SIZE_DEFAULT,
                        right: Dimensions.MARGIN_SIZE_DEFAULT, top: Dimensions.MARGIN_SIZE_SMALL
                        ),
                          child:
                         provider.jobs.length<1?
                         
CustomDropdown<int>(
                                child: Text(
                                 getTranslated('choose_job_txt' ,context),
                                   style: titilliumRegular.copyWith(color: Theme.of(context).hintColor),
                                ),
                                leadingIcon: true,
                                onChange: (int value, int index)async {
                              // setState(() {
                                    
                              //   job=value;

                              // });

//                          await     getNeighboursByCity(selectedCity!.id!).then((value) {
// setState(() {
                                    
//                                 neighbours=value;

                                  // });

                                  // });
                                },
                                dropdownButtonStyle: DropdownButtonStyle(
                                    width: double.infinity,

                                  height: 59,
                                  elevation: 0.0,
                                  backgroundColor: Colors.white,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  primaryColor: Theme.of(context).primaryColor,
                                ),
                                dropdownStyle: DropdownStyle(
                                  borderRadius: BorderRadius.circular(6),
                                  elevation: 0.0,
                                  padding: EdgeInsets.all(5),
                                ),
                                items: [0]
                                    // .asMap()
                                    // .entries
                                    .map(
                                      (item) => DropdownItem<int>(
                                        value: item,
                                        child: Padding(
                                          padding: const EdgeInsets.only(


                                            left: 18,right: 18 ,bottom: 18                                          ),
                                          child: Text(item.toString(),
                                              style:
                                                  TextStyle(color: Color(0xFF6F6E6E),
                                                  fontSize: 12,fontWeight: 
                                                  FontWeight.bold
                                                  
                                                  
                                                  )),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ):
    

CustomDropdown<Job>(
                                child: Text(
                                 getTranslated('choose_job_txt' ,context),
                                   style: titilliumRegular.copyWith(color: Theme.of(context).hintColor),
                                ),
                                leadingIcon: true,
                                onChange: (Job value, int index)async {
                              setState(() {
                                    
                                job=value;

                              });

//                          await     getNeighboursByCity(selectedCity!.id!).then((value) {
// setState(() {
                                    
//                                 neighbours=value;

                                  // });

                                  // });
                                },
                                dropdownButtonStyle: DropdownButtonStyle(
                                    width: double.infinity,

                                  height: 59,
                                  elevation: 0.0,
                                  backgroundColor: Colors.white,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  primaryColor: Theme.of(context).primaryColor,
                                ),
                                dropdownStyle: DropdownStyle(
                                  borderRadius: BorderRadius.circular(6),
                                  elevation: 0.0,
                                  padding: EdgeInsets.all(5),
                                ),
                                items: provider.jobs
                                    // .asMap()
                                    // .entries
                                    .map(
                                      (item) => DropdownItem<Job>(
                                        value: item,
                                        child: Padding(
                                          padding: const EdgeInsets.only(


                                            left: 18,right: 18 ,bottom: 18                                          ),
                                          child: Text(item.name,
                                              style:
                                                  TextStyle(color: Color(0xFF6F6E6E),
                                                  fontSize: 12,fontWeight: 
                                                  FontWeight.bold
                                                  
                                                  
                                                  )),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
    
                                 
         
                        ),





                        Container(
                                margin:
                    EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT,
                    bottom: Dimensions.MARGIN_SIZE_DEFAULT,
                        right: Dimensions.MARGIN_SIZE_DEFAULT, top: Dimensions.MARGIN_SIZE_SMALL
                        ),
                          child: TextArea(
                                          hintText: getTranslated('desc_txt', context),
                                          focusNode: _descFocus,
                                          // nextNode: _passwordFocus,
                                          controller: _descController,
                                          
                                          
                                          isPhoneNumber: false,
                                          textInputAction: TextInputAction.newline,
                                          textInputType: TextInputType.multiline,
                                          // isBorder: true,
                                        ),
                        ),





                                       InkWell(
                                         onTap:     
                                         
                                         
                                           provider.isAddJobLoading?
null:
()


async{


await
  addUser();
},
                                         child: Container(
                                             margin:
                                                           EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT,
                                                           bottom: Dimensions.MARGIN_SIZE_DEFAULT,
                                                               right: Dimensions.MARGIN_SIZE_DEFAULT, top: Dimensions.MARGIN_SIZE_SMALL
                                                               ),
                                             width: double.infinity,
                                             height: 59,
                                             //  width: double.infinity,
                                       
                                                           //                  margin:
                                                           // EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_DEFAULT),
                                             decoration: BoxDecoration(
                                               color: Theme.of(context).primaryColor,
                                               borderRadius: BorderRadius.circular(6),
                                               boxShadow: [
                                                     BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)) // changes position of shadow
                                               ],
                                       
                                       
                                             ),
                                             
                                             child: 
                                             
                                             
                                             Center(
                                               
                                               child: provider.isAddJobLoading?
                                             CircularProgressIndicator(color: Colors.white,):Text(
                                                     getTranslated('add_job_btn_txt', context) ,
                                       
                                                     style: TextStyle(
                                                       fontWeight: FontWeight.bold,
                                                       
                                                       fontSize: 20
                                                     ),
                                               ),
                                             ),
                                             
                                             
                                             ),
                                       )
],










  
))

)

        ]);
            }
          )
      
    );
  }
}