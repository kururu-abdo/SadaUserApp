import 'dart:developer';
import 'dart:io';

import 'package:eamar_user_app/view/screen/product/gallery_show.dart';
import 'package:eamar_user_app/view/screen/product/widget/download_image_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/data/model/response/product_model.dart';
import 'package:eamar_user_app/helper/price_converter.dart';
import 'package:eamar_user_app/provider/product_details_provider.dart';
import 'package:eamar_user_app/provider/splash_provider.dart';
import 'package:eamar_user_app/provider/theme_provider.dart';
import 'package:eamar_user_app/provider/wishlist_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/utill/images.dart';
import 'package:eamar_user_app/view/screen/product/widget/favourite_button.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_watermark/image_watermark.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;

import '../../../../data/datasource/remote/chache/app_path_provider.dart';
import '../../../../helper/firebase_dynamic_links_services.dart';
class ProductImageView2 extends StatefulWidget {
  final Product? productModel;
  ProductImageView2({required this.productModel});

  @override
  State<ProductImageView2> createState() => _ProductImageViewState();
}

class _ProductImageViewState extends State<ProductImageView2>   with TickerProviderStateMixin {

  late TransformationController  transformationController;
  final PageController _controller = PageController();
late AnimationController animationController;
Animation<double>? animation;
late Animation<Matrix4> animation2;
final _transformationController = TransformationController();
late TapDownDetails _doubleTapDetails;
void _handleDoubleTapDown(TapDownDetails details) {
  _doubleTapDetails = details;
}

void _handleDoubleTap() {
  if (_transformationController.value != Matrix4.identity()) {
    _transformationController.value = Matrix4.identity();
  } else {
    final position = _doubleTapDetails.localPosition;
    // For a 3x zoom
    _transformationController.value = Matrix4.identity()
      ..translate(-position.dx * 2, -position.dy * 2)
      ..scale(3.0);
    // Fox a 2x zoom
    // ..translate(-position.dx, -position.dy)
    // ..scale(2.0);
  }
}
 late Offset _startingFocalPoint;

   late Offset _previousOffset;

  Offset _offset = Offset.zero;

   late double _previousZoom;

  double _zoom = 1.0;

  int _currentIndex=0;
 void _handleScaleStart(ScaleStartDetails details) {

   log( details.focalPoint.toString());
    setState(() {
      _startingFocalPoint = details.focalPoint;
      _previousOffset = _offset;
      _previousZoom = _zoom;
    });
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _zoom = _previousZoom * details.scale;

      // Ensure that item under the focal point stays in the same place despite zooming
      final Offset normalizedOffset = (_startingFocalPoint - _previousOffset) / _previousZoom;
      _offset = details.focalPoint - normalizedOffset * _zoom;
    });
  }
   static const List<MaterialColor> kSwatches = <MaterialColor>[
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
  ];
  int _swatchIndex = 0;
  MaterialColor _swatch = kSwatches.first;
  MaterialColor get swatch => _swatch;
 bool _forward = true;
  bool _scaleEnabled = true;
  bool _tapEnabled = true;
  bool _doubleTapEnabled = true;
  bool _longPressEnabled = true;
  void _handleScaleReset() {
    setState(() {
      _zoom = 1.0;
      _offset = Offset.zero;
    });
  }


//     _downloadImage(String imageurl)async{

// final ByteData imageData = await NetworkAssetBundle(Uri.parse(imageurl)).load("");

// final Uint8List bytes = imageData.buffer.asUint8List();





// //     final response = await http.Client().get(Uri.parse(imageurl));
// // final bytes = response.bodyBytes;
// File tmp =new File(AppPathProvider.path+"/"+DateTime.now().millisecondsSinceEpoch.toString()+".png");
// await tmp.writeAsBytes(bytes);




//   img.Image image = img.Image(320, 240);
  
// // final image = await decodeImageFromList(bytes);
// var image2=  img.drawString(image, img.BitmapFont.fromFnt('Cairo', image),
  
//  300 ,
//  240 ,

//  'صدى الاعمار', 
//  );

// var watermarkedImg = await ImageWatermark.addTextWatermarkCentered(
//                         imgBytes:  bytes,             ///image bytes
//                           watermarktext:'صدى الاعمار',      ///watermark text

//                           color: Colors.white.withOpacity(.5), ///default : Colors.white
//                         );



// // await tmp.writeAsBytes(img.encodePng(image2));

// await tmp.writeAsBytes(watermarkedImg);

// GallerySaver.saveImage(tmp.path).then(( path) {
//                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
// 'Image Saved'
//                 ), backgroundColor: Colors.green));

//         });
//   }

@override
void initState() { 
  super.initState();
         transformationController = TransformationController();
  animationController =
       AnimationController(vsync: this, duration: const Duration(milliseconds: 200))
       ..addListener(() {
         transformationController.value = animation2.value;
       });
   animation =
       CurveTween(curve: Curves.fastOutSlowIn).animate(animationController);






}
void _showOverlay(BuildContext context ,index) async {
   OverlayState overlayState = Overlay.of(context);
   OverlayEntry overlayEntry;


var renderbox = context.findRenderObject() as RenderBox;
var offset =renderbox.localToGlobal(Offset.zero);
var size  =  MediaQuery.of(context).size;

   overlayEntry = OverlayEntry(builder: (context) {
     return   Positioned(
       left: offset.dx,
       top: offset.dy,
       
       width: size.width,
       child: 
     _buildImage(index));
   }
      
     );
  
  
  
   
 
  //  await Future.delayed(const Duration(seconds: 3))
  //      .whenComplete(() => animationController.reverse())
  //      // removing overlay entry after stipulated time.
  //      .whenComplete(() => overlayEntry.remove());
 }
@override
void dispose() { 
    animationController.dispose();
  transformationController.dispose();
  super.dispose();

}
  @override
  Widget build(BuildContext context) {
    // _getImageWidget('${Provider.of<SplashProvider>(context,listen: false).baseUrls.productImageUrl}/${widget.productModel.images[_currentIndex]}');

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          child: widget.productModel!.images!.isNotEmpty ?
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              // boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 300],
              //     spreadRadius: 1, blurRadius: 5)],
              // gradient: Provider.of<ThemeProvider>(context).darkTheme ? null : LinearGradient(
              //   colors: [ColorResources.WHITE, ColorResources.IMAGE_BG],
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              // ),
            ),
            child: Stack(children: [
              SizedBox(
                height: MediaQuery.of(context).size.width,
                child: widget.productModel!.images !.isNotEmpty?

                PageView.builder(
                  controller: _controller,
                  itemCount: widget.productModel!.images!.length,
                  itemBuilder: (context, index) {

                    return
                      Hero(
                        tag: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.productImageUrl}/${widget.productModel!.images![index]}',
                        child: 
                        _buildImage(index)
                     
                     
                      );
                    
          //             GestureDetector(
          //         onTap: (){
          //           log('sdfsdfsdf');
          //         },
          //          onScaleStart: _scaleEnabled ? _handleScaleStart : null,
          // onScaleUpdate: _scaleEnabled ? _handleScaleUpdate : null,
               
               
               
               
          //         child: CustomPaint(
          //           painter: _GesturePainter(
          //     zoom: _zoom,
          //     offset: _offset,
          //     swatch: swatch,
          //     forward: _forward,
          //     scaleEnabled: _scaleEnabled,
          //     tapEnabled: _tapEnabled,
          //     doubleTapEnabled: _doubleTapEnabled,
          //     longPressEnabled: _longPressEnabled,
          //   ),
          //             child: FadeInImage.assetNetwork(fit: BoxFit.cover,
          //               placeholder: Images.placeholder, height: MediaQuery.of(context).size.width,
          //               width: MediaQuery.of(context).size.width,
          //               image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls.productImageUrl}/${widget.productModel.images[index]}',
          //               imageErrorBuilder: (c, o, s) => Image.asset(
          //                 Images.placeholder, height: MediaQuery.of(context).size.width,
          //                 width: MediaQuery.of(context).size.width,fit: BoxFit.cover,
          //                 scale: _zoom,
          //               ),
          //             ),
          //           ));
                  },
                  onPageChanged: (index) {
                  
                    setState(() {
                        _currentIndex=index;
                    });
                    Provider.of<ProductDetailsProvider>(context, listen: false).setImageSliderSelectedIndex(index);
                  },
                ):SizedBox(),
              ),


              Positioned(left: 0, right: 0, bottom: 30,
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(),
                    Spacer(),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: _indicators(context),
                    ),
                    Spacer(),


                    Provider.of<ProductDetailsProvider>(context).imageSliderIndex != null?
                    Padding(
                      padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_DEFAULT,bottom: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Text('${Provider.of<ProductDetailsProvider>(context).imageSliderIndex!+1}'+'/'+'${widget.productModel!.images!.length.toString()}'),
                    ):SizedBox(),
                  ],
                ),
              ),
              Positioned(top: 16, right: 16,
                child: Column(
                  children: [
                    FavouriteButton2(
                      backgroundColor: ColorResources.getImageBg(context),
                      favColor: Colors.redAccent,
                      isSelected: Provider.of<WishListProvider>(context,listen: false).isWish,
                      productId: widget.productModel!.id,
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),


                    InkWell(
                      onTap: () async{


                        DymanicLinksServices.createDynamicLink(true, widget.productModel!).then((value) async{



log(value);

var result=await FirebaseAnalytics.instance

.logShare(contentType: 'product', itemId: widget.productModel!.id.toString(), method: 'share');
result;
  Share.share(value);
                          // Share.share(Provider.of<ProductDetailsProvider>(context, listen: false).sharableLink);

                        });

                        // if(Provider.of<ProductDetailsProvider>(context, listen: false).sharableLink != null) {
                        //   Share.share(Provider.of<ProductDetailsProvider>(context, listen: false).sharableLink);
                        // }
                    
                    
                    
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        child: Container(width: 50, height: 50,
                          decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.share, color: Theme.of(context).cardColor, size: Dimensions.ICON_SIZE_SMALL),
                        ),
                      ),
                    )
                 
                 
                 ,
                 
                 
                    InkWell(
                      onTap: ()async {
                        // if(Provider.of<ProductDetailsProvider>(context, listen: false).sharableLink != null) {
                        //   Share.share(Provider.of<ProductDetailsProvider>(context, listen: false).sharableLink);
                        // }

                        // await _downloadImage('${Provider.of<SplashProvider>(context,listen: false).baseUrls.productImageUrl}/${widget.productModel.images[_currentIndex]}');
// _showOverlay(context,  '${Provider.of<SplashProvider>(context,listen: false).baseUrls.productImageUrl}/${widget.productModel.images[_currentIndex]}');
// await 

// _downloadImage( );
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_)=> ProductImageDownload(
                            imageUrl: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.productImageUrl}/${widget.productModel!.images![_currentIndex]}'
                          )   )
                        );
                      },
                      child: 
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: 
                        BorderRadius.circular(50)),
                        child: Container(width: 50, height: 50,
                          decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child:
                           Icon(Icons.download,
                            color: Theme.of(context).cardColor, 
                            size: Dimensions.ICON_SIZE_SMALL),
                        ),
                      ),
                    )
                 
                 
                 
                 
                  ],
                ),
              ),


              // widget.productModel!.unitPrice !=null && widget.productModel!.discount != 0 ?
              // Positioned(
              //   left: 0,top: 0,
              //   child: Column(
              //     children: [
              //       Container(width: 100, height: 30,
              //         alignment: Alignment.center,
              //         decoration: BoxDecoration(
              //           color: Theme.of(context).primaryColor,
              //           borderRadius: BorderRadius.only(bottomRight: Radius.circular(Dimensions.PADDING_SIZE_SMALL))
              //         ),
              //         child: Text('${PriceConverter.percentageCalculation(context, widget.productModel!.unitPrice,
              //             widget.productModel!.discount!, widget.productModel!.discountType)}',
              //           style: titilliumRegular.copyWith(color: Theme.of(context).cardColor, fontSize: Dimensions.FONT_SIZE_LARGE),
              //         ),
              //       ),

              //     ],
              //   ),
              // ) : SizedBox.shrink(),
              SizedBox.shrink(),


            ]),
          ):SizedBox(),
        ),
 


//  Visibility(
// visible: widget.productModel!.images!.isNotEmpty,

//    child: Container(
//      height: 120,      color: Theme.of(context).cardColor,
//      width: double.infinity,
//      child: 
     
     
     
//      ListView.builder(
//        scrollDirection: Axis.horizontal,
//          padding: const EdgeInsets.all(8),
//       itemCount: widget.productModel!.images!.length,
//       itemBuilder: (BuildContext context, int index) { 
//  return 
//          GestureDetector(
//            onTap: (){   
//               setState(() {
//                           _currentIndex=index;
//                       });
//                    _controller.jumpToPage(_currentIndex);
//                       Provider.of<ProductDetailsProvider>(context, listen: false).setImageSliderSelectedIndex(index);
//            },
//            child: Card(
//          shape: RoundedRectangleBorder(
//               borderRadius:
//                  index == Provider.of<ProductDetailsProvider>(context).imageSliderIndex?
//                   BorderRadius.circular(20):   BorderRadius.zero ,
//          ),
         
//              elevation:index == Provider.of<ProductDetailsProvider>(context).imageSliderIndex ?2:0 ,
//              child: Container(
//                width: 100,
//                height: 100, 
                
//                decoration: BoxDecoration( color: Theme.of(context).highlightColor,
//               //  boxShadow: index == Provider.of<ProductDetailsProvider>(context).imageSliderIndex ?
//                borderRadius:   BorderRadius.circular(20),
//               //  [
//               //    BoxShadow(
//               //      blurRadius: 1 ,
//               //      offset: Offset(0, 1),
//               //      spreadRadius: 1 ,
//               //     //  color: Theme.of(context).colorScheme.shadow,
                  
//               //    )
//               //  ]:null
//               //  ,
              
//                  image: DecorationImage(image: NetworkImage('${Provider.of<SplashProvider>(context,listen: false).baseUrls!.productImageUrl}/${ widget.productModel!.images![index]}'),
//                  fit: BoxFit.cover
                 
//                  )
//                ),
//                margin: EdgeInsets.all(10),
//               //  padding:
//               //  EdgeInsets.all(10), 
//              ),
//            ),
//          );
//       })
//       //  children: widget.productModel.images.map((e) => 
       
//       //  Center(
//       //    child: 
 
//       //    Container(
//       //      width: 100,
//       //      height: 100, 
       
//       //      decoration: BoxDecoration( color: Theme.of(context).highlightColor,
//       //        borderRadius: BorderRadius.circular(20) ,
//       //        image: DecorationImage(image: NetworkImage('${Provider.of<SplashProvider>(context,listen: false).baseUrls.productImageUrl}/${e}'))
//       //      ),
//       //      margin: EdgeInsets.all(10),
//       //      padding:
//       //      EdgeInsets.all(10), 
//       //    ),
       
//       //  )
//       //  ).toList(),
//     //  ),
//    ),
//  )
   
   
   
      ],
    );
  }

  List<Widget> _indicators(BuildContext context) {
    List<Widget> indicators = [];
    for (int index = 0; index < widget.productModel!.images!.length; index++) {
      indicators.add(TabPageSelectorIndicator(
        backgroundColor: index == Provider.of<ProductDetailsProvider>(context).imageSliderIndex ?
        Theme.of(context).primaryColor : ColorResources.WHITE,
        borderColor: ColorResources.WHITE,
        size: 10,
      ));
    }
    return indicators;
  }



  var _repaintKey =GlobalKey();
_getImageWidget( String
  
  imageUrl){


                         
     var widge=                      Center(
       child: RepaintBoundary(
                                             key: _repaintKey,
                                child: Stack(
                                  children: [
                                    Hero(
                                      tag: imageUrl ,
                                      child: FadeInImage.assetNetwork(fit: BoxFit.cover,
                                        placeholder: Images.placeholder, height: MediaQuery.of(context).size.width,
                                        width: MediaQuery.of(context).size.width,
                                        image: '$imageUrl' ,
                                        //'${Provider.of<SplashProvider>(context,listen: false).baseUrls.productImageUrl}/${widget.imageUrl}'
                                        imageErrorBuilder: (c, o, s) => Image.asset(
                                          Images.placeholder, height: MediaQuery.of(context).size.width,
                                          width: MediaQuery.of(context).size.width,fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
              
              
                                    Align(
              
                                      alignment: Alignment.center,
                                      child: Transform.rotate(angle: 120,
                                      child: Text('صدى الاعمار ' ,
                                      
                                      style: TextStyle(
                                        fontSize: 50 ,fontWeight: FontWeight.bold ,
          wordSpacing: 2,
                                        color: Colors.white.withOpacity(.7)
                                      ),
                                      ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
     );
                          
return widget;


}
_downloadImage()
 async{





log('HERE');


try {
  
  RenderRepaintBoundary boundary =
                    _repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
ui.Image image = await boundary.toImage();
ByteData byteData = (await image.toByteData(format: ui.ImageByteFormat.png))!;
Uint8List pngBytes = byteData.buffer.asUint8List();

final String path =await   AppPathProvider.createFolderInAppDocDir("screenshots");
// _checkPermission();
//AppPathProvider
//  String documentsPath = '/storage/emulated/0/Documents';
//  if (Platform.isIOS) {
//   Directory path = await getApplicationDocumentsDirectory();
//   documentsPath = path.path;
// }
// var myfil=await File(AppPathProvider.path+"/"+DateTime.now().millisecondsSinceEpoch.toString()+".png").writeAsBytes(pngBytes);
//  final imagePath = await File('${path.path}/${DateTime.now().millisecondsSinceEpoch.toString()+".png"}').create();
 
//  ${path}
 final imagePath = await File('${AppPathProvider.path}/${DateTime.now().millisecondsSinceEpoch.toString()+".png"}')
 .writeAsBytes(pngBytes  ,flush: true);

 
var newFile=await imagePath.create(recursive: true);
 GallerySaver.saveImage(newFile.path).then(( path) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
'Image Saved'
                ), backgroundColor: Colors.green));

        });
// setState(() {
//   file =File(imagePath.path);
// });
//  var imagePath2= await imagePath.writeAsBytes(pngBytes);
log('SAVED');
log(newFile.uri.path);
} catch (e) {
  log(e.toString());
}
//show alert saved 
}



onIneractionEnd(){


  animation2 =  Matrix4Tween(
    begin: transformationController.value ,
    end:Matrix4.identity()
  ).animate(

    CurvedAnimation(parent: animationController, curve: Curves.ease)
  );
}


_buildImage(index){
final double maxScale=4;
final double minScale=1;
       return            
       
                          // PhotoView(
                            
                          //   imageProvider:    
                          //   NetworkImage('${Provider.of<SplashProvider>(context,listen: false).baseUrls.productImageUrl}/${widget.productModel.images[index]}'),
                          //  errorBuilder: (c, o, s) => Image.asset(
                          //     Images.placeholder, height: MediaQuery.of(context).size.width,
                          //     width: MediaQuery.of(context).size.width,fit: BoxFit.cover,
                          //   ),
                          //   );
                          
       
       
       
       
       
       
       
            Builder(
              builder: (context) {
                return GestureDetector(
// onPanStart:(details){
//   _handleDoubleTap();
// } ,
// onVerticalDragStart: (details){
//   _handleDoubleTap();
// },


//                      onDoubleTapDown: _handleDoubleTapDown,
//     onDoubleTap: _handleDoubleTap,


onTap: (){
  Navigator.of(context).push(
    MaterialPageRoute(builder: 
    (_)=> 
    MyAppGalleryView(

      product: widget.productModel!.name,
      images: widget.productModel!.images,


    )
    )
  );
},


    // onHorizontalDragStart: (),
    
                  child: InteractiveViewer(
                                transformationController: _transformationController,
                //                 onInteractionStart: (details){
                
                //                   log('/////////////////////////////////////////////////////////////');
                //                   log(details.pointerCount.toString());
                //                   _showOverlay(context,index);
                //                 },
                //                 onInteractionEnd: (details){
                // onIneractionEnd();
                //                 },
                                clipBehavior: Clip.none,
                                maxScale: maxScale,
                                minScale: minScale,
                                panEnabled: false,
                                child:
                
                
                                // PhotoView(
                                  
                                //   imageProvider:    
                                //   NetworkImage('${Provider.of<SplashProvider>(context,listen: false).baseUrls.productImageUrl}/${widget.productModel.images[index]}'),
                                //  errorBuilder: (c, o, s) => Image.asset(
                                //     Images.placeholder, height: MediaQuery.of(context).size.width,
                                //     width: MediaQuery.of(context).size.width,fit: BoxFit.cover,
                                //   ),
                                //   )
                                
                                 FadeInImage.assetNetwork(fit: BoxFit.cover,
                                  placeholder: Images.placeholder, height: MediaQuery.of(context).size.width,
                                  width: MediaQuery.of(context).size.width,
                                  image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.productImageUrl}/${widget.productModel!.images![index]}',
                                  imageErrorBuilder: (c, o, s) => Image.asset(
                                    Images.placeholder, height: MediaQuery.of(context).size.width,
                                    width: MediaQuery.of(context).size.width,fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                );
              }
            );
                     
}


}

class _GesturePainter extends CustomPainter {
  const _GesturePainter({
     this.zoom,
     this.offset,
     this.swatch,
     this.forward,
     this.scaleEnabled,
     this.tapEnabled,
     this.doubleTapEnabled,
     this.longPressEnabled,
  });

  final double? zoom;
  final Offset? offset;
  final MaterialColor? swatch;
  final bool? forward;
  final bool? scaleEnabled;
  final bool? tapEnabled;
  final bool? doubleTapEnabled;
  final bool? longPressEnabled;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero) * zoom! + offset!;
    final double radius = size.width / 2.0 * zoom!;
    final Gradient gradient = RadialGradient(
      colors: forward!
        ? <Color>[swatch!.shade50, swatch!.shade900]
        : <Color>[swatch!.shade900, swatch!.shade50],
    );
    final Paint paint = Paint()
      ..shader = gradient.createShader(Rect.fromCircle(
        center: center,
        radius: radius,
      ));
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(_GesturePainter oldPainter) {
    return oldPainter.zoom != zoom
        || oldPainter.offset != offset
        || oldPainter.swatch != swatch
        || oldPainter.forward != forward
        || oldPainter.scaleEnabled != scaleEnabled
        || oldPainter.tapEnabled != tapEnabled
        || oldPainter.doubleTapEnabled != doubleTapEnabled
        || oldPainter.longPressEnabled != longPressEnabled;
  }
}
