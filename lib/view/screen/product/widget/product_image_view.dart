import 'dart:developer';

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
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class ProductImageView extends StatefulWidget {
  final Product productModel;
  ProductImageView({@required this.productModel});

  @override
  State<ProductImageView> createState() => _ProductImageViewState();
}

class _ProductImageViewState extends State<ProductImageView> {
  final PageController _controller = PageController();
 Offset _startingFocalPoint;

   Offset _previousOffset;

  Offset _offset = Offset.zero;

   double _previousZoom;

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
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          child: widget.productModel.images !=null ?
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 300],
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
                child: widget.productModel.images != null?

                PageView.builder(
                  controller: _controller,
                  itemCount: widget.productModel.images.length,
                  itemBuilder: (context, index) {
                    return
                      FadeInImage.assetNetwork(fit: BoxFit.cover,
                        placeholder: Images.placeholder, height: MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width,
                        image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls.productImageUrl}/${widget.productModel.images[index]}',
                        imageErrorBuilder: (c, o, s) => Image.asset(
                          Images.placeholder, height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,fit: BoxFit.cover,
                        ),
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
                      child: Text('${Provider.of<ProductDetailsProvider>(context).imageSliderIndex+1}'+'/'+'${widget.productModel.images.length.toString()}'),
                    ):SizedBox(),
                  ],
                ),
              ),
              Positioned(top: 16, right: 16,
                child: Column(
                  children: [
                    FavouriteButton(
                      backgroundColor: ColorResources.getImageBg(context),
                      favColor: Colors.redAccent,
                      isSelected: Provider.of<WishListProvider>(context,listen: false).isWish,
                      productId: widget.productModel.id,
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),


                    InkWell(
                      onTap: () {
                        if(Provider.of<ProductDetailsProvider>(context, listen: false).sharableLink != null) {
                          Share.share(Provider.of<ProductDetailsProvider>(context, listen: false).sharableLink);
                        }
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        child: Container(width: 30, height: 30,
                          decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.share, color: Theme.of(context).cardColor, size: Dimensions.ICON_SIZE_SMALL),
                        ),
                      ),
                    )
                  ],
                ),
              ),


              widget.productModel.unitPrice !=null && widget.productModel.discount != 0 ?
              Positioned(
                left: 0,top: 0,
                child: Column(
                  children: [
                    Container(width: 100, height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(Dimensions.PADDING_SIZE_SMALL))
                      ),
                      child: Text('${PriceConverter.percentageCalculation(context, widget.productModel.unitPrice,
                          widget.productModel.discount, widget.productModel.discountType)}',
                        style: titilliumRegular.copyWith(color: Theme.of(context).cardColor, fontSize: Dimensions.FONT_SIZE_LARGE),
                      ),
                    ),

                  ],
                ),
              ) : SizedBox.shrink(),
              SizedBox.shrink(),


            ]),
          ):SizedBox(),
        ),

      ],
    );
  }

  List<Widget> _indicators(BuildContext context) {
    List<Widget> indicators = [];
    for (int index = 0; index < widget.productModel.images.length; index++) {
      indicators.add(TabPageSelectorIndicator(
        backgroundColor: index == Provider.of<ProductDetailsProvider>(context).imageSliderIndex ?
        Theme.of(context).primaryColor : ColorResources.WHITE,
        borderColor: ColorResources.WHITE,
        size: 10,
      ));
    }
    return indicators;
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

  final double zoom;
  final Offset offset;
  final MaterialColor swatch;
  final bool forward;
  final bool scaleEnabled;
  final bool tapEnabled;
  final bool doubleTapEnabled;
  final bool longPressEnabled;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero) * zoom + offset;
    final double radius = size.width / 2.0 * zoom;
    final Gradient gradient = RadialGradient(
      colors: forward
        ? <Color>[swatch.shade50, swatch.shade900]
        : <Color>[swatch.shade900, swatch.shade50],
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
