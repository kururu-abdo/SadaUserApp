import 'package:eamar_user_app/helper/product_type.dart';
import 'package:eamar_user_app/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/provider/search_provider.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/view/basewidget/button/custom_button.dart';
import 'package:provider/provider.dart';

class FilterCategoryProductsBottomSheet extends StatefulWidget {
  final ProductType? productType;

  const FilterCategoryProductsBottomSheet({super.key, this.productType});
  @override
  _FilterCategoryProductsBottomSheetState createState() => _FilterCategoryProductsBottomSheetState();
}

class _FilterCategoryProductsBottomSheetState extends State<FilterCategoryProductsBottomSheet> {
  final TextEditingController _firstPriceController = TextEditingController();
  final FocusNode _firstFocus = FocusNode();
  final TextEditingController _lastPriceController = TextEditingController();
  final FocusNode _lastFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

        Consumer<ProductProvider>(
          builder: (context, search, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [

              SizedBox(child: Row(
                children: [
                  Text(getTranslated('PRICE_RANGE', context)!,
                      style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                    SizedBox(width: Dimensions.PADDING_SIZE_LARGE,),


                  Expanded(child: TextField(
                    onTapOutside: (event){
                         FocusScope.of(context).unfocus();
                      },
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => FocusScope.of(context).requestFocus(_lastFocus),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    focusNode: _firstFocus,
                    controller: _firstPriceController,
                    style: titilliumBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                    decoration: new InputDecoration(
                      hintText: getTranslated('min', context),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Theme.of(context).primaryColor)),),
                      ),
                    ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Text(getTranslated('to', context)!),),




                  Expanded(child: Center(
                    child: TextField(

                      onTapOutside: (event){
                         FocusScope.of(context).unfocus();
                      },
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      controller: _lastPriceController,
                      maxLines: 1,
                      focusNode: _lastFocus,
                      textInputAction: TextInputAction.done,
                      style: titilliumBold.copyWith(
                        fontSize: Dimensions.FONT_SIZE_SMALL,
                          ),
                          decoration: new InputDecoration(
                            hintText: getTranslated('max', context),
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Theme.of(context).primaryColor)),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              Divider(),

              _availableColor(),
  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              Divider(),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

              Text(getTranslated('SORT_BY', context)!,
                style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
              ),

              MyCheckBox(title: getTranslated('latest_products', context), index: 0),
              MyCheckBox(title: getTranslated('alphabetically_az', context), index: 1),
              MyCheckBox(title: getTranslated('alphabetically_za', context), index: 2),
              MyCheckBox(title: getTranslated('low_to_high_price', context), index: 3),
              MyCheckBox(title: getTranslated('high_to_low_price', context), index: 4),



              Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: CustomButton(
                  buttonText: getTranslated('APPLY', context),
                  onTap: () {
                    double minPrice = 0.0;
                    double maxPrice = 0.0;
                    if(_firstPriceController.text.isNotEmpty && _lastPriceController.text.isNotEmpty) {
                      minPrice = double.parse(_firstPriceController.text);
                      maxPrice = double.parse(_lastPriceController.text);
                    }
if (widget.productType!=null) {
  Provider.of<ProductProvider>(context, listen: false).sortMenuProductList(minPrice, 
                    maxPrice);

}else {
Provider.of<ProductProvider>(context, listen: false).sortSearchList(minPrice, 
                    maxPrice);

}

                    


                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),

      ]),
    );
  }
 Widget _colorWidget(Color color, {bool isSelected = false}) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: color.withAlpha(150),
      child: isSelected
          ? Icon(
              Icons.check_circle,
              color: color,
              size: 18,
            )
          : CircleAvatar(radius: 7, backgroundColor: color),
    );
  }
  Widget _availableColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: 
          getLang(context)=="ar"?
          "الالوان":
          "Available Colors",
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _colorWidget(Colors.white, ),
            SizedBox(
              width: 30,
            ),
            _colorWidget(Colors.black),
            SizedBox(
              width: 30,
            ),
            _colorWidget(Color(0xFFFFD700),isSelected: true),
            SizedBox(
              width: 30,
            ),
            _colorWidget(Color(0xFFC0C0C0)),
         
          ],
        )
      ],
    );
  }
}

class MyCheckBox extends StatelessWidget {
  final String? title;
  final int index;
  MyCheckBox({required this.title, required this.index});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile.adaptive(
      title: Text(title!, style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
      checkColor: Theme.of(context).primaryColor,
      activeColor: Colors.transparent,
      value: Provider.of<ProductProvider>(context).filterIndex == index,
      onChanged: (isChecked) {
        if(isChecked!) {
          Provider.of<ProductProvider>(context, listen: false).setFilterIndex(index);
        }
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}

class TitleText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  const TitleText(
      {Key? key,
      this.text,
      this.fontSize = 18,
      this.color = const Color(0xff1d2635),
      this.fontWeight = FontWeight.w800})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text!,
        style:TextStyle(
            fontSize: fontSize, fontWeight: fontWeight, color: color));
  }
}