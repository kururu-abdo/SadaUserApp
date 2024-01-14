import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/view/screen/search/widget/filter_category_products.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/helper/product_type.dart';

import 'package:eamar_user_app/provider/theme_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/view/screen/home/widget/products_view.dart';
import 'package:provider/provider.dart';

class AllProductScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final ProductType productType;
  AllProductScreen({required this.productType});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(

        actions: [ 


            InkWell(onTap: () => 
              
              showModalBottomSheet(context: context,
                  isScrollControlled: true, 
                  backgroundColor: Colors.transparent,
    constraints: BoxConstraints(
     maxWidth: MediaQuery.of(context).size.width,              
  ),
                  builder: (c) => FilterCategoryProductsBottomSheet(

                    productType: productType,
                  )
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                        horizontal: Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),),
                    child: Image.asset(Images.dropdown, scale: 3,  color: Colors.white,),
  
  
                  ),
                ),
        ],
        backgroundColor: Provider.of<ThemeProvider>(context).darkTheme ?
        Colors.black : Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5))),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 30,
            color: ColorResources.WHITE),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(productType == ProductType.DISCOUNTED_PRODUCT ?

        getLang(context)=="ar"?"منتجات مخفضة":
        'Discounted Product'
        
        
        :
         getLang(context)=="ar"?"منتجات اضيفت حديثا":
        
        'Latest Product',
            style: titilliumRegular.copyWith(fontSize: 20, color: ColorResources.WHITE)),
      ),

      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            // return true;
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(

                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: ProductView(isHomePage: false ,
                   productType: productType,
                    scrollController: _scrollController),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
