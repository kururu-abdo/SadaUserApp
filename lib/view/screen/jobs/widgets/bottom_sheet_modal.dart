import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:eamar_user_app/data/model/response/city.dart';
import 'package:eamar_user_app/data/model/response/job_model.dart';
import 'package:eamar_user_app/data/model/response/region.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/jobs_provider.dart';
import 'package:eamar_user_app/provider/localization_provider.dart';
import 'package:eamar_user_app/view/basewidget/textfield/dropdown_field.dart';
import 'package:provider/provider.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({ Key? key }) : super(key: key);

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {

  City?  city;
  late Region region;
  Job? job;

var _fromKey= GlobalKey<FormState>();
_filter()async{

  try {
   await  Provider.of<JobsProvider>(context, listen: false).searchAJob(context ,
      city!=null?  city!.id:null
        ,job!=null? job!.id:null ,
        
         Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode
        );
        Navigator.of(context).pop();
  } catch (e) {
     Navigator.of(context).pop();
  }
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

@override
void initState() { 
  super.initState();
  _loadData(context, false);
}


  
  @override
  Widget build(BuildContext context) {
    return  Consumer<JobsProvider>(
      builder: (context , provider, child) {
        return new Container(
                    height: 400.0,
                    color: Colors.transparent, //could change this to Color(0xFF737373), 
                               //so you don't have to change MaterialApp canvasColor
                    child: new Container(
                      padding: EdgeInsets.all(20),
                        decoration: new BoxDecoration(
                            color: Theme.of(context).highlightColor,
                            
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(10.0),
                                topRight: const Radius.circular(10.0))),
                        child: new Form(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [



provider.jobs.length<1?
CustomDropdown<int>(
                                child: Text(
                                 getTranslated('choose_job_txt' ,context)!,
                                  style: TextStyle(color: Colors.grey),
                                ),
                                // leadingIcon: true,
                                icon:    Icon(


                    Icons.keyboard_arrow_down
                    
                    
                    ,
                  
                  color: Theme.of(context).colorScheme.onPrimary,   ///TODO: change dopdown icon color
                  ) ,
                                onChange: (int value, int index)async {
                             

//                          await     getNeighboursByCity(selectedCity!.id!).then((value) {
// setState(() {
                                    
//                                 neighbours=value;

                                  // });

                                  // });
                                },
                                dropdownButtonStyle: DropdownButtonStyle(
                                   width: double.infinity,
                                  height: 59,  padding: EdgeInsets.all(5),
                                  elevation: 0.0,
                                  backgroundColor:  Theme.of(context).highlightColor ,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  primaryColor: Theme.of(context).primaryColor,
                                  
                                ),
                                dropdownStyle: DropdownStyle(
                                  borderRadius: BorderRadius.circular(6),
                                  elevation: 0.0,
                                  padding: EdgeInsets.all(5),
                                
                                ),
                                items: [0]
                                    .map(
                                      (item) => DropdownItem<int>(
                                        value: item,
                                        child: Padding(
                                          padding: const EdgeInsets.only(

                                            left: 18,right: 18 , bottom: 18
                                          ),
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
                              )
        
:
CustomDropdown<Job>(
                                child: Text(
                                 getTranslated('choose_job_txt' ,context)!,
                                  style: TextStyle(color: Colors.grey),
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
                                    .map(
                                      (item) => DropdownItem<Job>(
                                        value: item,
                                        child: Padding(
                                          padding: const EdgeInsets.only(

                                            left: 18,right: 18 , bottom: 18
                                          ),
                                          child: Text(item.name.toString(),
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
        
                   SizedBox(height: 15,),
                   
CustomDropdown<Region>(
                                child: Text(
                                 getTranslated('choose_region_txt' ,context)!,
                                  style: TextStyle(color: Colors.grey),
                                ),
                                leadingIcon: true,
                                onChange: (Region? value, int? index)async {
                              setState(() {
                                    
                                region=value!;

                              });
                              log('NO EXCEPTION');
                        
await Provider.of<JobsProvider>(context, listen: false).getCities( context ,
region.id,
    Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode
    ,reload: false
    
    );
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
                                items: provider.regions
                                    .map(
                                      (item) => DropdownItem<Region>(
                                        value: item,
                                        child: Padding(
                                          padding: const EdgeInsets.only(

                                            left: 18,right: 18 , bottom: 18
                                          ),
                                          child: Text(item.name.toString(),
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
        
                                 
                                 
                                 
                                 
                                  SizedBox(height: 15,),
            
               provider.cities.isEmpty?

          CustomDropdown<int>(
                                child: Text(
                                 getTranslated('choose_city_txt' ,context)!,
                                  style: TextStyle(color: Colors.grey),
                                ),
                                leadingIcon: true,
                                onChange: (int value, int index)async {
                              // setState(() {
                                    
                              //   city=value;

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
                                items: 
                                [0]
                                    .map(
                                      (item) => DropdownItem<int>(
                                        value: item,
                                        child: Padding(
                                          padding: const EdgeInsets.only(

                                            left: 18,right: 18 , bottom: 18
                                          ),
                                          child: Text(item.toString(),
                                              style:
                                                  TextStyle(color: Color(0xFF6F6E6E),
                                                  fontSize: 12,
                                                  fontWeight: 
                                                  FontWeight.bold
                                                  
                                                  
                                                  )),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ):
        
              
CustomDropdown<City>(
                                child: Text(
                                 getTranslated('choose_city_txt' ,context)!,
                                  style: TextStyle(color: Colors.grey),
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

                                            left: 18,right: 18 , bottom: 18
                                          ),
                                          child: Text(item.name!,
                                              style:
                                                  TextStyle(color: Color(0xFF6F6E6E),
                                                  fontSize: 12,
                                                  fontWeight: 
                                                  FontWeight.bold
                                                  
                                                  
                                                  )),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
        
                               
                           Spacer(),



                            InkWell(
                              onTap:  provider.isJobsLoading?null:()async{
                                await _filter();
                              },
                              child: Container(
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
                                      
                                      child: Center(
                                        child: 
                                        provider.isJobsLoading?
                            
                                        CircularProgressIndicator(color: Colors.white,):
                                        
                                        Text(
                                          getTranslated('search_txt', context)! ,
                            
                                          style: TextStyle(
                                            color: Theme.of(context).cardColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20
                                          ),
                                        ),
                                      ),
                                      
                                      
                                      ),
                            )
                           
                            ],
                          ),
                        )),
                  );
      }
    );
  }
}