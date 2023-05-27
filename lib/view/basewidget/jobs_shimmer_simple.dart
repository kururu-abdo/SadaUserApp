import 'package:flutter/material.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:shimmer/shimmer.dart';

class JobShimmer extends StatelessWidget {
  final bool isEnabled;
  final bool isHomePage;
  JobShimmer({required this.isEnabled, required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return 
    
    ListView.builder(
      itemCount: 4,
        padding: EdgeInsets.all(0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return 
        

        Container(
        constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width
      ),
      //  height: 
      //   MediaQuery.of(context).size.width/1.5  ,
        
        // MediaQuery.of(context).size.width/1.5,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).highlightColor,
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)],
        ),
    child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            enabled: isEnabled,



  
child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [

Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisSize: MainAxisSize.min,
  children: [
Container(
  height: 50,
  width: 50,
  decoration: BoxDecoration(
    shape: BoxShape.circle,color: Colors.white
    // border: Border.all(
    //   width: 1.5,color: Theme.of(context).primaryColor
    // )
  ),
 


),
SizedBox(width: 5,),
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
      Container(height: 20, width: 50, color: Colors.white),
SizedBox(height: 10,),
  Container(height: 20, width: 50, color: Colors.white),
SizedBox(height: 10,),

  Container(height: 20, width: 80, color: Colors.white),

  ],
)


  ],
) ,

SizedBox(height: 10,),
  Container(height: 60, width: 300, color: Colors.white),
SizedBox(height: 10,),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,

  children: [



  Container(height: 20, width: 50, color: Colors.white),





  Container(height: 50, width: 80,
  
   decoration: BoxDecoration(
     color: Colors.white,borderRadius: BorderRadius.circular(10)
   ),
   
   ),




  ],
)





  ],
),


),
    
        )
        
        
        ;
      },
    );
    GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (1 / 1.5),
      ),
      itemCount: 4,
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).highlightColor,
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 5)],
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            enabled: isEnabled,
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              // Product Image
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorResources.getIconBg(context),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  ),
                ),
              ),

              // Product Details
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 20, color: Colors.white),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      Row(children: [
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Container(height: 20, width: 50, color: Colors.white),
                          ]),
                        ),
                        Container(height: 10, width: 50, color: Colors.white),
                        Icon(Icons.star, color: Colors.orange, size: 15),
                      ]),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
//////////////////