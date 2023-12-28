import 'package:eamar_user_app/data/model/response/category.dart';
import 'package:eamar_user_app/view/screen/home/widget/category_details_screen.dart';
import 'package:eamar_user_app/view/screen/product/all_product_by_category.dart';
import 'package:eamar_user_app/view/screen/product/category_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/provider/category_provider.dart';
import 'package:eamar_user_app/view/screen/home/widget/category_widget.dart';
import 'package:eamar_user_app/view/screen/product/brand_and_category_product_screen.dart';
import 'package:provider/provider.dart';

import 'category_shimmer.dart';

class CategoryView extends StatefulWidget {
  final bool isHomePage;
  final bool isTablet;

  CategoryView({required this.isHomePage , this.isTablet=false});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
 
  @override
  Widget build(BuildContext context) {
  
    return Consumer<CategoryProvider>(
      
      builder: (context, categoryProvider, child) {
  // var pages =  (widget.categories.length /6).ceil();
return 
        
        categoryProvider.categoryList.length != 0 ?

CategoryPageView(categories: categoryProvider.categoryList,isTablet: widget.isTablet,)
: CategoryShimmer();
        // return SizedBox();

      },
    );
  }
}



class CategoryPageView extends StatefulWidget {
final bool? isTablet;
  final List<Category>? categories;
  const CategoryPageView({super.key, this.categories , this.isTablet});

  @override
  State<CategoryPageView> createState() => _CategoryPageViewState();
}

class _CategoryPageViewState extends State<CategoryPageView> {

 var currentPageValue = 0.0;

  int totalGridItems=6; 

  int startItem=0;

  PageController controller = PageController();
  bool isLastPage= false;
  int? pages;
  int? lastPageITems;
@override
void initState() {
  super.initState();
  totalGridItems = widget.isTablet!?8:6;
// WidgetsBinding.instance.addPostFrameCallback((_) {
  // executes after build

   pages = widget.isTablet!? (widget.categories!.length /8).ceil():     (widget.categories!.length /6).ceil();
  controller.addListener(() {
  setState(() {
    currentPageValue = controller.page!;
    startItem =widget.isTablet!?currentPageValue.toInt()*8:  currentPageValue.toInt()*6;
isLastPage= currentPageValue.toInt()+1==pages;

   lastPageITems =
   widget.isTablet!?

    widget.categories!.length<8?
  0: widget.categories!.length%8
  :
    widget.categories!.length<6?
  0: widget.categories!.length%6
  
  
  
  ;




  // });
});
});



  
}


  @override
  Widget build(BuildContext context) {


    var categoryProvider =Provider.of<CategoryProvider>(context);
   
   return
    widget.isTablet!? 
      
categoryProvider.categoryList.length >=8?
// grid
SizedBox(
  height:  MediaQuery.of(context).size.height/2.8,
  child: 
          GridView.builder( 
             shrinkWrap: true,
             physics: NeverScrollableScrollPhysics(),
             
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount:8   
                  ,
                  // widget.categories.length,
                  itemBuilder: (BuildContext context, int index) {

// 0 -5//     index*startItem
//6 -7
// var cat = widget.categories[currentPageValue.toInt()]

                    return
                    
                     InkWell(
                      onTap: () {
                        categoryProvider.changeSelectedIndex(index);
                        
            
            
            
            
            if (widget.categories![index].subCategories!.length>0) {
          //  Navigator.push(context, MaterialPageRoute(builder: (_) =>
          //                CategoryDetailsScreen(
          //                 isBrand: false,
          //                 category: widget.categories[index],
          //                 id: widget.categories[index].id.toString(),
          //                 name: widget.categories[index].name,
          //               )));
            
            
            
            
            
            
            
            Navigator.push(context, MaterialPageRoute(builder: (_) =>
                         CategoryDetailsPage(
                          // isBrand: false,
                          category: widget.categories![index],
                          // id: widget.categories[index].id.toString(),
                          // name: widget.categories[index].name,
                        )));
            
            
            
            
            
            
            } else {
            
            
              Navigator.push(context, MaterialPageRoute(builder: (_) =>
                         AllProductsByCategory(
                          isBrand: false,
                          // category: widget.categories[index],
                          id: widget.categories![index].id.toString(),
                          name: widget.categories![index].name,
                        )));
            
            
            
            
            
            }
            
            
                     
                      },
                      child: CategoryWidget(category: widget.categories![index]),
                    );
              
            
                  },
                )
            ,
)

:
SizedBox(
   height:  250,
   child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryProvider.categoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return 
                    
                    
                     InkWell(
                      onTap: () {
                        categoryProvider.changeSelectedIndex(index);
                        
            
            
            
            
            if (widget.categories![index].subCategories!.length>0) {
          //  Navigator.push(context, MaterialPageRoute(builder: (_) =>
          //                CategoryDetailsScreen(
          //                 isBrand: false,
          //                 category: widget.categories[index],
          //                 id: widget.categories[index].id.toString(),
          //                 name: widget.categories[index].name,
          //               )));
            
            
            
            
            
            
            
            Navigator.push(context, MaterialPageRoute(builder: (_) =>
                         CategoryDetailsPage(
                          // isBrand: false,
                          category: widget.categories![index],
                          // id: widget.categories[index].id.toString(),
                          // name: widget.categories[index].name,
                        )));
            
            
            
            
            
            
            } else {
            
            
              Navigator.push(context, MaterialPageRoute(builder: (_) =>
                         AllProductsByCategory(
                          isBrand: false,
                          // category: widget.categories[index],
                          id: widget.categories![index].id.toString(),
                          name: widget.categories![index].name,
                        )));
            
            
            
            
            
            }
            
            
                     
                      },
                      child: CategoryWidget(category: widget.categories![index]),
                    );
                    },
                  ),
)



//listview
:




categoryProvider.categoryList.length >=6?

// grid
SizedBox(
  height: MediaQuery.of(context).size.height/3.8,
  child: 
          GridView.builder( 
             shrinkWrap: true,
             physics: NeverScrollableScrollPhysics(),
             
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount:
                  
                  
                  6   
                  ,
                  // widget.categories.length,
                  itemBuilder: (BuildContext context, int index) {

// 0 -5//     index*startItem
//6 -7
// var cat = widget.categories[currentPageValue.toInt()]

                    return
                    
                     InkWell(
                      onTap: () {
                        categoryProvider.changeSelectedIndex(index);
                        
            
            
            
            
            if (widget.categories![index].subCategories!.length>0) {
          //  Navigator.push(context, MaterialPageRoute(builder: (_) =>
          //                CategoryDetailsScreen(
          //                 isBrand: false,
          //                 category: widget.categories[index],
          //                 id: widget.categories[index].id.toString(),
          //                 name: widget.categories[index].name,
          //               )));
            
            
            
            
            
            
            
            Navigator.push(context, MaterialPageRoute(builder: (_) =>
                         CategoryDetailsPage(
                          // isBrand: false,
                          category: widget.categories![index],
                          // id: widget.categories[index].id.toString(),
                          // name: widget.categories[index].name,
                        )));
            
            
            
            
            
            
            } else {
            
            
              Navigator.push(context, MaterialPageRoute(builder: (_) =>
                         AllProductsByCategory(
                          isBrand: false,
                          // category: widget.categories[index],
                          id: widget.categories![index].id.toString(),
                          name: widget.categories![index].name,
                        )));
            
            
            
            
            
            }
            
            
                     
                      },
                      child: CategoryWidget(category: widget.categories![index]),
                    );
              
            
                  },
                )
            ,
)

:
SizedBox(
   height:  150,
   child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryProvider.categoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return 
                    
                    
                     InkWell(
                      onTap: () {
                        categoryProvider.changeSelectedIndex(index);
                        
            
            
            
            
            if (widget.categories![index].subCategories!.length>0) {
          //  Navigator.push(context, MaterialPageRoute(builder: (_) =>
          //                CategoryDetailsScreen(
          //                 isBrand: false,
          //                 category: widget.categories[index],
          //                 id: widget.categories[index].id.toString(),
          //                 name: widget.categories[index].name,
          //               )));
            
            
            
            
            
            
            
            Navigator.push(context, MaterialPageRoute(builder: (_) =>
                         CategoryDetailsPage(
                          // isBrand: false,
                          category: widget.categories![index],
                          // id: widget.categories[index].id.toString(),
                          // name: widget.categories[index].name,
                        )));
            
            
            
            
            
            
            } else {
            
            
              Navigator.push(context, MaterialPageRoute(builder: (_) =>
                         AllProductsByCategory(
                          isBrand: false,
                          // category: widget.categories[index],
                          id: widget.categories![index].id.toString(),
                          name: widget.categories![index].name,
                        )));
            
            
            
            
            
            }
            
            
                     
                      },
                      child: CategoryWidget(category: widget.categories![index]),
                    );
                    },
                  ),
)

//listview
;


   
   
   
    return  
          widget.isTablet!? 
      
      
        SizedBox(
          height: 
            isLastPage&&

                  lastPageITems!<8?

                  widget.isTablet!? 
                  250:
          150
          
          :  widget.isTablet!?   MediaQuery.of(context).size.height/3:
          MediaQuery.of(context).size.height/3.2,
          child:
Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
        Expanded(
          flex: 1,
          child: PageView.builder(
              controller: controller,
              pageSnapping: false,
               physics: BouncingScrollPhysics(),
              itemBuilder: (context, position) {
          return   


            isLastPage&&
                  lastPageITems!<8
                  
                  
                  ?

                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: lastPageITems,
                    itemBuilder: (BuildContext context, int index) {
                      return 
                    
                    
                     InkWell(
                      onTap: () {
                        categoryProvider.changeSelectedIndex(index+startItem);
                        
            
            
            
            
            if (widget.categories![index+startItem].subCategories!.length>0) {
          //  Navigator.push(context, MaterialPageRoute(builder: (_) =>
          //                CategoryDetailsScreen(
          //                 isBrand: false,
          //                 category: widget.categories[index],
          //                 id: widget.categories[index].id.toString(),
          //                 name: widget.categories[index].name,
          //               )));
            
            
            
            
            
            
            
            Navigator.push(context, MaterialPageRoute(builder: (_) =>
                         CategoryDetailsPage(
                          // isBrand: false,
                          category: widget.categories![index+startItem],
                          // id: widget.categories[index].id.toString(),
                          // name: widget.categories[index].name,
                        )));
            
            
            
            
            
            
            } else {
            
            
              Navigator.push(context, MaterialPageRoute(builder: (_) =>
                         AllProductsByCategory(
                          isBrand: false,
                          // category: widget.categories[index],
                          id: widget.categories![index+startItem].id.toString(),
                          name: widget.categories![index+startItem].name,
                        )));
            
            
            
            
            
            }
            
            
                     
                      },
                      child: CategoryWidget(category: widget.categories![index+startItem]),
                    );
                    },
                  ):
          
          
          GridView.builder( 
             shrinkWrap: true,
             physics: NeverScrollableScrollPhysics(),
             
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount:   
                  !isLastPage? 
                  widget.categories!.length<8?
                  widget.categories!.length:
                     8   :lastPageITems,
                  // widget.categories.length,
                  itemBuilder: (BuildContext context, int index) {

// 0 -5//     index*startItem
//6 -7
// var cat = widget.categories[currentPageValue.toInt()]

                    return
                    
                     InkWell(
                      onTap: () {
                        categoryProvider.changeSelectedIndex(index+startItem);
                        
            
            
            
            
            if (widget.categories![index+startItem].subCategories!.length>0) {
          //  Navigator.push(context, MaterialPageRoute(builder: (_) =>
          //                CategoryDetailsScreen(
          //                 isBrand: false,
          //                 category: widget.categories[index],
          //                 id: widget.categories[index].id.toString(),
          //                 name: widget.categories[index].name,
          //               )));
            
            
            
            
            
            
            
            Navigator.push(context, MaterialPageRoute(builder: (_) =>
                         CategoryDetailsPage(
                          // isBrand: false,
                          category: widget.categories![index+startItem],
                          // id: widget.categories[index].id.toString(),
                          // name: widget.categories[index].name,
                        )));
            
            
            
            
            
            
            } else {
            
            
              Navigator.push(context, MaterialPageRoute(builder: (_) =>
                         AllProductsByCategory(
                          isBrand: false,
                          // category: widget.categories[index],
                          id: widget.categories![index+startItem].id.toString(),
                          name: widget.categories![index+startItem].name,
                        )));
            
            
            
            
            
            }
            
            
                     
                      },
                      child: CategoryWidget(category: widget.categories![index+startItem]),
                    );
              
            
                  },
                );
                
              },
              itemCount: pages, // Can be null
            ),
        ),
 SizedBox(height: 2,), 
 
 Center(
child: Container(
  height: 8,
 width: pages!*15+ 20,
 decoration: BoxDecoration(
        color:Colors.grey,
        borderRadius: BorderRadius.circular(50)),
 padding: EdgeInsets.symmetric(horizontal: 10),

  child:   Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children:List.generate(pages!, (index) => Container(
       width: 15,
       decoration: BoxDecoration(
        color: 
        currentPageValue.toInt()==index?
        Theme.of(context).primaryColor:   Colors.transparent,
        borderRadius: BorderRadius.circular(50)),
     
    )
    ),
  ),
),
 )
  ],
)

        
//            ListView.builder(
//             scrollDirection: Axis.horizontal,
//             // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             //   crossAxisCount: 4,
//             //   crossAxisSpacing: 15,
//             //   mainAxisSpacing: 5,
//             //   childAspectRatio: (1/1.3),
//             // ),
//             itemCount: 
            
            
//             // isHomePage
//             //     ? widget.categories.length > 8
//             //        ? 8
//             //        : widget.categories.length
//             //     : 
                
//                 widget.categories.length,
//             shrinkWrap: true,
//             physics: ScrollPhysics(),
//             itemBuilder: (BuildContext context, int index) {
        




//               return
              
//                InkWell(
//                 onTap: () {
//                   categoryProvider.changeSelectedIndex(index);
                  




// if (widget.categories[index].subCategories!.length>0) {
//     //  Navigator.push(context, MaterialPageRoute(builder: (_) =>
//     //                CategoryDetailsScreen(
//     //                 isBrand: false,
//     //                 category: widget.categories[index],
//     //                 id: widget.categories[index].id.toString(),
//     //                 name: widget.categories[index].name,
//     //               )));







// Navigator.push(context, MaterialPageRoute(builder: (_) =>
//                    CategoryDetailsPage(
//                     // isBrand: false,
//                     category: widget.categories[index],
//                     // id: widget.categories[index].id.toString(),
//                     // name: widget.categories[index].name,
//                   )));






// } else {


//   Navigator.push(context, MaterialPageRoute(builder: (_) =>
//                    AllProductsByCategory(
//                     isBrand: false,
//                     // category: widget.categories[index],
//                     id: widget.categories[index].id.toString(),
//                     name: widget.categories[index].name,
//                   )));





// }


               
//                 },
//                 child: CategoryWidget(category: widget.categories[index]),
//               );
        
           
           
//             },
//           ),
        
        
        
        )







:
        SizedBox(
          height: 
            isLastPage&&

                  lastPageITems!<6?
                  widget.isTablet!? 300:
          150
          
          :  widget.isTablet!?   MediaQuery.of(context).size.height/2.3:
          MediaQuery.of(context).size.height/3.2,
          child:
Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
        Expanded(
          flex: 1,
          child: PageView.builder(
              controller: controller,
              pageSnapping: false,
               physics: BouncingScrollPhysics(),
              itemBuilder: (context, position) {
          return   


            isLastPage&&
                  lastPageITems!<6
                  
                  
                  ?

                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: lastPageITems,
                    itemBuilder: (BuildContext context, int index) {
                      return 
                    
                    
                     InkWell(
                      onTap: () {
                        categoryProvider.changeSelectedIndex(index+startItem);
                        
            
            
            
            
            if (widget.categories![index+startItem].subCategories!.length>0) {
          //  Navigator.push(context, MaterialPageRoute(builder: (_) =>
          //                CategoryDetailsScreen(
          //                 isBrand: false,
          //                 category: widget.categories[index],
          //                 id: widget.categories[index].id.toString(),
          //                 name: widget.categories[index].name,
          //               )));
            
            
            
            
            
            
            
            Navigator.push(context, MaterialPageRoute(builder: (_) =>
                         CategoryDetailsPage(
                          // isBrand: false,
                          category: widget.categories![index+startItem],
                          // id: widget.categories[index].id.toString(),
                          // name: widget.categories[index].name,
                        )));
            
            
            
            
            
            
            } else {
            
            
              Navigator.push(context, MaterialPageRoute(builder: (_) =>
                         AllProductsByCategory(
                          isBrand: false,
                          // category: widget.categories[index],
                          id: widget.categories![index+startItem].id.toString(),
                          name: widget.categories![index+startItem].name,
                        )));
            
            
            
            
            
            }
            
            
                     
                      },
                      child: CategoryWidget(category: widget.categories![index+startItem]),
                    );
                    },
                  ):
          
          
          GridView.builder( 
             shrinkWrap: true,
             physics: NeverScrollableScrollPhysics(),
             
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount:   
                  !isLastPage? 
                  widget.categories!.length<6?
                  widget.categories!.length:
                     6   :lastPageITems,
                  // widget.categories.length,
                  itemBuilder: (BuildContext context, int index) {

// 0 -5//     index*startItem
//6 -7
// var cat = widget.categories[currentPageValue.toInt()]

                    return
                    
                     InkWell(
                      onTap: () {
                        categoryProvider.changeSelectedIndex(index+startItem);
                        
            
            
            
            
            if (widget.categories![index+startItem].subCategories!.length>0) {
          //  Navigator.push(context, MaterialPageRoute(builder: (_) =>
          //                CategoryDetailsScreen(
          //                 isBrand: false,
          //                 category: widget.categories[index],
          //                 id: widget.categories[index].id.toString(),
          //                 name: widget.categories[index].name,
          //               )));
            
            
            
            
            
            
            
            Navigator.push(context, MaterialPageRoute(builder: (_) =>
                         CategoryDetailsPage(
                          // isBrand: false,
                          category: widget.categories![index+startItem],
                          // id: widget.categories[index].id.toString(),
                          // name: widget.categories[index].name,
                        )));
            
            
            
            
            
            
            } else {
            
            
              Navigator.push(context, MaterialPageRoute(builder: (_) =>
                         AllProductsByCategory(
                          isBrand: false,
                          // category: widget.categories[index],
                          id: widget.categories![index+startItem].id.toString(),
                          name: widget.categories![index+startItem].name,
                        )));
            
            
            
            
            
            }
            
            
                     
                      },
                      child: CategoryWidget(category: widget.categories![index+startItem]),
                    );
              
            
                  },
                );
                
              },
              itemCount: pages, // Can be null
            ),
        ),
 SizedBox(height: 2,), 
 
 Center(
child: Container(
  height: 8,
 width: pages!*15+ 20,
 decoration: BoxDecoration(
        color:Colors.grey,
        borderRadius: BorderRadius.circular(50)),
 padding: EdgeInsets.symmetric(horizontal: 10),

  child:   Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children:List.generate(pages!, (index) => Container(
       width: 15,
       decoration: BoxDecoration(
        color: 
        currentPageValue.toInt()==index?
        Theme.of(context).primaryColor:   Colors.transparent,
        borderRadius: BorderRadius.circular(50)),
     
    )
    ),
  ),
),
 )
  ],
)

        
//            ListView.builder(
//             scrollDirection: Axis.horizontal,
//             // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             //   crossAxisCount: 4,
//             //   crossAxisSpacing: 15,
//             //   mainAxisSpacing: 5,
//             //   childAspectRatio: (1/1.3),
//             // ),
//             itemCount: 
            
            
//             // isHomePage
//             //     ? widget.categories.length > 8
//             //        ? 8
//             //        : widget.categories.length
//             //     : 
                
//                 widget.categories.length,
//             shrinkWrap: true,
//             physics: ScrollPhysics(),
//             itemBuilder: (BuildContext context, int index) {
        




//               return
              
//                InkWell(
//                 onTap: () {
//                   categoryProvider.changeSelectedIndex(index);
                  




// if (widget.categories[index].subCategories!.length>0) {
//     //  Navigator.push(context, MaterialPageRoute(builder: (_) =>
//     //                CategoryDetailsScreen(
//     //                 isBrand: false,
//     //                 category: widget.categories[index],
//     //                 id: widget.categories[index].id.toString(),
//     //                 name: widget.categories[index].name,
//     //               )));







// Navigator.push(context, MaterialPageRoute(builder: (_) =>
//                    CategoryDetailsPage(
//                     // isBrand: false,
//                     category: widget.categories[index],
//                     // id: widget.categories[index].id.toString(),
//                     // name: widget.categories[index].name,
//                   )));






// } else {


//   Navigator.push(context, MaterialPageRoute(builder: (_) =>
//                    AllProductsByCategory(
//                     isBrand: false,
//                     // category: widget.categories[index],
//                     id: widget.categories[index].id.toString(),
//                     name: widget.categories[index].name,
//                   )));





// }


               
//                 },
//                 child: CategoryWidget(category: widget.categories[index]),
//               );
        
           
           
//             },
//           ),
        
        
        
        )


        
       

      ;
  }
}

