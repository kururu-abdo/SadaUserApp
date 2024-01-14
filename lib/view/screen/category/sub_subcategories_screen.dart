
import 'package:cached_network_image/cached_network_image.dart';
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

class SubSubCategoriesScreen extends StatelessWidget {

final

List<SubSubCategory>? subCategories;
final SubCategory? subCategory;

  const SubSubCategoriesScreen({Key? key, this.subCategories, this.subCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        children: [

          CustomAppBar(title:subCategory!.name
          
          // getTranslated('CATEGORY', context)
          
          ),

          Expanded(child: Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) {
              
              return
              
              
               subCategories!.length != 0 ? 
              GridView.builder(
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4 / 4,
                
                
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
                
            itemCount: subCategories!.length,
            itemBuilder: (BuildContext ctx, index) {
              SubSubCategory _category  = subCategories![index];
       
              
              return  InkWell(
                        onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (_) => AllProductsByCategory(
                              isBrand: false,
                              id: _category.id.toString(),
                              name: _category.name,
                            )));
                        
                          // Provider.of<CategoryProvider>(context, listen: false).changeSelectedIndex(index);
                        },
                        child: CategoryItem(
                          title: _category.name,
                          icon: _category.icon,
                          isSelected: false
                          // categoryProvider.categorySelectedIndex == index,
                        ),
                      );
           

                
              

           
            })



              // GridView.count(crossAxisCount: 2 ,
              
              // childAspectRatio: 2/2,
              // children: categoryProvider.categoryList.map((e) => 
              
              
              //  InkWell(
              //           onTap: () => Provider.of<CategoryProvider>(context, listen: false).changeSelectedIndex(index),
              //           child: CategoryItem(
              //             title: _category.name,
              //             icon: _category.icon,
              //             isSelected: categoryProvider.categorySelectedIndex == index,
              //           ),
              //         )

                  
              
              
              
              
              
              
              // ).toList(),
              
              
              
              
              
              
              
              
              
              // )
              
              // Row(children: [

              //   Container(
              //     width: 100,
              //     margin: EdgeInsets.only(top: 3),
              //     height: double.infinity,
              //     decoration: BoxDecoration(
              //       color: Theme.of(context).highlightColor,
              //       boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 200],
              //           spreadRadius: 1, blurRadius: 1)],
              //     ),
              //     child: ListView.builder(
              //       physics: BouncingScrollPhysics(),
              //       itemCount: categoryProvider.categoryList.length,
              //       padding: EdgeInsets.all(0),
              //       itemBuilder: (context, index) {
              //         Category _category = categoryProvider.categoryList[index];
              //         return
              // InkWell(
              //           onTap: () => Provider.of<CategoryProvider>(context, listen: false).changeSelectedIndex(index),
              //           child: CategoryItem(
              //             title: _category.name,
              //             icon: _category.icon,
              //             isSelected: categoryProvider.categorySelectedIndex == index,
              //           ),
              //         );

              //       },
              //     ),
              //   ),

              //   Expanded(child: ListView.builder(
              //     padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              //     itemCount: categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories.length+1,
              //     itemBuilder: (context, index) {

              //       SubCategory _subCategory;
              //       if(index != 0) {
              //         _subCategory = categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories[index-1];
              //       }
              //       if(index == 0) {
              //         return Ink(
              //           color: Theme.of(context).highlightColor,
              //           child: ListTile(
              //             title: Text(getTranslated('all', context), style: titilliumSemiBold, maxLines: 2, overflow: TextOverflow.ellipsis),
              //             trailing: Icon(Icons.navigate_next),
              //             onTap: () {
              //               Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
              //                 isBrand: false,
              //                 id: categoryProvider.categoryList[categoryProvider.categorySelectedIndex].id.toString(),
              //                 name: categoryProvider.categoryList[categoryProvider.categorySelectedIndex].name,
              //               )));
              //             },
              //           ),
              //         );
              //       }else if (_subCategory.subSubCategories.length != 0) {
              //         return Ink(
              //           color: Theme.of(context).highlightColor,
              //           child: Theme(
              //             data: Provider.of<ThemeProvider>(context).darkTheme ? ThemeData.dark() : ThemeData.light(),
              //             child: ExpansionTile(
              //               key: Key('${Provider.of<CategoryProvider>(context).categorySelectedIndex}$index'),
              //               title: Text(_subCategory.name, style: titilliumSemiBold.copyWith(color: Theme.of(context).textTheme.bodyText1.color), maxLines: 2, overflow: TextOverflow.ellipsis),
              //               children: _getSubSubCategories(context, _subCategory),
              //             ),
              //           ),
              //         );
              //       } else {
              //         return Ink(
              //           color: Theme.of(context).highlightColor,
              //           child: ListTile(
              //             title: Text(_subCategory.name, style: titilliumSemiBold, maxLines: 2, overflow: TextOverflow.ellipsis),
              //             trailing: Icon(Icons.navigate_next, color: Theme.of(context).textTheme.bodyText1.color),
              //             onTap: () {
              //               Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
              //                 isBrand: false,
              //                 id: _subCategory.id.toString(),
              //                 name: _subCategory.name,
              //               )));
              //             },
              //           ),
              //         );
              //       }

              //     },
              //   )),

              // ]) 
              
              
              :
              
              
               Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)));
          
          
          
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
                color: Theme.of(context).textTheme.bodyLarge!.color), maxLines: 2, 
                overflow: TextOverflow.ellipsis,
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
      )
      
      );
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

