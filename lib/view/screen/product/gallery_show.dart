import 'package:eamar_user_app/provider/splash_provider.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/view/screen/product/widget/download_image_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';


class GalleryExampleItem {
  GalleryExampleItem({
    required this.id,
    required this.resource,
    this.isSvg = false,
  });

  final String id;
  final String resource;
  final bool isSvg;
}



class MyAppGalleryView extends StatefulWidget {
  final String? product;
  final List<String>? images;

  const MyAppGalleryView({super.key, this.product, this.images});

  @override
  State<MyAppGalleryView> createState() => _MyAppGalleryViewState();
}

class _MyAppGalleryViewState extends State<MyAppGalleryView> {


  List<GalleryExampleItem> galleryItems=[];

int _selectedImage=0;
 void goBack(){
    scaleStateController!.scaleState = PhotoViewScaleState.originalSize;
  }
@override
  void initState() {

    super.initState();
    scaleStateController = PhotoViewScaleStateController();

Future.microtask(() {
widget.images!.forEach((element) {




  
   galleryItems.add(
    GalleryExampleItem(
    id: "${element}",
    resource: "${element}",
    isSvg: false
  ),
   );
});

setState(() {
  
});
});

controller 

=PhotoViewController()
..outputStateStream.listen(listener);

  }

  PhotoViewScaleStateController? scaleStateController;

    PhotoViewController? controller;
    // = PhotoViewController();
  double? scaleCopy;

 void listener(PhotoViewControllerValue value){
    setState((){
      scaleCopy = value.scale;
    });
  }

    @override
  void dispose() {

scaleStateController!.dispose();
controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar( 

        backgroundColor: Colors.transparent,


leading: IconButton(onPressed: 
(){
  Navigator.pop(context);
}

, icon: Icon(
  Icons.close 
)),

title: Text(
  '${widget.product}'
),
centerTitle: true, 
elevation: 0,

      ),

body: SizedBox.expand(

  child: Stack(
alignment: Alignment.center,
    children: [

PhotoView(
  scaleStateController: scaleStateController,
      imageProvider: NetworkImage(
         '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.productImageUrl}'
            
            +'/'+
        
        
        galleryItems[_selectedImage].resource),
    ),





 Positioned(
  top: 16, right: 16,
   child: GestureDetector(
    onTap: (){

       Navigator.of(context).push(
                          MaterialPageRoute(builder: (_)=> ProductImageDownload(
                            imageUrl: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.productImageUrl}/${widget.images![_selectedImage]}'
                          )   )
                        );
    },
     child: Card(
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
   ),
 ),

      Positioned(
        bottom: 30,
        
        child: 

        Row(

          children: 
          
          
          galleryItems.asMap()
          .map((i, image) => 
          
          
          
          MapEntry(
            
            i, 
            
            
            GestureDetector(
              onTap: (){
                _selectedImage= i;
                setState(() {
                  
                });
                goBack();
              },
              child: Container(
            
            height: 150,   width:  100,
            margin: EdgeInsets
            .symmetric(
              horizontal: 5
            ),
            
            decoration: BoxDecoration(
            
            
              border: 
              _selectedImage==i ?
              Border.all(
                width: 1 ,color: Theme.of(context).primaryColor
              ):null ,
            
            
              image: DecorationImage(image: 
              
              NetworkImage(
                  '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.productImageUrl}'
              
              +'/'+
                    
                    
                    galleryItems[i].resource
              )
              
              
              )
            ),
            
            
            
            
            
              ),
            )
            )
          ).values.toList()
          
          
          
          ,
        )
      
      )
    ],
  ),
),








    );
  }
}