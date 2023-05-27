import 'package:eamar_user_app/view/screen/home/widget/category_details_screen.dart';
import 'package:eamar_user_app/view/screen/product/all_product_by_category.dart';
import 'package:eamar_user_app/view/screen/product/category_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/provider/category_provider.dart';
import 'package:eamar_user_app/view/screen/home/widget/category_widget.dart';
import 'package:eamar_user_app/view/screen/product/brand_and_category_product_screen.dart';
import 'package:provider/provider.dart';

import 'category_shimmer.dart';

class CategoryView extends StatelessWidget {
  final bool isHomePage;
  CategoryView({required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {

        return 
        
        categoryProvider.categoryList.length != 0 ?
        SizedBox(
          height: MediaQuery.of(context).size.width/4,
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
                
                categoryProvider.categoryList.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
        




              return
              
               InkWell(
                onTap: () {
                  categoryProvider.changeSelectedIndex(index);
                  




if (categoryProvider.categoryList[index].subCategories!.length>0) {
    //  Navigator.push(context, MaterialPageRoute(builder: (_) =>
    //                CategoryDetailsScreen(
    //                 isBrand: false,
    //                 category: categoryProvider.categoryList[index],
    //                 id: categoryProvider.categoryList[index].id.toString(),
    //                 name: categoryProvider.categoryList[index].name,
    //               )));







Navigator.push(context, MaterialPageRoute(builder: (_) =>
                   CategoryDetailsPage(
                    // isBrand: false,
                    category: categoryProvider.categoryList[index],
                    // id: categoryProvider.categoryList[index].id.toString(),
                    // name: categoryProvider.categoryList[index].name,
                  )));






} else {


  Navigator.push(context, MaterialPageRoute(builder: (_) =>
                   AllProductsByCategory(
                    isBrand: false,
                    // category: categoryProvider.categoryList[index],
                    id: categoryProvider.categoryList[index].id.toString(),
                    name: categoryProvider.categoryList[index].name,
                  )));





}


               
                },
                child: CategoryWidget(category: categoryProvider.categoryList[index]),
              );
        
           
           
            },
          ),
        )

        : 
        
        CategoryShimmer();

      },
    );
  }
}



