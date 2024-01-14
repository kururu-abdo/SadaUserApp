import 'dart:developer';

import 'package:eamar_user_app/data/model/response/category.dart';
import 'package:eamar_user_app/data/model/response/product_model.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/category_provider.dart';
import 'package:eamar_user_app/provider/product_provider.dart';
import 'package:eamar_user_app/provider/splash_provider.dart';
import 'package:eamar_user_app/provider/theme_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/view/basewidget/custom_app_bar.dart';
import 'package:eamar_user_app/view/basewidget/no_internet_screen.dart';
import 'package:eamar_user_app/view/basewidget/product_shimmer.dart';
import 'package:eamar_user_app/view/basewidget/product_widget.dart';
import 'package:eamar_user_app/view/screen/category/sub_categories_page.dart';
import 'package:eamar_user_app/view/screen/home/widget/category_widget.dart';
import 'package:eamar_user_app/view/screen/search/widget/filter_category_products.dart';
import 'package:eamar_user_app/view/screen/search/widget/search_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class CategoryDetailsPage extends StatefulWidget {
  final   Category?  category;
  final int? index;
  const CategoryDetailsPage({ Key? key, this.category, this.index }) : super(key: key);

  @override
  _CategoryDetailsPageState createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {

@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    log('ITEM INDEX     ' + widget.index.toString());
     log('ITEM INDEX     ' + widget.category!.name.toString());
    context.read<CategoryProvider>().changeCurrentViewState(
      
      context,
    
     CategoryViewState(

      value: 'category', 
      subValue: 'categoies', 
      itemId: widget.category!.id , 
      // subCategory:
      
      //    widget.category!.subCategories!.isNotEmpty?
      //  widget.category!.subCategories!.first.id: 0 , 
       title:    widget.category!.name! , 
       category: widget.index

     ));
context.read<CategoryProvider>().getCategoryTitles(context);

  });
}



  @override
  Widget build(BuildContext context) {
var provider = Provider.of<CategoryProvider>(context);
              WidgetsBinding.instance.addPostFrameCallback((_) {

provider.getCategoryTitles(context);
              });
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CustomAppBar(title: 
          
          widget.category!.name!
          // getTranslated('CATEGORY', context)
          
          
          ),


// Text('All Categories >') ,
// Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 10) ,
//   child: CategoryTitle(
//     title: 'Categories',
//   ),
// )
// ,
//, categoryProvider, child
Builder(
            builder: (context) {
// categoryProvider.getTabsTitles(context);
return  Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8) , 
  child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    physics: BouncingScrollPhysics(),
    child: Row(
    children: provider.tabs2.map((e) => 
    
    
    GestureDetector(
      onTap: (){
        if (e.subValue!="product") {
              WidgetsBinding.instance.addPostFrameCallback((_) {
              provider.changeCurrentViewState( context,
              
              CategoryViewState(
                value: e.value , 
                itemId: e.itemId , 
                subCategory: e.subCategory , 
                subSubcategory: e.subSubcategory , 
                category: e.category , 
                subValue: e.subValue , 
                title: e.title
              )
              
              );
              });
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,children: [ 
      
        Text(e.title! , 
        
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
        )  , 
        SizedBox(width: 1,)
      ,
       Icon(Icons.arrow_forward_ios ,size: 15,color: Theme.of(context).primaryColor,)
      ]),
    )
    ).toList(),
    ),
  ),
);
    //           controller = TabController(
    //   length:categoryProvider.getTabsTitles(context,  
      
      
    //   ).length,
    //   vsync: this,
    //   initialIndex: TabsConfig.selectedTabIndex,
    // );
    //           return TabBar(
    //             isScrollable: true,
    //             controller: controller,
    //             labelColor: Theme.of(context).primaryColor,
    //             unselectedLabelColor: Theme.of(context).hintColor,
    //             indicator: BoxDecoration(
    //               border: Border(
    //                 bottom: BorderSide(
    //                   color: Theme.of(context).primaryColor,
    //                   width: 2,
    //                 ),
    //               ),
    //             ),
    //             tabs: categoryProvider.getTabsTitles(context).map((e) => 
                
                
    //             Text(e.title! , style: TextStyle(
    //               color: Theme.of(context).primaryColor
    //             ),)
                
    //             ).toList()
    //           );
           
           
           
           
           
            },
 ),




          Expanded(child: 
          
          Builder(
            builder: (context)
            
             {
              // return SizedBox();
if (provider.categoryViewState.value=="all_categories") {

return
              
              
               provider.categoryList.length != 0 ? 
             
             
             
              GridView.builder(
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
  childAspectRatio: 8.0 / 9.0,
                
                
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
                
            itemCount: provider.categoryList.length,
            itemBuilder: (BuildContext ctx, index) {
              Category _category = provider.categoryList[index];
              return  InkWell(
                        onTap: () {
// categoryProvider.onTabChange(context, model)
                          // if (_category.subCategories!.length!=0) {
                          //   //go to  subcategories
                          //   Navigator.of(context).push(
                          //     MaterialPageRoute(builder: (_)=>SubCategoriesScreen(
                          //       subCategories: _category.subCategories,
                          //       category: _category,
                          //     ))
                          //   );
                          // }else {
                          //    Navigator.push(context, MaterialPageRoute(builder: (_) => AllProductsByCategory(
                          //     isBrand: false,
                              
                          //     id: _category.id.toString(),
                          //     name: _category.name,
                          //   )));
                          // }
                          // Provider.of<CategoryProvider>(context, listen: false).changeSelectedIndex(index);
                       
                    //  if (_category.subCategories!.isNotEmpty) {
                       
                    //  }  

                    log('CATINDEX   '  +_category.id.toString());
                           WidgetsBinding.instance.addPostFrameCallback((_) {
                        provider.changeCurrentViewState(
                           context,
                       CategoryViewState(                         

  value: 'category' , 
  subValue: 'categoies' ,
  category:  index , 
  itemId: _category.id

 )
                               
                         
                         );

                           });
                        // if (categoryProvider.categoryTabsState.current=="all_categories") {
                          

                        //   //  log('MODEL');
                        // }else {


                        // }
                      
                        
                        
                        },
                        child: CategoryItem(
                          title: _category.name,
                          icon: _category.icon,
                          isSelected: false
                          // categoryProvider.categorySelectedIndex == index,
                        ),
                      );
            }):SizedBox.shrink();


}
else if (provider.categoryViewState.value=="category"

&& provider.categoryViewState.subValue=="categoies"
)


 {
  // return Text('asdfs');
  //sub  categories

  return
              
              
               provider.subCategroies.length != 0 ? 
              GridView.builder(
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
  childAspectRatio: 8.0 / 9.0,
                
                
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
                
            itemCount: provider.subCategroies.length,
            itemBuilder: (BuildContext ctx, index) {
              SubCategory _category = provider.subCategroies[index];
              return  InkWell(
                        onTap: () {
                                              log('CATINDEX   '  +_category.id.toString());

// categoryProvider.onTabChange(context, model)
                          // if (_category.subCategories!.length!=0) {
                          //   //go to  subcategories
                          //   Navigator.of(context).push(
                          //     MaterialPageRoute(builder: (_)=>SubCategoriesScreen(
                          //       subCategories: _category.subCategories,
                          //       category: _category,
                          //     ))
                          //   );
                          // }else {
                          //    Navigator.push(context, MaterialPageRoute(builder: (_) => AllProductsByCategory(
                          //     isBrand: false,
                              
                          //     id: _category.id.toString(),
                          //     name: _category.name,
                          //   )));
                          // }
                          // Provider.of<CategoryProvider>(context, listen: false).changeSelectedIndex(index);
                       
                    //  if (_category.subCategories!.isNotEmpty) {
                       
                    //  }  

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                             provider.changeCurrentViewState(
                          context,
                       CategoryViewState(
  value: 'subCategory' , 
  subValue: 'categoies' ,
  // category:   index , 
  subCategory: index,
 itemId: _category.id
 ) );


                    });
                       
                 
                         
                         
                        


                        // if (categoryProvider.categoryTabsState.current=="all_categories") {
                          

                        //   //  log('MODEL');
                        // }else {


                        // }
                      
                        
                        
                        },
                        child: CategoryItem(
                          title: _category.name,
                          icon: _category.icon,
                          isSelected: false
                          // categoryProvider.categorySelectedIndex == index,
                        ),
                      );
            }):SizedBox.shrink();


}
else if (provider.categoryViewState.value=="subCategory"

&& provider.categoryViewState.subValue=="categoies"
)


 {
 return
              
              
               provider.subSubCategroies.length != 0 ? 
              GridView.builder(
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
  childAspectRatio: 8.0 / 9.0,
                
                
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
                
            itemCount: provider.subSubCategroies.length,
            itemBuilder: (BuildContext ctx, index) {
              SubSubCategory _category = provider.subSubCategroies[index];
              return  InkWell(
                        onTap: () {
                                              log('CATINDEX   '  +_category.id.toString());

// categoryProvider.onTabChange(context, model)
                          // if (_category.subCategories!.length!=0) {
                          //   //go to  subcategories
                          //   Navigator.of(context).push(
                          //     MaterialPageRoute(builder: (_)=>SubCategoriesScreen(
                          //       subCategories: _category.subCategories,
                          //       category: _category,
                          //     ))
                          //   );
                          // }else {
                          //    Navigator.push(context, MaterialPageRoute(builder: (_) => AllProductsByCategory(
                          //     isBrand: false,
                              
                          //     id: _category.id.toString(),
                          //     name: _category.name,
                          //   )));
                          // }
                          // Provider.of<CategoryProvider>(context, listen: false).changeSelectedIndex(index);
                       
                    //  if (_category.subCategories!.isNotEmpty) {
                       
                    //  }  
                           WidgetsBinding.instance.addPostFrameCallback((_) {
                        provider.changeCurrentViewState(    
                                                context,
                         
                       CategoryViewState(
  value: 'subSubCategory' , 
  subValue: 'product' ,
  // category:  index
  subSubcategory: index,
 itemId: _category.id
 )
                         
                         
                         );
                           });

                        // if (categoryProvider.categoryTabsState.current=="all_categories") {
                          

                        //   //  log('MODEL');
                        // }else {


                        // }
                      
                        
                        
                        },
                        child: CategoryItem(
                          title: _category.name,
                          icon: _category.icon,
                          isSelected: false
                          // categoryProvider.categorySelectedIndex == index,
                        ),
                      );
            }):SizedBox.shrink();


}

else {
//products

 return
              // Text('Products');
              
               provider.isProductsLoading ? 
               Center(child: CircularProgressIndicator(),):
              GridView.builder(
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
  childAspectRatio: 6 / 9.0,
                
                
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
                
            itemCount: provider.products!.length,
            itemBuilder: (BuildContext ctx, index) {
              Product _category = provider.products![index];
              return  
              
              InkWell(
                        onTap: () {
// categoryProvider.onTabChange(context, model)
                          // if (_category.subCategories!.length!=0) {
                          //   //go to  subcategories
                          //   Navigator.of(context).push(
                          //     MaterialPageRoute(builder: (_)=>SubCategoriesScreen(
                          //       subCategories: _category.subCategories,
                          //       category: _category,
                          //     ))
                          //   );
                          // }else {
                          //    Navigator.push(context, MaterialPageRoute(builder: (_) => AllProductsByCategory(
                          //     isBrand: false,
                              
                          //     id: _category.id.toString(),
                          //     name: _category.name,
                          //   )));
                          // }
                          // Provider.of<CategoryProvider>(context, listen: false).changeSelectedIndex(index);
                       
                    //  if (_category.subCategories!.isNotEmpty) {
                       
                    //  }  
                       
//                         categoryProvider.changeCurrentViewState(
//                        CategoryViewState(
//   value: 'subSubCategory' , 
//   subValue: 'categoies' ,
//   category:  index

//  )
                         
                         
//                          );


                        // if (categoryProvider.categoryTabsState.current=="all_categories") {
                          

                        //   //  log('MODEL');
                        // }else {


                        // }
                      
                        
                        
                        },
                        child:

                        ProductWidget(productModel: _category)
                      );
            });
            
            // :SizedBox.shrink();


}


          
            },
          )),
        ],
      ),
    );
 
 
    return
    
    
    
    
    
    
     DefaultTabController(
      length: widget.category!.subCategories!.length,
      child: Scaffold(

        
        appBar: AppBar(
centerTitle: false,

title: Text(
              widget.category!.name!, style: titilliumRegular.copyWith(fontSize: 20,
              // color: 
              
              // Theme.of(context).cardColor,
              // Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.black,
              // 
              ),
              maxLines: 1, overflow: TextOverflow.ellipsis,
            ),

actions: [


  
],




          leading:  IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 20,
                // color:Theme.of(context).cardColor
                
                //  Provider.of<ThemeProvider>(context).darkTheme ? 
                // Colors.white :
                //  Colors.black
                 
                 
                 
                 ),
            onPressed: () =>  Navigator.of(context).pop(),
          ) ,
          bottom:  TabBar(   isScrollable: true,
            tabs: widget.category!.subCategories!.map((e) =>   
            //  Tab(
            //   //  height: 20,
            //    child:
                Container(
                  child: Tab(text: '${e.name}'),
              ),




              //   Container(
              //  width: 120,
              //  height: 20,
              //  child:
              //  Tab(
              //    text: '${e.name}'
              //  )
               
                
              //   )
               
              //  ,),
               
               ).toList(),
          ),
        ),
        
        
        
        body: TabBarView(
          
          
          children: widget.category!.subCategories!.map((e) => 
          
          
          
          CategoryItemView(category: widget.category , subCategory: e,)
          ).toList(),
          
          
          
          )

      )
    );
  }
}


class CategoryItemView extends StatefulWidget {
  final Category? category;
    final SubCategory? subCategory;

  const CategoryItemView({ Key? key, this.category, this.subCategory }) : super(key: key);

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryItemView> {


@override
void initState() { 
  super.initState();
  Future.microtask(() {

    context.read<ProductProvider>().filterBrandAndCategoryProductList(context, widget.subCategory!.id);
  }
  
  
  
  );
}







  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child){
        return Column(
          children: [
          

Visibility(
  visible: widget.subCategory!.subSubCategories!.length>0,

  child:  SizedBox( 
     height: MediaQuery.of(context).size.height/5,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //   crossAxisCount: 4,
            //   crossAxisSpacing: 15,
            //   mainAxisSpacing: 5,
            //   childAspectRatio: (1/1.3),
            // ),
            itemCount: 
            
            
            // isHomePage
            //     ? categoryProvider.categoryList.length > 8
            //        ? 8
            //        : categoryProvider.categoryList.length
            //     : 
                
                widget.subCategory!.subSubCategories!.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {


              return
              
               InkWell(
                onTap: () {
                  categoryProvider.changeSelectedSubSubCategory(index);
                  


Provider.of<ProductProvider>(context , listen: false).filterBrandAndCategoryProductList(context, 

widget.subCategory!.subSubCategories![categoryProvider.subSubCategorySelectedIndex!].id

);







               
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [

 Column( children: [
      Container(
        height: MediaQuery.of(context).size.width/5,
        width: MediaQuery.of(context).size.width/5,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.2)),
          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
          color: Theme.of(context).highlightColor,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
          child: FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            placeholder: Images.placeholder,
            image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.categoryImageUrl}'
                '/${categoryProvider.categoryList[index].icon}',
            imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover,),
          ),
        ),
      ),
 
      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      Container(
        child: Center(
          child: Text(categoryProvider.categoryList[index].name!,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
                color: ColorResources.getTextTitle(context)),
          ),
        ),
      ),
 
    ]),



                    // CategoryWidget(category: categoryProvider.categoryList[index]),
                   
                   
                    SizedBox(height: 6,),
                    Visibility(
                      visible: categoryProvider.subSubCategorySelectedIndex==index,
                      
                      child: 
                    AnimatedContainer(
                      duration: Duration(milliseconds: 450),
                      height: 10,
                      width: 10,
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle ,
                        color: Theme.of(context).primaryColor
                      ),
                    )
                    
                    
                    
                    ),



                 


                  ],
                ),
              );
        
           
            })



          )
  
  )

,














Consumer<ProductProvider>(builder: (context , productProvider,child){
return 
   productProvider.brandOrCategoryProductList.length > 0?
Padding(
  padding: const EdgeInsets.symmetric(horizontal:8.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        getLang(context)=="ar"?"النتائج":      
        "Results" ,  ),
  
  
  
              InkWell(onTap: () => 
              
              showModalBottomSheet(context: context,
                  isScrollControlled: true,   constraints: BoxConstraints(
     maxWidth: MediaQuery.of(context).size.width,              
  ),
                  backgroundColor: Colors.transparent,
  
                  builder: (c) => FilterCategoryProductsBottomSheet()
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                        horizontal: Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),),
                    child: Image.asset(Images.dropdown, scale: 3),
  
  
                  ),
                ),
    ],
  ),
):SizedBox.shrink();


}),



Consumer<ProductProvider>(
      builder: (context,   productProvider, child){

        return 
   productProvider.searchBrandOrCategoryProductList.length > 0 
            &&  !productProvider.isProductLoading
            // && !productProvider.isProductLoading
            
            ?
             Expanded(
            
            
              child: StaggeredGridView.countBuilder(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                physics: BouncingScrollPhysics(),
                crossAxisCount: 2,
                itemCount: productProvider.searchBrandOrCategoryProductList.length,
                shrinkWrap: true,
                staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                itemBuilder: (BuildContext context, int index) {
                  return ProductWidget(productModel: productProvider.searchBrandOrCategoryProductList[index]);
                },
              ),
            ) :

      
            Expanded(child: Center(
              child:
              //  !productProvider.hasData
               productProvider.isProductLoading
               
               
                ?

              ProductShimmer(isHomePage: false,

                isEnabled: 
                    productProvider.isProductLoading
               
                // Provider.of<ProductProvider>(context )
                // .brandOrCategoryProductList.length == 0
                
                )
                : 
                NoInternetOrDataScreen(isNoInternet: false),
            ));

      })

          ],
        );
      }
    );
  }
}