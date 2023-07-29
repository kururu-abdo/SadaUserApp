import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:eamar_user_app/localization/language_constrants.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:eamar_user_app/utill/dimensions.dart';
import 'package:eamar_user_app/view/basewidget/title_row.dart';
import 'package:eamar_user_app/view/screen/product/specification_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';


class ProductSpecification extends StatelessWidget {
  final String productSpecification;
  ProductSpecification({required this.productSpecification});

  @override
  Widget build(BuildContext context) {




    if(Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    return Column(
      children: [
        TitleRow(title: getTranslated('specification', context), isDetailsPage: true,),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),


        productSpecification.isNotEmpty ?
        Expanded(child: Html(data: productSpecification,
          // tagsList: Html.tags,
          // customRenders: {
          //   tableMatcher(): tableRender(),
          // },
          style: {
            "table": Style(
              backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
            ),
            "tr": Style(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            "th": Style(
              padding: HtmlPaddings.all(6),
              backgroundColor: Colors.grey,
            ),
            "td": Style(
              padding: HtmlPaddings.all(6),
              alignment: Alignment.topLeft,
            ),

          },),
        ) :
        Center(child: Text('No specification')),
        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),


        InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SpecificationScreen(specification: productSpecification))),
            child: Text(getTranslated('view_full_detail', context)!,
              style: titleRegular.copyWith(color: Theme.of(context).primaryColor),))

      ],
    );
  }
}
