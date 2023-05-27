import 'package:eamar_user_app/data/model/response/category.dart';
import 'package:eamar_user_app/provider/category_provider.dart';
import 'package:eamar_user_app/provider/product_provider.dart';
import 'package:eamar_user_app/provider/splash_provider.dart';
import 'package:eamar_user_app/provider/theme_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/view/basewidget/no_internet_screen.dart';
import 'package:eamar_user_app/view/basewidget/product_shimmer.dart';
import 'package:eamar_user_app/view/basewidget/product_widget.dart';
import 'package:eamar_user_app/view/screen/home/widget/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class CategoryDetailsPage extends StatefulWidget {
  final   Category?  category;
  
  const CategoryDetailsPage({ Key? key, this.category }) : super(key: key);

  @override
  _CategoryDetailsPageState createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  @override
  Widget build(BuildContext context) {

    //text: '${e.name}'
    return DefaultTabController(
      length: widget.category!.subCategories!.length,
      child: Scaffold(
        appBar: AppBar(


title: Text(
              widget.category!.name!, style: titilliumRegular.copyWith(fontSize: 20,
              color: 
              
              Theme.of(context).cardColor,
              // Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.black,
              // 
              ),
              maxLines: 1, overflow: TextOverflow.ellipsis,
            ),






          leading:  IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 20,
                color:Theme.of(context).cardColor
                
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


















Consumer<ProductProvider>(
      builder: (context,   productProvider, child){

        return 
   productProvider.brandOrCategoryProductList.length > 0 
            &&  !productProvider.isProductLoading
            // && !productProvider.isProductLoading
            
            ?
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
            ));

      })

          ],
        );
      }
    );
  }
}