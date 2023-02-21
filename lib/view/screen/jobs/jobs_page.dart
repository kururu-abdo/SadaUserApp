
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eamar_user_app/data/model/response/city.dart';
import 'package:eamar_user_app/data/model/response/region.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/auth_provider.dart';
import 'package:eamar_user_app/provider/cart_provider.dart';
import 'package:eamar_user_app/provider/jobs_provider.dart';
import 'package:eamar_user_app/provider/localization_provider.dart';
import 'package:eamar_user_app/provider/theme_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/view/basewidget/title_row.dart';
import 'package:eamar_user_app/view/screen/cart/cart_screen.dart';
import 'package:eamar_user_app/view/screen/category/all_category_screen.dart';
import 'package:eamar_user_app/view/screen/home/home_screens.dart';
import 'package:eamar_user_app/view/screen/home/widget/category_view.dart';
import 'package:eamar_user_app/view/screen/jobs/add_job_page.dart';
import 'package:eamar_user_app/view/screen/jobs/widgets/bottom_sheet_modal.dart';
import 'package:eamar_user_app/view/screen/jobs/widgets/jobs_view.dart';
import 'package:eamar_user_app/view/screen/search/search_screen.dart';
import 'package:provider/provider.dart';

class JobsPage extends StatefulWidget {
    final bool isBacButtonExist;

  const JobsPage({ Key key  ,this.isBacButtonExist=true}) : super(key: key);

  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  final ScrollController _scrollController = ScrollController();

 bool _isVisible=true;




  Future<void> _loadData(BuildContext context, bool reload) async {
    await Provider.of<JobsProvider>(context, listen: false).getJobs( context ,
    Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode
    ,reload: reload
    
    );

await Provider.of<JobsProvider>(context, listen: false).getUserJobs( context ,
    Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode
    ,reload: reload
    
    );

  }








 @override
 void initState() { 
   super.initState();


   _scrollController.addListener((){
      if(_scrollController.position.userScrollDirection == ScrollDirection.reverse){
        if(_isVisible == true) {
            /* only set when the previous state is false
             * Less widget rebuilds 
             */
            print("**** ${_isVisible} up"); //Move IO away from setState
            setState((){
              _isVisible = false;
            });
        }
      } else {
        if(_scrollController.position.userScrollDirection == ScrollDirection.forward){
          if(_isVisible == false) {
              /* only set when the previous state is false
               * Less widget rebuilds 
               */
               print("**** ${_isVisible} down"); //Move IO away from setState
               setState((){
                 _isVisible = true;
               });
           }
        }
    }});

      _loadData(context, false);
 }

  @override
  Widget build(BuildContext context) {

    bool isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();


     return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,


   body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            await _loadData(context, true);
            // await Provider.of<FlashDealProvider>(context, listen: false).getMegaDealList(true, context, false);

            return true;
          },
child: Stack(
            children: [ 

  CustomScrollView(
                controller: _scrollController,
                slivers: [ 

    // App Bar
                  SliverAppBar(
                    floating: true,
                    elevation: 0,
                    toolbarHeight: 100,
                    centerTitle: false,
                    automaticallyImplyLeading: false,
                    backgroundColor: Theme.of(context).highlightColor,
                    title: Image.asset(Images.logo_with_name_image, height: 100 ,scale: 1.2,),
                    actions: [
                    //  Container(
                    //                 width: 20,height: 20,decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                    //                   borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL))
                    //               ),
                    //                 child:
                                    
                                     InkWell(
                                       onTap: (){
                                         showModalBottomSheet(context: context,
                                         
                                         
                                         shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        ), 
                                          builder: (_){

                                           return FilterBottomSheet();
                                         });
                                       },
                                       child: Icon(
                                        Icons.filter_alt_outlined, 
                                     
                                     
                                        // Icons.search, 
                                        
                                        color:Theme.of(context).primaryColor
                                                                         
                                                                         //  Theme.of(context).cardColor
                                                                         
                                                                         , size: Dimensions.ICON_SIZE_DEFAULT),
                                     ),
                                  // ),
                     
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 12.0),
                      //   child: IconButton(
                      //     onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (_) => 
                      //     CartScreen()));
                      //     },
                      //     icon: Stack(clipBehavior: Clip.none, children: [
                      //       Image.asset(
                      //         Images.cart_arrow_down_image,
                      //         height: Dimensions.ICON_SIZE_DEFAULT,
                      //         width: Dimensions.ICON_SIZE_DEFAULT,
                      //         color: ColorResources.getPrimary(context),
                      //       ),
                      //       Positioned(top: -4, right: -4,
                      //         child: Consumer<CartProvider>(builder: (context, cart, child) {
                      //           return CircleAvatar(radius: 7, backgroundColor: ColorResources.RED,
                      //             child: Text(cart.cartList.length.toString(),
                      //                 style: titilliumSemiBold.copyWith(color: ColorResources.WHITE, fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                      //                 )),
                      //           );
                      //         }),
                      //       ),
                      //     ]),
                      //   ),
                      // ),


                    ],
                  ),

 // Search Button
                  SliverPersistentHeader(
                      pinned: true,
                      delegate: SliverDelegate(
                          child: InkWell(
                        onTap: () {
showModalBottomSheet(context: context,
                                         
                                         
                                         shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        ), 
                                          builder: (_){

                                           return FilterBottomSheet();
                                         });

                        }
                        
                        // =>
                        //  Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScreen()))
                         
                         
                         
                         ,


                            child: Container(padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.HOME_PAGE_PADDING, vertical: Dimensions.PADDING_SIZE_SMALL),
                              color: ColorResources.getHomeBg(context),
                              alignment: Alignment.center,
                              child: Container(padding: EdgeInsets.only(
                                left: Dimensions.HOME_PAGE_PADDING, right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                top: Dimensions.PADDING_SIZE_EXTRA_SMALL, bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              ),

                                height: 60,
                                 alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(color: Theme.of(context).cardColor,
                                  boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ?
                                  900 : 200], spreadRadius: 1, blurRadius: 1)],
                                  borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),),
                                child: Row(mainAxisAlignment :
                                 MainAxisAlignment.spaceBetween, children: [
// TextFormField(
  
// )
                                  Text(getTranslated('search_job_txt', context),
                                      style: robotoRegular.copyWith(color: Theme.of(context).hintColor)
                                      
                                      ),

                                  Container(
                                    width: 40,height: 40,decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL))
                                  ),
                                    child: Icon(
                                      Icons.filter_alt_outlined, 


                                      // Icons.search, 
                                      
                                      color:Colors.black
                                    
                                    //  Theme.of(context).cardColor
                                    
                                    , size: Dimensions.ICON_SIZE_DEFAULT),
                                  ),
                         
                         
                         
                         
                            ]),
                          ),
                        ),
                      ))),



           SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(Dimensions.HOME_PAGE_PADDING,


                          Dimensions.PADDING_SIZE_SMALL, Dimensions.PADDING_SIZE_DEFAULT,
                           Dimensions.PADDING_SIZE_SMALL  ),
                      child: Column(
                        children: [


                                    JobsView(isJobsHome: false, 
                                    
                                    // job: 7,
                                     scrollController: _scrollController)


//  // Category
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                             child: TitleRow(title: getTranslated('CATEGORY', context),
//                                 onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => 
//                                 AllCategoryScreen()))),
//                           ),
//                           SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: Dimensions.HOME_PAGE_PADDING),
//                             child: CategoryView(isHomePage: true),
//                           ),










                        ])))










                 ])



            ]),

    ) )



,
floatingActionButton: Visibility(
        visible: _isVisible,
        maintainAnimation: true,
        maintainState: true,
  child:   FloatingActionButton.extended(onPressed: 
  
  (){
Navigator.of(context).push(
  MaterialPageRoute(builder: (_)=>AddJobPage(

  ))
);


  },label: Text(getTranslated('add_job_txt', context) ,
  style: TextStyle(
    color: Colors.white
  ),
  ),
  icon:Icon(Icons.add ,   color: Colors.white),
  // child: Icon(Icons.add),
  ),
),





    );
  }
}


class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({@required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 70 || oldDelegate.minExtent != 70 || child != oldDelegate.child;
  }
}








class SearchCitiesAlert extends StatefulWidget {
  List<City>  cities;
  Function(City) onCitySelcted;
   SearchCitiesAlert({ Key key  ,this.cities ,this.onCitySelcted}) : super(key: key);

  @override
  _SearchCitiesAlertState createState() => _SearchCitiesAlertState();
}

class _SearchCitiesAlertState extends State<SearchCitiesAlert> {
 
  TextEditingController editingController = TextEditingController();




  final duplicateItems = <City>[];
  var items = <City>[];



@override
void initState() { 
  super.initState();
  if(mounted){
   setState((){
     duplicateItems.addAll(widget.cities);
       items.addAll(duplicateItems);
   });
  }
}









void filterSearchResults(String query) {
  List<City> dummySearchList = <City>[];
  dummySearchList.addAll(duplicateItems);
  if(query.isNotEmpty) {
    List<City> dummyListData = <City>[];
    dummySearchList.forEach((item) {
      if(item.name.contains(query)) {
        dummyListData.add(item);
      }
    });
    setState(() {
      items.clear();
      items.addAll(dummyListData);
    });
    return;
  } else {
    setState(() {
      items.clear();
      items.addAll(duplicateItems);
    });
  }
}





  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('City List'),
      content:
Column(

  
  children: [

     Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
        Container(
        height: 300.0, // Change as per your requirement
        width: 300.0, // Change as per your requirement
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: (){
    widget.onCitySelcted(items[index]);
        Navigator.pop(context);

              },
              title: Text(items[index].name),
            );
          },
        ),
      ),
  ],
)

    );
  }
}


class RegionListAlert extends StatefulWidget {
  List<Region>  regions;
  Function(Region) onRegionSelected;
   RegionListAlert({ Key key , this.regions , this.onRegionSelected }) : super(key: key);

  @override
  _RegionListAlertState createState() => _RegionListAlertState();
}

class _RegionListAlertState extends State<RegionListAlert> {


  TextEditingController editingController = TextEditingController();




  final duplicateItems = <Region>[];
  var items = <Region>[];



@override
void initState() { 
  super.initState();
  if(mounted){
   setState((){
     duplicateItems.addAll(widget.regions);
       items.addAll(duplicateItems);
   });
  }
}









void filterSearchResults(String query) {
  List<Region> dummySearchList = <Region>[];
  dummySearchList.addAll(duplicateItems);
  if(query.isNotEmpty) {
    List<Region> dummyListData = <Region>[];
    dummySearchList.forEach((item) {
      if(item.name.contains(query)) {
        dummyListData.add(item);
      }
    });
    setState(() {
      items.clear();
      items.addAll(dummyListData);
    });
    return;
  } else {
    setState(() {
      items.clear();
      items.addAll(duplicateItems);
    });
  }
}





  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Regin List'),
      content:
Column(

  
  children: [

     Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
        Container(
        height: 300.0, // Change as per your requirement
        width: 300.0, // Change as per your requirement
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: (){
    widget.onRegionSelected(items[index]);
    Navigator.pop(context);
              },
              title: Text(items[index].name),
            );
          },
        ),
      ),
  ],
)

    );
  }
}










