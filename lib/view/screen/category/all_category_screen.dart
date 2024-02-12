
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eamar_user_app/data/model/response/product_model.dart';
import 'package:eamar_user_app/view/basewidget/product_widget.dart';
import 'package:eamar_user_app/view/screen/category/category_title.dart';
import 'package:eamar_user_app/view/screen/category/sub_categories_page.dart';
import 'package:eamar_user_app/view/screen/product/all_product_by_category.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/data/model/response/category.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/category_provider.dart';
import 'package:eamar_user_app/provider/splash_provider.dart';
import 'package:eamar_user_app/provider/theme_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/view/basewidget/custom_app_bar.dart';
import 'package:eamar_user_app/view/screen/product/brand_and_category_product_screen.dart';
import 'package:provider/provider.dart';
class TabsConfig {
  static List<String> tabs = [];
  static int selectedTabIndex = 0;
}
class AllCategoryScreen extends StatefulWidget {
  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen>
with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    // controller = TabController(
    //   length: TabsConfig.tabs.length,
    //   vsync: this,
    //   initialIndex: TabsConfig.selectedTabIndex,
    // );
    super.initState();
  }

  void updateTabs() {
    try {
      controller = TabController(
        length: TabsConfig.tabs.length,
        vsync: this,
        initialIndex: TabsConfig.selectedTabIndex,
      );
      setState(() {});
    } catch (on) {
      print(on); 
    }
  }
  @override
  Widget build(BuildContext context) {
var provider = Provider.of<CategoryProvider>(context);
              WidgetsBinding.instance.addPostFrameCallback((_) {

provider.getTabsTitles(context);
              });
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CustomAppBar(title: getTranslated('CATEGORY', context)),


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
               Center(child: CircularProgressIndicator.adaptive(),):
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
 
 
 
 
 
  }

  List<Widget> _getSubSubCategories(BuildContext context, SubCategory subCategory) {
    List<Widget> _subSubCategories = [];
    _subSubCategories.add(Container(
      color: ColorResources.getIconBg(context),
      margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: ListTile(
        title: Row(
          children: [
            Container(
              height: 7,
              width: 7,
              decoration: BoxDecoration(color: ColorResources.getPrimary(context), shape: BoxShape.circle),
            ),
            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
            Flexible(child: Text(getTranslated('all', context)!, style: titilliumSemiBold.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color), maxLines: 2, overflow: TextOverflow.ellipsis,
            )),
          ],
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
            isBrand: false,
            id: subCategory.id.toString(),
            name: subCategory.name,
          )));
        },
      ),
    ));
    for(int index=0; index < subCategory.subSubCategories!.length; index++) {
      _subSubCategories.add(Container(
        color: ColorResources.getIconBg(context),
        margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: ListTile(
          title: Row(
            children: [
              Container(
                height: 7,
                width: 7,
                decoration: BoxDecoration(color: ColorResources.getPrimary(context), shape: BoxShape.circle),
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Flexible(child: Text(subCategory.subSubCategories![index].name!, style: titilliumSemiBold.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color), maxLines: 2, overflow: TextOverflow.ellipsis,
              )),
            ],
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
              isBrand: false,
              id: subCategory.subSubCategories![index].id.toString(),
              name: subCategory.subSubCategories![index].name,
            )));
          },
        ),
      ));
    }
    return _subSubCategories;
  }
}

class CategoryItem extends StatelessWidget {
  final String? title;
  final String? icon;
  final bool isSelected;
  CategoryItem({required this.title, required this.icon, required this.isSelected});

  Widget build(BuildContext context) {
    return Card(
  
    clipBehavior: Clip.antiAlias,
    child: Container(
      // padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 18.0 / 13.0,
            child:  ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:
                

                                   CachedNetworkImage(
          width: Dimensions.profileImageSize, height: Dimensions.profileImageSize, fit: BoxFit.cover,
            cacheKey: icon,
               imageUrl:'${Provider.of<SplashProvider>(context,listen: false).baseUrls!.categoryImageUrl}'
                '/${icon}',
              //  progressIndicatorBuilder: (context, url, downloadProgress) => 
        
              //          CircularProgressIndicator(value: downloadProgress.progress),
              
              
               errorWidget: (context, url, error) =>Image.asset(
                Images.placeholder,
               width: Dimensions.profileImageSize, height: Dimensions.profileImageSize, fit: BoxFit.cover),
        placeholder: (context ,child)=>Image.asset(
          Images.placeholder, 
        width: Dimensions.profileImageSize, height: Dimensions.profileImageSize, fit: BoxFit.cover
        ),
            )
                               
                               
                               
                //  FadeInImage.assetNetwork(
                //   placeholder: Images.placeholder, fit: BoxFit.cover,
                //   image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.categoryImageUrl}/$icon',
                //   imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover),
                // ),


              ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title!, maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: titilliumSemiBold.copyWith(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: isSelected ? Theme.of(context).highlightColor : Theme.of(context).hintColor,
              )),
                // const SizedBox(height: 8.0),
                // Text('Secondary Text'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
  
  
  
    return Container(
      width: 100,
      height: 100,
      margin: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isSelected ? ColorResources.getPrimary(context) : null,
      ),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: isSelected ? Theme.of(context).highlightColor : Theme.of(context).hintColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder, fit: BoxFit.cover,
                image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.categoryImageUrl}/$icon',
                imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Text(title!, maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: titilliumSemiBold.copyWith(
              fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
              color: isSelected ? Theme.of(context).highlightColor : Theme.of(context).hintColor,
            )),
          ),
        ]),
      ),
    );
  }
}

