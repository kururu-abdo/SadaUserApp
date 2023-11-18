import 'package:eamar_user_app/view/basewidget/no_internet_screen.dart';
import 'package:eamar_user_app/view/screen/home/home_screens.dart';
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
  final ScrollController? scrollController;
  final String? sellerId;
  JobsView({required this.isJobsHome, 
  
  
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
       
        return Column(children: [


          JobsProvider.isJobsLoading ? 
           JobShimmer(isHomePage: isJobsHome ,isEnabled: JobsProvider.isJobsLoading)
            :
          JobsProvider.userJobs.length > 0 ?

          ListView.builder(
            controller: homeScrollController,
           itemCount:
            // isJobsHome?
           
            // JobsProvider.userJobs.length>4?
            // 4:
            // JobsProvider.userJobs.length
            // :
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

         
          
           :  
          // SizedBox.shrink() 
           NoInternetOrDataScreen(isNoInternet: false)
          //  SizedBox.shrink()  
           
            
            ,





          JobsProvider.isJobsLoading ?
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

