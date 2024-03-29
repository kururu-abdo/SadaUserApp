
import 'dart:developer';

import 'package:eamar_user_app/data/model/response/category.dart';
import 'package:eamar_user_app/utill/sizes.dart';
import 'package:eamar_user_app/view/basewidget/textfield/dropdown_field.dart';
import 'package:eamar_user_app/view/screen/search/widget/budget_search_bottomsheet.dart';
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
  
WidgetsBinding.instance.addPostFrameCallback((_) {

  Provider.of<SearchProvider>(context, listen: false).cleanSearchProduct();
    Provider.of<SearchProvider>(context, listen: false).initHistoryList();
Provider.of<SearchProvider>(context, listen: false).getCategoryList(false ,context);


});
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
                Padding(padding: EdgeInsets.only(
                  right: Dimensions.PADDING_SIZE_DEFAULT,
                  left: Dimensions.PADDING_SIZE_DEFAULT),
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
                      onClearPressed: () => 
                      Provider.of<SearchProvider>(context, listen: false).
                      cleanSearchProduct(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

            Consumer<SearchProvider>(
              builder: (context, searchProvider, child) {
                return !searchProvider.isClear ? 
                searchProvider.searchProductList != null ?
                searchProvider.searchProductList!.length > 0 ?
                Expanded(child: SearchProductWidget(products: 
                searchProvider.searchProductList, isViewScrollable: true)) 
                
                :
                Expanded(child: NoInternetOrDataScreen(isNoInternet: false))
                 :
                Expanded(child: ProductShimmer(isHomePage: false,
                    isEnabled: 
                    Provider.of<SearchProvider>(context).searchProductList == null)
                    )
                    
                    
                     :
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
                          builder: (context, searchProvider, child) => 
                          
                          ListView(
                            children: [ 
                              


Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    TextButton(onPressed: (){


      showModalBottomSheet(context: context,
                isScrollControlled: true, 
                
                backgroundColor: Colors.transparent,
  constraints: BoxConstraints(
     maxWidth: MediaQuery.of(context).size.width,              
  ),
                builder: (c) => SeachByBudgetBottomshet()
                );
    }, child: Text(
      
      getLang(context)=="ar"?
      "البحث بالميزانية":
      'Search by budget',
    style: robotoBold.copyWith(

                                               fontSize:     isTablet(context)? 20:null

    )
                                  
    
    )),

Container(padding: EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_DEFAULT,
                                          vertical:Dimensions.PADDING_SIZE_LARGE ),

)
  ],
) ,




                                Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: 
                              
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(getTranslated('SEARCH_HISTORY', context)!, 
                                  
                                  style: robotoBold.copyWith(

                                               fontSize:     isTablet(context)? 20:null


                                  )),


                                  InkWell(borderRadius: BorderRadius.circular(10),
                                      onTap: () => Provider.of<SearchProvider>(context, listen: false).clearSearchAddress(),
                                      child: Container(padding: EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_DEFAULT,
                                          vertical:Dimensions.PADDING_SIZE_LARGE ),
                                          child: Text(getTranslated('REMOVE', context)!,
                                            style: titilliumRegular.copyWith(fontSize:
                                            
                                             isTablet(context)? 
15:
                                             Dimensions.FONT_SIZE_SMALL,
                                                color: Theme.of(context).primaryColor),)))
                                ],
                              ),
                            ),
                            
                            
                            
                              SizedBox(
                                height: 
                                searchProvider.historyList.length*50 > 

                                MediaQuery.of(context).size.height/4
                                ?
                                MediaQuery.of(context).size.height/4
                                :
                                 searchProvider.historyList.length*50 

                                // MediaQuery.of(context).size.height/4
                                ,
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
                              child: 
                              
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    
                                    getLang(context)=="ar"?
                                    "منتجات بحث عنها مؤخرا":"Latest search products"
                                    , 
                                  
                                  style: robotoBold.copyWith(

                                               fontSize:     isTablet(context)? 20:null


                                  )),


                                  InkWell(borderRadius: BorderRadius.circular(10),
                                      onTap: () => Provider.of<SearchProvider>(context, listen: false).clearSearchAddress(),
                                      child: Container(padding: EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_DEFAULT,
                                          vertical:Dimensions.PADDING_SIZE_LARGE ),
                                          child: Text(getTranslated('REMOVE', context)!,
                                            style: titilliumRegular.copyWith(fontSize:
                                            
                                             isTablet(context)? 
15:
                                             Dimensions.FONT_SIZE_SMALL,
                                                color: Theme.of(context).primaryColor),)))
                                ],
                              ),
                            ),
                            
                            GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              children: [


                              ],
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
