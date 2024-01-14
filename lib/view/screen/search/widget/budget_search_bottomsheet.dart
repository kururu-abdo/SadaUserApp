import 'package:eamar_user_app/data/model/response/category.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/search_provider.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/sizes.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../basewidget/textfield/dropdown_field.dart';

class SeachByBudgetBottomshet extends StatefulWidget {
  const SeachByBudgetBottomshet({super.key});

  @override
  State<SeachByBudgetBottomshet> createState() => _SeachByBudgetBottomshetState();
}

class _SeachByBudgetBottomshetState extends State<SeachByBudgetBottomshet> {
     final TextEditingController _firstPriceController = TextEditingController();
    final GlobalKey<FormState> _vormKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return     Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      width: MediaQuery.of(context).size.width,
      height:  MediaQuery.of(context).size.height*.60,
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child:
    Consumer<SearchProvider>(
              builder: (context, searchProvider, child)
=>Column(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [ 


    Align(
      alignment: AlignmentDirectional.centerEnd,
      child: GestureDetector(
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
      ),
    )
  ,
   Center(
     child: SizedBox(
      width: MediaQuery.of(context).size.width*.60,
       child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    
                                    getLang(context)=="ar"?
                                    "قم باختيار الفئة و ادخل السعر ثم استعرض النتائج":
                                  "Please select category and enter price then show results"
                                  
                                  
                                  
                                  , 
                                  
                                  textAlign: TextAlign.center,
                                  
                                  
                                  style: robotoBold
                                  
                                  .copyWith(
                                    fontSize:                                                     isTablet(context)? 20:
                                                                14 , 
                                                                
                                                   fontWeight: FontWeight.w500,             
                                                                
                                                                 color: Colors.black54
                                  )
                                  )),
     ),
   ),





  // Spacer(),
  
                              Expanded(
                               
                                child: Form(
                                  key: _vormKey,
                                  child: ListView(children: [
                                
                                
                                
                                     Container(
                                         margin:
                                                    EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT,
                                                    bottom: Dimensions.MARGIN_SIZE_DEFAULT,
                                                        right: Dimensions.MARGIN_SIZE_DEFAULT, top: Dimensions.MARGIN_SIZE_SMALL),
                                                          child: CustomDropdown<Category>(
                                                            
                                    child: Text(
                                    getTranslated('category', context)!,
                                      style: titilliumRegular.copyWith(
                                        fontSize:                                                     isTablet(context)? 20:
  null,
  fontWeight: FontWeight.bold,
                                        
                                        color: Theme.of(context).
                                      hintColor),
                                    ),
                                    leadingIcon: true,
                                    
                                    onChange: (Category? value, int index)async {
                                      
                                searchProvider.setCategory( value!);
                                    
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
                                
                                    searchProvider.categoryList
                                        // .asMap()
                                        // .entries
                                        .map(
                                          (item) => DropdownItem<Category>(
                                            value: item,
                                            
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                
                                                left: 18,right: 18 ,bottom: 18
                                              ),
                                              child: Text(item.name!,
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
                                
                                
                                       decoration: BoxDecoration(
                                           boxShadow: [
                                          BoxShadow(color: Colors.grey.withOpacity(0.2), 
                                          spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)) // changes position of shadow
                                        ],
                                        ),
                                        padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
                                         margin:
                                                    EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT,
                                                    bottom: Dimensions.MARGIN_SIZE_DEFAULT,
                                                        right: Dimensions.MARGIN_SIZE_DEFAULT, top: Dimensions.MARGIN_SIZE_SMALL),
                                        child: TextFormField(


onTapOutside: (str){
  FocusScope.of(context).unfocus();
},



                                                      keyboardType: TextInputType.number,
                                                      textInputAction: TextInputAction.next,
                                                      // onSubmitted: (_) => FocusScope.of(context).requestFocus(_lastFocus),
                                                      // textAlign: TextAlign.center,
                                                      maxLines: 1,
                                                    
                                                      // focusNode: _firstFocus,
                                                      controller: _firstPriceController,
                                                      style: 
                                                      
                                                      
                                                      titilliumBold.copyWith(fontSize:
                                                      
                                                      isTablet(context)? 20:
                                                      
                                                      
                                                       Dimensions.FONT_SIZE_SMALL),
                                                      decoration: new InputDecoration(
                                                        hintText: 
                                                         getTranslated('budget_txt', context),
                                                      
                                      fillColor: Colors.white,
                                      filled: true, 
                                                        border: new OutlineInputBorder(
                                                             borderSide: BorderSide.none
                                                            // borderSide: new BorderSide(color: Theme.of(context).primaryColor)
                                                            ),
                                                            enabledBorder: 
                                                            new OutlineInputBorder(
                                  borderSide: BorderSide.none
                                                            )
                                                            ),
  
  
                                                            validator: (str){
  
  if (str!.isEmpty) {
    return getTranslated('amount_filed_required', context);
  }else {
    return null;
  }
  
  
  
                                                            },
                                                        ),
                                      ),
                                           InkWell(
                                             onTap:     
                                             
                                             
                                 
                                ()
                                
                                
                                async{
                                
                                if (searchProvider.category ==null) {
                                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('category_field_required', context)!),
  
         backgroundColor: Colors.red));
                                }else{
                                   if (_vormKey.currentState!.validate()) {
      Navigator.pop(context);
                                     FirebaseAnalytics.instance.logEvent(
      name: "search_category",
      parameters: {
          "category_name":searchProvider.category!.name,
          "date": DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
      },
  );
  
   FirebaseAnalytics.instance.logEvent(
      name: "search_amount",
      parameters: {
          "amount":num.parse(_firstPriceController.text),
          "date": DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
      },
  );
                                  await 
                                  searchProvider.
                                  filterByBudgetAndCategory(
                                    searchProvider.category!, num.parse(_firstPriceController.text), context);
                                }
                                }
                           
                                
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
                                                   
                                                   child: Text(
                                                      getTranslated('show_result_txt', context)! ,
                                           
                                                         style: TextStyle(
                                                           fontWeight: FontWeight.w500,
                                                           
                                                           fontSize: 20 ,
  
                                                           color: Theme.of(context).cardColor
                                                         ),
                                                   ),
                                                 ),
                                                 
                                                 
                                                 ),
                                           )
                                
                                  ]),
                                ),
                              )
                            
  
  ]),
)

    );
  }
}