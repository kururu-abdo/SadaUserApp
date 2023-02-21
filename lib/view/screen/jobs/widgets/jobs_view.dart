import 'package:flutter/material.dart';
import 'package:eamar_user_app/data/model/response/job_model.dart';
import 'package:eamar_user_app/data/model/response/product_model.dart';
import 'package:eamar_user_app/helper/product_type.dart';
import 'package:eamar_user_app/provider/jobs_provider.dart';
import 'package:eamar_user_app/provider/product_provider.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/view/basewidget/jobs_shimmer_simple.dart';
import 'package:eamar_user_app/view/basewidget/product_shimmer.dart';
import 'package:eamar_user_app/view/basewidget/product_shimmer_simple.dart';
import 'package:eamar_user_app/view/basewidget/product_view_simple.dart';
import 'package:eamar_user_app/view/basewidget/product_widget.dart';
import 'package:eamar_user_app/view/screen/jobs/widgets/job_container.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class JobsView extends StatelessWidget {
  final bool isJobsHome;
  // final Job job;
  final ScrollController scrollController;
  final String sellerId;
  JobsView({@required this.isJobsHome, 
  
  
  // @required this.job,
  
  
   this.scrollController, this.sellerId});

  @override
  Widget build(BuildContext context) {
    // int offset = 1;
    // scrollController?.addListener(() {
    //   if(scrollController.position.maxScrollExtent == scrollController.position.pixels
    //       && Provider.of<ProductProvider>(context, listen: false).latestProductList.length != 0
    //       && !Provider.of<ProductProvider>(context, listen: false).filterIsLoading) {
    //     int pageSize;
    //     if(productType == ProductType.BEST_SELLING || productType == ProductType.TOP_PRODUCT || productType == ProductType.NEW_ARRIVAL ) {
    //       pageSize = (Provider.of<ProductProvider>(context, listen: false).latestPageSize/10).ceil();
    //       offset = Provider.of<ProductProvider>(context, listen: false).lOffset;
    //     }

    //     else if(productType == ProductType.SELLER_PRODUCT) {
    //       pageSize = (Provider.of<ProductProvider>(context, listen: false).sellerPageSize/10).ceil();
    //       offset = Provider.of<ProductProvider>(context, listen: false).sellerOffset;
    //     }
    //     if(offset < pageSize) {
    //       print('offset =====>$offset and page sige ====>$pageSize');
    //       offset++;

    //       print('end of the page');
    //       Provider.of<ProductProvider>(context, listen: false).showBottomLoader();


    //       if(productType == ProductType.SELLER_PRODUCT) {
    //         Provider.of<ProductProvider>(context, listen: false).initSellerProductList(sellerId, offset, context);
    //       }else{
    //         Provider.of<ProductProvider>(context, listen: false).getLatestProductList(offset, context);
    //       }

    //     }else{

    //     }
    //   }

    // });

    return Consumer<JobsProvider>(
      builder: (context, JobsProvider, child) {
        List jobList = [

               {
'name':'عبدالرحيم حسن' ,
'address':"الخرطوم" ,
'job':'سباك' ,
'img':'assets/images/contact_us.png',
'email':'abdo@gmail.com',
'phone':'0534874525',
'desc':'lorem lorem lotem lorem lorem lorem lorem lorem loerm lorem lorem lorem lorem lroe  des skdjf sd this des es more funnty videieo s in this channel so far'
          },
               {
'name':'عبدالرحيم حسن' ,
'address':"الخرطوم" ,
'job':'سباك' ,
'img':'assets/images/contact_us.png',
'email':'abdo@gmail.com',
'phone':'0534874525',
'desc':'lorem lorem lotem lorem lorem lorem lorem lorem loerm lorem lorem lorem lorem lroe  des skdjf sd this des es more funnty videieo s in this channel so far'
          }
          ,

               {
'name':'عبدالرحيم حسن' ,
'address':"الخرطوم" ,
'job':'سباك' ,
'img':'assets/images/contact_us.png',
'email':'abdo@gmail.com',
'phone':'0534874525',
'desc':'lorem lorem lotem lorem lorem lorem lorem lorem loerm lorem lorem lorem lorem lroe  des skdjf sd this des es more funnty videieo s in this channel so far'
          },
          {
'name':'عبدالرحيم حسن' ,
'address':"الخرطوم" ,
'job':'سباك' ,
'img':'assets/images/contact_us.png',
'email':'sdljflkjsdkfljsdfkjsdfsdfsdfsdkdsfj@gmail.com',
'phone':'0534874525',
'desc':'lorem lorem lotem lorem lorem lorem lorem lorem loerm lorem lorem lorem lorem lroe  des skdjf sd this des es more funnty videieo s in this channel so far'
          }
        ];
        // if(productType == ProductType.LATEST_PRODUCT) {
        //   productList = prodProvider.lProductList;
        // }
        // else if(productType == ProductType.FEATURED_PRODUCT) {
        //   productList = prodProvider.featuredProductList;
        // }else if(productType == ProductType.TOP_PRODUCT) {
        //   productList = prodProvider.latestProductList;
        // }else if(productType == ProductType.BEST_SELLING) {
        //   productList = prodProvider.latestProductList;
        // }else if(productType == ProductType.NEW_ARRIVAL) {
        //   productList = prodProvider.latestProductList;
        // }

        // else if(productType == ProductType.SELLER_PRODUCT) {
        //   productList = prodProvider.sellerProductList;
        //   print('==========>Product List ==${prodProvider.firstLoading}====>${productList.length}');
        // }

        // print('========hello hello===>${productList.length}');

        return Column(children: [


          !JobsProvider.isJobsLoading ? 
          
          JobsProvider.jobs.length != 0 ?

          ListView.builder(
           itemCount: isJobsHome?
           
            JobsProvider.userJobs.length>4?
            4:
            JobsProvider.userJobs.length
            :
            JobsProvider.userJobs.length,
            itemBuilder: (BuildContext context, int index) {
              return  JobContainer( 

  image:JobsProvider.userJobs[index].profilePhoto,
   name:JobsProvider.userJobs[index].name,
   job:JobsProvider.userJobs[index].job.toString(),
   desc:JobsProvider.userJobs[index].des,
   email:JobsProvider.userJobs[index].email,
   phone:JobsProvider.userJobs[index].phoneNumber,
   address:"${JobsProvider.userJobs[index].region.toString()} - ${JobsProvider.userJobs[index].city.toString()}"
              );
              
              
              //  ProductWidgetSimple(productModel: productList[index]);
            },
              padding: EdgeInsets.all(0),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          )

          //  StaggeredGridView.countBuilder(
          //   itemCount: isHomePage? productList.length>4?
          //   4:productList.length:productList.length,
          //   crossAxisCount: 2,
          //   padding: EdgeInsets.all(0),
          //   physics: NeverScrollableScrollPhysics(),
          //   shrinkWrap: true,
          //   staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
          //   itemBuilder: (BuildContext context, int index) {
          //     return ProductWidget(productModel: productList[index]);
          //   },
          // )
          
          
           : SizedBox.shrink():
          //  SizedBox.shrink()  
            JobShimmer(isHomePage: false ,isEnabled: JobsProvider.isLoading)
            
            ,





          JobsProvider.filterIsLoading ?
           Center(child: Padding(
            padding: EdgeInsets.all(Dimensions.ICON_SIZE_EXTRA_SMALL),
            child: CircularProgressIndicator(valueColor: 
            AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
          )
          ) : SizedBox.shrink(),

        ]);
      },
    );
  }
}

