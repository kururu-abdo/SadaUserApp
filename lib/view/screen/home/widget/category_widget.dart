import 'package:cached_network_image/cached_network_image.dart';
import 'package:eamar_user_app/utill/sizes.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/data/model/response/category.dart';
import 'package:eamar_user_app/provider/splash_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:provider/provider.dart';
class CategoryWidget extends StatelessWidget {
  final Category category;
  const CategoryWidget({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 

    Column( children: [
      Container(
        height:
        isTablet(context)?
         MediaQuery.of(context).size.width/7:
         MediaQuery.of(context).size.width/5,
        width: MediaQuery.of(context).size.width/5,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.2)),
          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
          color: Theme.of(context).highlightColor,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
          child:
          
          CachedNetworkImage(
            fit: BoxFit.cover,
            cacheKey: category.icon,
       imageUrl:'${Provider.of<SplashProvider>(context,listen: false).baseUrls!.categoryImageUrl}'
                '/${category.icon}',
      //  progressIndicatorBuilder: (context, url, downloadProgress) => 

      //          CircularProgressIndicator(value: downloadProgress.progress),
      
      
       errorWidget: (context, url, error) =>Image.asset(Images.placeholder, fit: BoxFit.cover,),
placeholder: (context ,child)=>Image.asset(
  Images.placeholder, 
  fit: BoxFit.cover,
),
    )
          
          //  FadeInImage.assetNetwork(
          
          //   fit: BoxFit.cover,
          //   placeholder: Images.placeholder,
          //   image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.categoryImageUrl}'
          //       '/${category.icon}',
          //   imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover,),
          // ),
        ),
      ),

      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      Container(
        child: Center(
          child: Text(category.name!,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
                color: ColorResources.getTextTitle(context)),
          ),
        ),
      ),

    ])
    ;
  }
}
