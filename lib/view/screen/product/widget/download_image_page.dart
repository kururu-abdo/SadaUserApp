import 'dart:developer';
import 'dart:io';

import 'package:eamar_user_app/data/datasource/remote/chache/app_path_provider.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
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
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'dart:ui' as ui;
class ProductImageDownload extends StatefulWidget {
String imageUrl;

  ProductImageDownload({required this.imageUrl});

  @override
  State<ProductImageDownload> createState() => _ProductImageDownloadState();
}

class _ProductImageDownloadState extends State<ProductImageDownload> {
  final PageController _controller = PageController();
 late Offset _startingFocalPoint;

   late Offset _previousOffset;

  Offset _offset = Offset.zero;

   late double _previousZoom;

  double _zoom = 1.0;
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
  var _repaintKey =GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
          getTranslated('dowlonad_image' , context)!,

             style: robotoRegular.copyWith(fontSize: 20,
                      color: Theme.of(context).cardColor)
          ),
          // backgroundColor: Colors.transparent,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios ,   color: Theme.of(context).cardColor)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: widget.imageUrl !=null ?
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                      boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 300]!,
                          spreadRadius: 1, blurRadius: 5)],
                      gradient: Provider.of<ThemeProvider>(context).darkTheme ? null : LinearGradient(
                        colors: [ColorResources.WHITE, ColorResources.IMAGE_BG],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Stack(children: [

                      SizedBox(
                        height: MediaQuery.of(context).size.width,
                        child: widget.imageUrl != null?
              
                        
                             RepaintBoundary(
                                             key: _repaintKey,
                                child: Stack(
                                  children: [
                                    Hero(
                                      tag:widget.imageUrl ,
                                      child: FadeInImage.assetNetwork(fit: BoxFit.cover,
                                        placeholder: Images.placeholder, height: MediaQuery.of(context).size.width,
                                        width: MediaQuery.of(context).size.width,
                                        image: '${widget.imageUrl}' ,
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
                                      child: Text(
                                     getTranslated('sada' , context)!      
                                      ,
                                      
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
                              )
                            
          
          
          
          
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
                        :SizedBox(),
                      ),
              


              


              SizedBox(

               
                        height: MediaQuery.of(context).size.width,
                child: Center(
                  child:
                    SizedBox(
                      height: 50,
                      width: 120,
                      child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.all(8),
                                backgroundColor:
                                // Colors.transparent,
                                 Colors.white,
                                //  Theme.of(context).highlightColor,
                                elevation: 2,
                                // foregroundColor: style.primaryColor,
                                side: BorderSide(width: 1.0, color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 5.0, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: ()async{
                    await _downloadImage();
                              },
                              child: Center(
                                child: Text(    getTranslated('dowload' , context)!      
                                      ,
                                
                                     style: TextStyle(
                        color: Colors.black, 
                        fontWeight: FontWeight.bold
                      ),
                                ),
                              ),
                      ),
                    )
                  
                  //  TextButton.icon(onPressed: ()async{
                  // await 
                  // _downloadImage();
                  //   }, icon: Icon(Icons.download , size: 30 ,color: Colors.green,), label: Text('تحميل' ,
                            
                  //   style: TextStyle(
                  //     color: Colors.green, 
                  //     fontWeight: FontWeight.bold
                  //   ),
                  //   )),
                ),
              )



                    ]),
                  ):SizedBox(),
                ),
                  //       SizedBox(height: 15,),
                  //     Center(
                  //   child: 
                  //TextButton.icon(onPressed: ()async{
                  // await 
                  // _downloadImage();
                  //   }, icon: Icon(Icons.download , size: 30 ,color: Colors.green,), label: Text('تحميل' ,
            
                  //   style: TextStyle(
                  //     color: Colors.green, 
                  //     fontWeight: FontWeight.bold
                  //   ),
                  //   )),
                  //     ) ,
                  
              // Image.file(file)
              ],
            ),
          ),
        ),
      ),
    );
  }


_checkPermission()async{

  await Permission.storage.request();
  var status = await Permission.storage.status;
if (status.isDenied || !status.isGranted) {
_checkPermission();
  // We didn't ask for permission yet or the permission has been denied before but not permanently.
}

// You can can also directly ask the permission about its status.
if (await Permission.location.isRestricted) {
  // The OS restricts access, for example because of parental controls.
}
}


_downloadImage()async{
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
//show alert saved 
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
