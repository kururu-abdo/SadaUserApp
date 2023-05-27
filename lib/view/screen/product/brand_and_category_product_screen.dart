import 'package:eamar_user_app/provider/category_provider.dart';
import 'package:eamar_user_app/provider/search_provider.dart';
import 'package:eamar_user_app/view/screen/category/filter_item.dart';
import 'package:eamar_user_app/view/screen/home/widget/category_shimmer.dart';
import 'package:eamar_user_app/view/screen/home/widget/category_widget.dart';
import 'package:eamar_user_app/view/screen/home/widget/subSubcategory_widget.dart';
import 'package:eamar_user_app/view/screen/home/widget/subcategory_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/provider/product_provider.dart';
import 'package:eamar_user_app/provider/splash_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/view/basewidget/custom_app_bar.dart';
import 'package:eamar_user_app/view/basewidget/no_internet_screen.dart';
import 'package:eamar_user_app/view/basewidget/product_shimmer.dart';
import 'package:eamar_user_app/view/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class BrandAndCategoryProductScreen extends StatefulWidget {
  final bool isBrand;
  final String id;
  final String? name;
  final String? image;
  BrandAndCategoryProductScreen({required this.isBrand, required this.id, required this.name, this.image});

  @override
  State<BrandAndCategoryProductScreen> createState() => _BrandAndCategoryProductScreenState();
}

class _BrandAndCategoryProductScreenState extends State<BrandAndCategoryProductScreen> {




bool toggleSubCategries=false;
@override
void initState() { 
  super.initState();
  
Future.microtask(() {
 if (mounted) {
      Future.wait([
         Provider.of<ProductProvider>(context, listen: false)
       .initBrandOrCategoryProductList(widget.isBrand,
        widget.id, context),
    
    
    Provider.of<CategoryProvider>(context, listen: false).getSubCategries(),
      ]);

   }

});


}

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [

            CustomAppBar(title: widget.name),

            widget.isBrand ? 
            
            Container(height: 100,
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
              margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
              color: Theme.of(context).highlightColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    
                    
                    crossAxisAlignment: CrossAxisAlignment.center, children: [
                    FadeInImage.assetNetwork(
                      placeholder: Images.placeholder, width: 80, height: 80, fit: BoxFit.cover,
                      image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.brandImageUrl}/${widget.image}',
                      imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, width: 80, height: 80, fit: BoxFit.cover),
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),


                    Text(widget.name!, style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                  ]),



Consumer<CategoryProvider>(
  builder: (context ,provider ,child) {
    return     IconButton(onPressed: (){
      showDialog(context: context, builder: (context){
        return FilterDialogUser(
          cats: provider.categoryList
        );
      });
    }, icon:ImageIcon(
      AssetImage(Images.dropdown ,)  ,color:    Theme.of(context).colorScheme.onBackground,
    ) );
  }
)

// PopupMenuButton(
//                                   itemBuilder: (context) {

//                                   },
                                  
                                  
                                  
//                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL)),
//                                   child: Padding(
//                                     padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL,vertical:Dimensions.PADDING_SIZE_SMALL ),
//                                     child: Image.asset(Images.dropdown, scale: 3,
//                                     color: Theme.of(context).colorScheme.onBackground,
                                    
//                                     ),

//                                   ),
                                  
                                  
                                  
//                                     onSelected: (value) {  }
                                  
                                  
                                  
                                  
                                  
                                  
//                                   )
            
            
                ],
              ),
            )
            
             : 
            
            
           Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child)  {
                return Visibility(
                    visible:      categoryProvider.subCategroies.length != 0 ,
                  child: SizedBox(height: 
                  toggleSubCategries?
                  MediaQuery.of(context).size.height/3:
                  MediaQuery.of(context).size.height/3.3,
                  child: Column(
                    children: [
                Expanded(
                  flex: 1,
                  child: 
                   categoryProvider.subCategroies.length != 0 ?
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //   crossAxisCount: 4,
                          //   crossAxisSpacing: 15,
                          //   mainAxisSpacing: 5,
                          //   childAspectRatio: (1/1.3),
                          // ),
                          itemCount:
                           categoryProvider.subCategroies.length,
                          shrinkWrap: true,
                          physics: PageScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                
                            return InkWell(
                              onTap: () {
                  Provider.of<ProductProvider>(context, listen: false)
                               .filterBrandAndCategoryProductList(context, 
                               categoryProvider.subCategroies[index].id);
                          setState(() {
                            toggleSubCategries = categoryProvider.subCategroies[index].subSubCategories!.length>0;
                          });
                          Provider.of<CategoryProvider>(context, listen: false).getSubSubCategries(categoryProvider.subCategroies[index].id);
                
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                  //   isBrand: false,
                  //   id: categoryProvider.categoryList[index].id.toString(),
                  //   name: categoryProvider.categoryList[index].name,
                  // )
                  // )
                  // );
                              },
                              child: SubCategoryWidget(category: categoryProvider.subCategroies[index]),
                            );
                
                          },
                        )
                
                        : SizedBox.shrink()
                  
                  
                  ),Expanded(
                  flex: 1,
                    
                    child:
                    
                   
                     AnimatedOpacity( child:  
                      categoryProvider.subSubCategroies.length>0?
                    ListView.builder(
                          scrollDirection: Axis.horizontal,
                          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //   crossAxisCount: 4,
                          //   crossAxisSpacing: 15,
                          //   mainAxisSpacing: 5,
                          //   childAspectRatio: (1/1.3),
                          // ),
                          itemCount:
                           categoryProvider.subSubCategroies.length,
                          shrinkWrap: true,
                          physics: PageScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                
                            return InkWell(
                              onTap: () {
                  Provider.of<ProductProvider>(context, listen: false)
                               .filterBrandAndCategoryProductList(context, 
                               categoryProvider.subSubCategroies[index].id);
                //               setState(() {
                // toggleSubCategries=
                //  categoryProvider.subCategroies[index].subSubCategories.length>1;
                //                 //  =!toggleSubCategries;
                //               });
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                  //   isBrand: false,
                  //   id: categoryProvider.categoryList[index].id.toString(),
                  //   name: categoryProvider.categoryList[index].name,
                  // )
                  // )
                  // );
                              },
                              child: 
                              // Container(
                              //   height: 20,width: 40,
                              //   color: Colors.green,
                              // )
                              
                              SubSubCategoryWidget(category: categoryProvider.subSubCategroies[index]),
                            );
                
                          },
                        )
                
                        : SizedBox.shrink() ,
                    
                    duration: Duration(milliseconds: 350) ,
                    opacity:  toggleSubCategries ? 1.0 : 0.0,
                
                    curve: Curves.easeOut,
                    ))
                
                
                
                    ],
                  ),
                  
                  ),
                );
              }
            )
            
            ,

            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

            // Products
            productProvider.brandOrCategoryProductList.length > 0 ?
             Expanded(
              child: StaggeredGridView.countBuilder(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                physics: BouncingScrollPhysics(),
                crossAxisCount: 2,
                itemCount: productProvider.brandOrCategoryProductList.length,
                shrinkWrap: true,
                staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                itemBuilder: (BuildContext context, int index) {
                  return ProductWidget(productModel: productProvider.brandOrCategoryProductList[index]);
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
            )),

          ]);
        },
      ),
    );
  }
}