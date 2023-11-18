
import 'package:eamar_user_app/data/model/response/category.dart';
import 'package:eamar_user_app/view/basewidget/textfield/dropdown_field.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/search_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/view/basewidget/no_internet_screen.dart';
import 'package:eamar_user_app/view/basewidget/product_shimmer.dart';
import 'package:eamar_user_app/view/basewidget/search_widget.dart';
import 'package:eamar_user_app/view/screen/search/widget/search_product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
    final TextEditingController _firstPriceController = TextEditingController();
    final GlobalKey<FormState> _vormKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Provider.of<SearchProvider>(context, listen: false).cleanSearchProduct();
    Provider.of<SearchProvider>(context, listen: false).initHistoryList();
Provider.of<SearchProvider>(context, listen: false).getCategoryList(false ,context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorResources.getIconBg(context),
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Theme.of(context).canvasColor,
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1),)],
              ),
              child: Row(children: [
                Padding(padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                  child: InkWell(onTap: ()=>Navigator.pop(context),
                      child: Icon(Icons.arrow_back_ios,size: 30,)),),


                  Expanded(child: Container(
                    child: SearchWidget(
                      hintText: getTranslated('SEARCH_HINT', context),
                      onSubmit: (String text) {

                         FirebaseAnalytics.instance.logEvent(
    name: "search_txt",
    parameters: {
        "search_word":text,
        "date": DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
    },
);


                        Provider.of<SearchProvider>(context, listen: false).searchProduct(text, context);
                        Provider.of<SearchProvider>(context, listen: false).saveSearchAddress(text);
                        },
                      onClearPressed: () => Provider.of<SearchProvider>(context, listen: false).cleanSearchProduct(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

            Consumer<SearchProvider>(
              builder: (context, searchProvider, child) {
                return !searchProvider.isClear ? searchProvider.searchProductList != null ?
                searchProvider.searchProductList!.length > 0 ?
                Expanded(child: SearchProductWidget(products: searchProvider.searchProductList, isViewScrollable: true)) :
                Expanded(child: NoInternetOrDataScreen(isNoInternet: false)) :
                Expanded(child: ProductShimmer(isHomePage: false,
                    isEnabled: Provider.of<SearchProvider>(context).searchProductList == null)) :
//old code

//                 Expanded(flex: 4,
//                   child: Container(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
//                     child: Stack(
                      
//                       clipBehavior: Clip.none,
//                       children: [
//                         Consumer<SearchProvider>(
//                           builder: (context, searchProvider, child) => StaggeredGridView.countBuilder(
//                             crossAxisCount: 2,
//                             physics: NeverScrollableScrollPhysics(),
//                             itemCount: searchProvider.historyList.length,
//                             itemBuilder: (context, index) => Container(
//                                 alignment: Alignment.center,
//                                 child: InkWell(
//                                   onTap: () => 
                                  
//                                   Provider.of<SearchProvider>(context, listen: false).
//                                   searchProduct(searchProvider.historyList[index], context),
//                                   borderRadius: BorderRadius.circular(5),
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
//                                         color: ColorResources.getGrey(context)),
//                                     width: double.infinity,
//                                     child: Center(
//                                       child: Text(Provider.of<SearchProvider>(context, listen: false).historyList[index] ?? "",
//                                         style: titilliumItalic.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),
//                                       ),
//                                     ),
//                                   ),
//                                 )),
//                             staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
//                             mainAxisSpacing: 4.0,
//                             crossAxisSpacing: 4.0,
//                           ),
//                         ),
//                         Positioned(top: -50, left: 0, right: 0,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(getTranslated('SEARCH_HISTORY', context), style: robotoBold),


//                                 InkWell(borderRadius: BorderRadius.circular(10),
//                                     onTap: () => Provider.of<SearchProvider>(context, listen: false).clearSearchAddress(),
//                                     child: Container(padding: EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_DEFAULT,
//                                         vertical:Dimensions.PADDING_SIZE_LARGE ),
//                                         child: Text(getTranslated('REMOVE', context),
//                                           style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
//                                               color: Theme.of(context).primaryColor),)))
//                               ],
//                             ),
//                           ),
//                         ),


//  Positioned(top: 200, left: 0, right: 0,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text('Search By Price', style: robotoBold),


//                                 InkWell(borderRadius: BorderRadius.circular(10),
//                                     onTap: () => Provider.of<SearchProvider>(context, listen: false).clearSearchAddress(),
//                                     child: Container(padding: EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_DEFAULT,
//                                         vertical:Dimensions.PADDING_SIZE_LARGE ),
//                                         child: Text(getTranslated('REMOVE', context),
//                                           style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
//                                               color: Theme.of(context).primaryColor),)))
//                               ],
//                             ),
//                           ),
//                         ),





//                       ],
//                     ),
//                   ),
//                 );
           
           
           




                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                    child: 
                        Consumer<SearchProvider>(
                          builder: (context, searchProvider, child) => ListView(
                            children: [   Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(getTranslated('SEARCH_HISTORY', context)!, style: robotoBold),


                                  InkWell(borderRadius: BorderRadius.circular(10),
                                      onTap: () => Provider.of<SearchProvider>(context, listen: false).clearSearchAddress(),
                                      child: Container(padding: EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_DEFAULT,
                                          vertical:Dimensions.PADDING_SIZE_LARGE ),
                                          child: Text(getTranslated('REMOVE', context)!,
                                            style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
                                                color: Theme.of(context).primaryColor),)))
                                ],
                              ),
                            ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height/3,
                                child: StaggeredGridView.countBuilder(
                                  crossAxisCount: 2,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: searchProvider.historyList.length,
                                  itemBuilder: (context, index) => Container(
                                      alignment: Alignment.center,
                                      child: InkWell(
                                        onTap: () => 
                                        
                                        Provider.of<SearchProvider>(context, listen: false).
                                        searchProduct(searchProvider.historyList[index], context),
                                        borderRadius: BorderRadius.circular(5),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                                              color: ColorResources.getGrey(context)),
                                          width: double.infinity,
                                          child: Center(
                                            child: Text(Provider.of<SearchProvider>(context, listen: false).historyList[index] ,
                                              style: titilliumItalic.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),
                                            ),
                                          ),
                                        ),
                                      )),
                                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                                  mainAxisSpacing: 4.0,
                                  crossAxisSpacing: 4.0,
                                ),
                              ),
                           
                           











                            Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(getTranslated('search_by_budget', context)!, style: robotoBold),


                                // InkWell(borderRadius: BorderRadius.circular(10),
                                //     onTap: () => Provider.of<SearchProvider>(context, listen: false).clearSearchAddress(),
                                //     child: Container(padding: EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_DEFAULT,
                                //         vertical:Dimensions.PADDING_SIZE_LARGE ),
                                //         child: Text('X',
                                //           style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
                                //               color: Theme.of(context).primaryColor),))
                                //               )
                              ],
                            )),


                            SizedBox(
                              height: MediaQuery.of(context).size.height/3.5,
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
                                    style: titilliumRegular.copyWith(color: Theme.of(context).hintColor),
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
                                       margin:
                                                  EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT,
                                                  bottom: Dimensions.MARGIN_SIZE_DEFAULT,
                                                      right: Dimensions.MARGIN_SIZE_DEFAULT, top: Dimensions.MARGIN_SIZE_SMALL),
                                      child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    textInputAction: TextInputAction.next,
                                                    // onSubmitted: (_) => FocusScope.of(context).requestFocus(_lastFocus),
                                                    // textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                  
                                                    // focusNode: _firstFocus,
                                                    controller: _firstPriceController,
                                                    style: titilliumBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                                                    decoration: new InputDecoration(
                                                      hintText:  getTranslated('budget_txt', context),
                                                    
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
                            ]
                          ),
                        ),
                     




                      
                    
                  ),
                );
           
           
           
           
              },
            ),
          ],
        ),
      ),
    );
  }
}
