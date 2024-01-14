import 'dart:async';
import 'dart:developer';

import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/search_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/utill/sizes.dart';
import 'package:eamar_user_app/view/basewidget/no_internet_screen.dart';
import 'package:eamar_user_app/view/basewidget/product_shimmer.dart';
import 'package:eamar_user_app/view/screen/search/widget/budget_search_bottomsheet.dart';
import 'package:eamar_user_app/view/screen/search/widget/greidnet_text.dart';
import 'package:eamar_user_app/view/screen/search/widget/search_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

class NewSearchPage extends StatefulWidget {
  const NewSearchPage({super.key});

  @override
  State<NewSearchPage> createState() => _NewSearchPageState();
}

class _NewSearchPageState extends State<NewSearchPage> {
  // final TextEditingController searchController =TextEditingController();
  FocusNode searchFocus = FocusNode();
  bool? showSuggsts=false;
@override
void initState() {
  super.initState();
  initData();

  focusNode.addListener(() {

showSuggsts = focusNode.hasFocus;
  });

  // searchController.addListener(_onSearchChanged);
}
LayerLink _layerLink = LayerLink();
OverlayEntry _createOverlayEntry() {
  RenderBox renderBox = context.findRenderObject() as RenderBox;
  var size = renderBox.size;
  return OverlayEntry(
      builder: (context) => Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: this._layerLink,
              showWhenUnlinked: false,
              offset: Offset(0.0, size.height + 5.0),
              child: Material(
                elevation: 4.0,
               
               
                child:
                Container(height: 100, color: Colors.red,)
                //  StreamBuilder<Object>(
                //     stream: bloc.suggestionsController.stream,
                //     builder: (context, suggestionData) {
                //       if (suggestionData.hasData &&
                //           widget.controller.text.isNotEmpty) {
                //         suggestionShowList = suggestionData.data;
                //         return ConstrainedBox(
                //           constraints: new BoxConstraints(
                //             maxHeight: 200,
                //           ),
                //           child: ListView.builder(
                //               controller: scrollController,
                //               padding: EdgeInsets.zero,
                //               shrinkWrap: true,
                //               itemCount: suggestionShowList.length,
                //               itemBuilder: (context, index) {
                //                 return ListTile(
                //                   title: Text(
                //                     suggestionShowList[index],
                //                     style: widget.suggestionStyle,
                //                     textAlign: widget.suggestionTextAlign,
                //                   ),
                //                   onTap: () {
                //                     isSearching = false;
                //                     widget.controller.text =
                //                         suggestionShowList[index];
                //                     bloc.suggestionsController.sink.add([]);
                //                     widget.onTappedSuggestion(
                //                         widget.controller.text);
                //                   },
                //                 );
                //               }),
                //         );
                //       } else {
                //         return Container();
                //       }
                //     }),
           
           
              ),
            ),
          ));
}
FocusNode focusNode =FocusNode();
initData(){
  WidgetsBinding.instance.addPostFrameCallback((_) {

  Provider.of<SearchProvider>(context, listen: false).cleanSearchProduct();
    Provider.of<SearchProvider>(context, listen: false).initHistoryList();
Provider.of<SearchProvider>(context, listen: false).getCategoryList(false ,context);


});
}
var
completeSuggestionList =[];
bool isSearching =false;
// widget.controller.addListener(_onSearchChanged); // attaching 

_onSearchChanged() {
    // if (_debounce?.isActive ?? false) _debounce.cancel();
    // _debounce =
    //     Timer(Duration(milliseconds: 250), () {
    //   if (isSearching == true) {
    //     // _getSuggestions(widget.controller.text);
    //   }
    // });
  }

  _getSuggestions(String data) async {
    if (data.length > 0) {
      completeSuggestionList.clear();
      // List<String> list = await widget.getSuggestionsMethod(data);
      // bloc.suggestionsController.sink.add(list);
    }
  }

    final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
        final TextEditingController searchController =
     TextEditingController(text: Provider.of<SearchProvider>(context).searchText);
    final Shader linearGradient = LinearGradient(
  colors: <Color>[Colors.black, Colors.grey.withOpacity(.30)],
).createShader(Rect.fromCircle(
    center: Offset(14, -200), 
    radius: 14 / 3,
  ));

    return  Scaffold(
appBar: AppBar(
  elevation: 0,
  leading: IconButton(onPressed: (){
    Navigator.pop(context);
  }, icon: Icon(Icons.arrow_back_ios  , size: 30,)),
title: Text(

  getLang(context)=="ar"?
  "البحث":
  'Search' ,  

  style: TextStyle(
    color: Theme.of(context).primaryColor
  ),
),

actions: [ 

  // Container(
  //                 padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
  //                     horizontal: Dimensions.PADDING_SIZE_SMALL),
  //                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),),
  //                 child: Image.asset(Images.dropdown, scale: 3),


  //               ),
],
),

body: SizedBox.expand(
  child: Consumer<SearchProvider>(
                          builder: (context, searchProvider, child) =>  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ 
    SizedBox(height: 10,) , 


    Center(child: Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: CompositedTransformTarget(
      link: _layerLink,
      child:
      



        TypeAheadField(
        hideOnEmpty: true,
        hideOnSelect: true,
          controller: searchController,
          focusNode: searchFocus,
          onSelected: (value){
            // Navigator.pop(context);
searchController.text=value;
log("SEARCH "+ value);
                        Provider.of<SearchProvider>(context, listen: false).searchProduct(value, context);
                        Provider.of<SearchProvider>(context, listen: false).saveSearchAddress(value);
                       
          },
           builder: (context, controller, focusNode) {
    return 
    
    
      TextFormField(
        focusNode: focusNode,
        
        onTapOutside: (event){
          // focusNode.unfocus();
                                FocusScope.of(context).unfocus();
      
        },
        onFieldSubmitted: (str){
          if (str.isNotEmpty) {
                searchProvider.saveSearchAddress(str);
          }
  
                        Provider.of<SearchProvider>(context, listen: false).searchProduct(str, context);
                        Provider.of<SearchProvider>(context, listen: false).saveSearchAddress(str);
                       searchController.text = str;
        },
      controller: controller,
        style: TextStyle(
          // color: Colors.grey[400] , 
        fontSize: 15 , fontWeight: FontWeight.w500
        ),
        maxLines: 1,
      decoration: InputDecoration( 
      
      prefixIcon: Icon(Icons.search ,size: 30,),
      suffixIcon: IconButton(onPressed: (){
      controller.clear();
 Provider.of<SearchProvider>(context, listen: false).
                      cleanSearchProduct();

      }, icon: Icon(Icons.close)),
        fillColor: Colors.grey.withOpacity(.15), 
        filled: true , 
      contentPadding: EdgeInsets.symmetric(vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25) , 
          borderSide: BorderSide.none
        ), 
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25) , 
          borderSide: BorderSide.none
        ), 
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25) , 
          borderSide: BorderSide.none
        ), 
      
      
      
      ),
      
      );
    
    
    
    
    
    TextField(
      controller: _controller,
            textInputAction: TextInputAction.search,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.streetAddress,

      decoration: InputDecoration(
              hintText: getTranslated('search_location', context),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(style: BorderStyle.none, width: 0),
              ),
              hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: Dimensions.FONT_SIZE_DEFAULT, color: Theme.of(context).disabledColor,
              ),
              filled: true, fillColor: Theme.of(context).cardColor,
            ),
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color, fontSize: Dimensions.FONT_SIZE_LARGE,
            ),
    );
  },
          // textFieldConfiguration: TextFieldConfiguration(
          //   controller: _controller,
          //   textInputAction: TextInputAction.search,
          //   autofocus: true,
          //   textCapitalization: TextCapitalization.words,
          //   keyboardType: TextInputType.streetAddress,
          //   decoration: InputDecoration(
          //     hintText: getTranslated('search_location', context),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(10),
          //       borderSide: BorderSide(style: BorderStyle.none, width: 0),
          //     ),
          //     hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
          //       fontSize: Dimensions.FONT_SIZE_DEFAULT, color: Theme.of(context).disabledColor,
          //     ),
          //     filled: true, fillColor: Theme.of(context).cardColor,
          //   ),
          //   style: Theme.of(context).textTheme.headline2!.copyWith(
          //     color: Theme.of(context).textTheme.bodyText1!.color, fontSize: Dimensions.FONT_SIZE_LARGE,
          //   ),
          // ),
        
         
         
         
          suggestionsCallback: (pattern) async {
            return await Provider.of<SearchProvider>(context, listen: false).
            getHistoryList();
          },
          itemBuilder: (context, String suggestion) {
            return Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Text(suggestion, maxLines: 1, overflow:
               TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(

                color: 
                Theme.of(context).textTheme.bodyLarge!.color, fontSize: Dimensions.FONT_SIZE_LARGE,
              )),
            );
          },
          // onSuggestionSelected: (Prediction suggestion) {
          //   Provider.of<LocationProvider>(context, listen: false).setLocation(suggestion.placeId, suggestion.description, mapController);
          //   Navigator.pop(context);
          // },
        ),
      
      



      
      //  TextFormField(
      //   focusNode: focusNode,
      //   onTapOutside: (event){
      //     // focusNode.unfocus();
      //                           FocusScope.of(context).unfocus();
      
      //   },
      //   onFieldSubmitted: (str){
      // searchProvider.saveSearchAddress(str);
      //   },
      // controller: searchController,
      //   style: TextStyle(
      //     // color: Colors.grey[400] , 
      //   fontSize: 15 , fontWeight: FontWeight.w500
      //   ),
      //   maxLines: 1,
      // decoration: InputDecoration( 
      
      // prefixIcon: Icon(Icons.search ,size: 30,),
      // suffixIcon: IconButton(onPressed: (){
      // searchController.clear();
      // }, icon: Icon(Icons.close)),
      //   fillColor: Colors.grey.withOpacity(.15), 
      //   filled: true , 
      // contentPadding: EdgeInsets.symmetric(vertical: 15),
      //   border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(25) , 
      //     borderSide: BorderSide.none
      //   ), 
      // enabledBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(25) , 
      //     borderSide: BorderSide.none
      //   ), 
      //   focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(25) , 
      //     borderSide: BorderSide.none
      //   ), 
      
      
      
      // ),
      
      // ),
    
    
    ),
    ),), 
    SizedBox(height: 10,),
  
 Consumer<SearchProvider>(
              builder: (context, searchProvider, child) {
                return !searchProvider.isClear ? 
                searchProvider.searchProductList != null ?
                searchProvider.searchProductList!.length > 0 ?
                Expanded(child: SearchProductWidget(products: searchProvider.searchProductList, isViewScrollable: true)) :
                Expanded(child: NoInternetOrDataScreen(isNoInternet: false)) :
                Expanded(child: ProductShimmer(isHomePage: false,
                    isEnabled: Provider.of<SearchProvider>(context).searchProductList == null)
                )
                    
                    
                     :

    Column(children: [

      Padding(
       padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextButton(onPressed: (){
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
    )
    ,  
    
    
    Consumer<SearchProvider>(
                            builder: (context, searchProvider, child) => 
    
    Visibility(
      visible:searchProvider.historyList.isNotEmpty ,
      child: Column(children: [ 
      
                                    Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: 
                                  
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(getTranslated('SEARCH_HISTORY', context)!, style: robotoBold.copyWith(
      
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
                                    // height: 
                                    // searchProvider.historyList.length*50 > 
      
                                    // MediaQuery.of(context).size.height/4?
                                    // MediaQuery.of(context).size.height/4
                                    // :
                                    //  searchProvider.historyList.length*50,
      
      
      
                                    // MediaQuery.of(context).size.height/4
                                    // ,
                                    child: StaggeredGridView.countBuilder(
                                      crossAxisCount: 2,
                                      shrinkWrap: true,
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
                               
                           
      //  Padding(
      //  padding: const EdgeInsets.all(8.0),
      //  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                                 children: [
      //                                   Text('Last Search products', style: robotoBold.copyWith(
       
      //                                                fontSize:     isTablet(context)? 20:null
       
       
      //                                   )),
      //                                 ]
      //  ),
      //  )
      
      
      ],),
    )
    
    
    
    
    
    
    
    
    
    )
    
    
    
    ],
    
    );
 
    
    
  })],
    ),
  ),
),
    );
  }
}